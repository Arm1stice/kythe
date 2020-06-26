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
pub mod analysis;

use analysis_rust_proto::*;
use std::path::PathBuf;

pub struct KytheIndexer<'a> {
    writer: &'a dyn KytheWriter,
}

impl<'a> KytheIndexer<'a> {
    pub fn new(writer: &'a dyn KytheWriter) -> Self {
        Self { writer }
    }

    pub fn index_cu(
        &mut self,
        unit: &CompilationUnit,
        root_dir: &PathBuf,
    ) -> Result<(), KytheError> {
        let cu_args = unit.get_argument();
        let mut args: Vec<String> = Vec::new();
        for (index, arg) in cu_args.iter().enumerate() {
            if arg == "" {
                // The empty string must be first argument
                args = cu_args[index+1..cu_args.len()].to_vec();
                break;
            }
        }

        let _analysis = analysis::generate_analysis(args, &root_dir)?;
        Ok(())
    }
}
