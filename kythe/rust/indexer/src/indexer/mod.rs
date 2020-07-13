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
pub mod analyzers;
pub mod entries;
pub mod save_analysis;

use analysis_rust_proto::*;
use analyzers::UnitAnalyzer;
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
        // TODO: Add information to the design doc about using UnitAnalyzer and other
        // classes to build internal state
        let mut generator = UnitAnalyzer::new(unit, self.writer, root_dir);

        // First, create file nodes for all of the source files in the CompilationUnit
        generator.emit_file_nodes()?;

        // Then, import the analysis
        let analyzed_crates = save_analysis::load_analysis(&root_dir.join("analysis"));

        // Loop through all of the crates that we loaded
        for krate in analyzed_crates {
            generator.index_crate(krate)?;
        }

        // We must flush the writer each time to ensure that all entries get written
        self.writer.flush()?;
        Ok(())
    }
}
