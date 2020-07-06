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
use storage_rust_proto::*;
use analysis_rust_proto::CompilationUnit;
use std::fs::File;
use std::io::Read;
use std::path::{Path, PathBuf};

pub fn generate_file_nodes<'a>(
    unit: &CompilationUnit,
    writer: &'a mut dyn KytheWriter,
    root_dir: &PathBuf,
) -> Result<(), KytheError> {
    // https://kythe.io/docs/schema/#file
    for source_file in unit.get_source_file() {
        let mut vname = VName::new();
        vname.set_path(source_file.clone());

        // Create language fact
        let mut language_entry = Entry::new();
        language_entry.set_source(vname.clone());
        language_entry.set_fact_name("language".into());
        language_entry.set_fact_value(b"rust".to_vec());
        writer.write_entry(language_entry)?;

        // Create text fact
        let mut text_entry = Entry::new();
        text_entry.set_source(vname.clone());
        text_entry.set_fact_name("text".into());
        // Returns a FileReadError if we can't read the file
        let mut file = File::open(root_dir.join(Path::new(&source_file)))?;
        let mut file_contents: Vec<u8> = Vec::new();
        file.read_to_end(&mut file_contents)?;
        text_entry.set_fact_value(file_contents);
        writer.write_entry(text_entry)?;
    }
    Ok(())
}
