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
use crate::writer::{KytheWriter, StreamWriter};
pub mod analysis;
pub mod util;

use analysis_rust_proto::*;
use std::path::PathBuf;

pub struct KytheIndexer<'a> {
    writer: &'a mut dyn KytheWriter,
}

impl<'a> KytheIndexer<'a> {
    pub fn new(writer: &'a mut dyn KytheWriter) -> Self {
        Self { writer }
    }

    pub fn index_cu(
        &mut self,
        unit: &CompilationUnit,
        root_dir: &PathBuf,
    ) -> Result<(), KytheError> {
        // First, create file nodes for all of the source files in the CompilationUnit
        util::generate_file_nodes(unit, self.writer, root_dir)?;
        self.writer.flush();
        // Analysis files are extracted to the analysis folder inside of the root
        // directory
        // let analysis = analysis::generate_analysis(&root_dir.join("analysis"));
        // let c = analysis.get(0).unwrap();
        // println!("{}", c.id.name);
        // let crate_analysis = &c.analysis;
        // let defs = &crate_analysis.defs;
        // println!("==Definitions==");
        // for def in defs {
        //     println!("{}", def.name);
        // }
        Ok(())
    }
}
