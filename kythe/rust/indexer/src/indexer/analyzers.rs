// Copyright 2020 The Kythe Authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

use crate::error::KytheError;
use crate::writer::KytheWriter;

use super::entries::EntryEmitter;

use analysis_rust_proto::CompilationUnit;
use rls_analysis::Crate;
use rls_data::{Def, DefKind};
use std::collections::HashMap;
use std::fs::File;
use std::io::Read;
use std::path::{Path, PathBuf};
use storage_rust_proto::*;

lazy_static! {
    static ref FILE_FACT: Vec<u8> = b"file".to_vec();
    static ref LANGUAGE_FACT: Vec<u8> = b"rust".to_vec();
}

pub struct UnitAnalyzer<'a> {
    unit: &'a CompilationUnit,
    emitter: EntryEmitter<'a>,
    root_dir: &'a PathBuf,
    file_vnames: HashMap<String, VName>,
}

pub struct CrateAnalyzer<'a, 'b> {
    emitter: &'b mut EntryEmitter<'a>,
    file_vnames: &'b HashMap<String, VName>,
    krate: Crate,
    krate_ids: HashMap<u32, String>,
}

impl<'a> UnitAnalyzer<'a> {
    pub fn new(
        unit: &'a CompilationUnit,
        writer: &'a mut dyn KytheWriter,
        root_dir: &'a PathBuf,
    ) -> Self {
        // Create a HashMap between the file path and the VName which we can retrieve
        // later to emit nodes
        let mut file_vnames = HashMap::new();
        for required_input in unit.get_required_input() {
            let analysis_vname = required_input.get_v_name();
            // The required input has a VName of type analysis_rust_proto::analysis::VName.
            // We need storage_rust_proto::storage::VName to create an Entry. Therefore, we
            // must use unsafe rust to transmute the VName.
            let storage_vname: VName = unsafe { ::std::mem::transmute(analysis_vname.clone()) };
            let path = storage_vname.get_path().to_owned();
            file_vnames.insert(path, storage_vname);
        }

        Self { unit, emitter: EntryEmitter::new(writer), root_dir, file_vnames }
    }

    pub fn emit_file_nodes(&mut self) -> Result<(), KytheError> {
        // https://kythe.io/docs/schema/#file
        for source_file in self.unit.get_source_file() {
            let vname = self.get_vname(source_file)?;

            // Create the file node fact
            self.emitter.emit_node(
                vname.clone(),
                "/kythe/node/kind".into(),
                FILE_FACT.clone(),
            )?;

            // Create language fact
            self.emitter.emit_node(
                vname.clone(),
                "/kythe/language".into(),
                LANGUAGE_FACT.clone(),
            )?;

            // Read the file contents and set it on the fact
            // Returns a FileReadError if we can't read the file
            let mut file = File::open(self.root_dir.join(Path::new(&source_file)))?;
            let mut file_contents: Vec<u8> = Vec::new();
            file.read_to_end(&mut file_contents)?;

            // Create text fact
            self.emitter.emit_node(vname.clone(), "/kythe/text".into(), file_contents)?;
        }
        Ok(())
    }

    pub fn index_crate(&mut self, krate: Crate) -> Result<(), KytheError> {
        let mut crate_analyzer = CrateAnalyzer::new(&mut self.emitter, &self.file_vnames, krate);
        crate_analyzer.emit_crate_nodes()?;
        Ok(())
    }

    /// Given a file name, returns a [Result] with the file's VName from the
    /// Compilation Unit.
    ///
    /// # Errors
    /// If the file name isn't found, a [KytheError::IndexerError] is returned.
    fn get_vname(&mut self, file_name: &str) -> Result<VName, KytheError> {
        let err_msg = format!(
            "Failed to find VName for file \"{}\" located in the save analysis. Is it included in the required inputs of the Compilation Unit?",
            file_name
        );
        let vname = self.file_vnames.get(file_name).ok_or(KytheError::IndexerError(err_msg))?;
        Ok(vname.clone())
    }

    // TODO: helper function to generate a vname with unique signature given a file
    // name and add'l info
}

impl<'a, 'b> CrateAnalyzer<'a, 'b> {
    pub fn new(
        emitter: &'b mut EntryEmitter<'a>,
        file_vnames: &'b HashMap<String, VName>,
        krate: Crate,
    ) -> Self {
        Self { emitter, file_vnames, krate, krate_ids: HashMap::new() }
    }

    /// Generates and emits package nodes for the main crate and external crates
    /// NOTE: Must be called first to populate the self.krate_ids HashMap
    pub fn emit_crate_nodes(&mut self) -> Result<(), KytheError> {
        let krate_analysis = &self.krate.analysis;
        let krate_prelude =
            &krate_analysis.prelude.as_ref().unwrap_or(KytheError::IndexerError(format!(
                "Crate \"{}\" did not have prelude data",
                &self.krate.id.name
            )))?;

        // First emit the node for our own crate and add it to the hashmap
        // TODO: Make this a better error
        let krate_id = &krate_prelude.crate_id;
        let krate_signature =
            format!("{}_{}_{}", krate_id.name, krate_id.disambiguator.0, krate_id.disambiguator.1);
        let krate_vname = EntryEmitter::vname_from_signature(&krate_signature);
        self.emitter.emit_node(krate_vname, "/kythe/node/kind".into(), b"package".to_vec())?;
        self.krate_ids.insert(0u32, krate_signature);

        // Then, do the same for all of the external crates
        for external_krate in &krate_prelude.external_crates {
            let krate_id = &external_krate.id;
            let krate_signature = format!(
                "{}_{}_{}",
                krate_id.name, krate_id.disambiguator.0, krate_id.disambiguator.1
            );
            let krate_vname = EntryEmitter::vname_from_signature(&krate_signature);
            self.emitter.emit_node(
                krate_vname,
                "/kythe/node/kind".into(),
                b"package".to_vec(),
            )?;
            self.krate_ids.insert(0u32, krate_signature);
        }

        Ok(())
    }

    pub fn emit_definitions(&mut self) -> Result<(), KytheError> {
        let analysis = &self.krate.analysis;
        for def in &analysis.defs {
            let krate_signature = self.krate_ids.get(def.id.krate).unwrap_or(
                KytheError::IndexerError(
                    format!("Definition \"{}\" referenced crate \"{}\" which was not found in the krate_ids HashMap")
                ))?;
            let def_signature = format!("{}_{}", krate_signature, def.id.index);
            
            // Generate node based on definition type

            // Generate anchor based on span
            // - Emit anchor node
            // - Emit defines/binding edge from anchor to def

            // If documentation isn't "" also generate a documents node
            // - Emit documentation type node
            // - Emit documents edge from node to def
        }
    }

    fn emit_definition_node(&mut self, signature: &str, def: &Def) -> Result<(), KytheError> {
        let node_vname = EntryEmitter::vname_from_signature(signature);
        let def_type: String;
        let fact_value: HashMap<String, Vec<u8>> = HashMap::new();
        match def.kind {
            DefKind::Function => {
                // TODO: Populate def_type
                // TODO: Insert fact/value pairs into hashmap
            }
        }
        // Emit nodes for all fact/value pairs
        Ok(())
        // TODO: Huge match statement based on DefKind
    }
}
