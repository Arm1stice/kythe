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

use kythe_rust_indexer::providers::*;

use analysis_rust_proto::*;
use anyhow::{anyhow, Context, Result};
use std::fs::File;
use std::io::Write;
use std::path::PathBuf;

pub fn extract_from_kzip(
    c_unit: &CompilationUnit,
    temp_path: &PathBuf,
    provider: &mut dyn FileProvider,
) -> Result<()> {
    for required_input in c_unit.get_required_input() {
        // Get path where we will copy the file to
        let input_path = required_input.get_info().get_path();

        // JSON files are most likely save_analysis, so we put them in the analysis
        // folder. We may want to put extra information in the CompilationUnit
        // to explicitly say what files are save_analysis.
        let input_path_buf = PathBuf::new().join(input_path);
        let output_path = match input_path_buf.extension() {
            Some(os_str) => match os_str.to_str() {
                Some("json") => {
                    temp_path.join("analysis").join(input_path_buf.file_name().unwrap())
                }
                _ => temp_path.join(input_path),
            },
            _ => temp_path.join(input_path),
        };

        // Create directories for the output path
        let parent = output_path
            .parent()
            .ok_or_else(|| anyhow!("Failed to get parent for path: {:?}", output_path))?;
        std::fs::create_dir_all(parent).with_context(|| {
            format!("Failed to create temporary directories for path: {}", parent.display())
        })?;

        // Copy the file contents to the output path in the temporary directory
        let digest = required_input.get_info().get_digest();
        let file_contents = provider.contents(digest).with_context(|| {
            format!("Failed to get contents of file \"{}\" with digest \"{}\"", input_path, digest)
        })?;
        let mut output_file = File::create(&output_path).context("Failed to create file")?;
        output_file.write_all(&file_contents).with_context(|| {
            format!(
                "Failed to copy contents of \"{}\" with digest \"{}\" to \"{}\"",
                input_path,
                digest,
                output_path.display()
            )
        })?;
    }
    Ok(())
}

use protobuf::{self, Message, RepeatedField};
pub fn generate_cu() {
    let mut unit = CompilationUnit::new();

    // Set vname
    let mut vname = VName::new();
    vname.set_corpus("kythe".into());
    vname.set_language("rust".into());
    unit.set_v_name(vname);

    // Set required input
    let mut required_input = Vec::new();
    let mut input1 = CompilationUnit_FileInput::new();
    let mut info1 = FileInfo::new();
    info1.set_path("src/main.rs".into());
    info1.set_digest("4e1d16f36de73ce433806569339e9a35eb23eb6c234c691a2786c720dbfd1283".into());
    input1.set_info(info1);
    let mut vname1 = VName::new();
    vname1.set_corpus("kythe".into());
    vname1.set_path("src/main.rs".into());
    input1.set_v_name(vname1);
    required_input.push(input1);

    let mut input2 = CompilationUnit_FileInput::new();
    let mut info2 = FileInfo::new();
    info2.set_path("test_crate.json".into());
    info2.set_digest("48957e959d8ad8d3858e30ba4033208ae0ce1ffaa311bf5e0c7b85e88efc70b4".into());
    input2.set_info(info2);
    let mut vname2 = VName::new();
    vname2.set_corpus("kythe".into());
    vname2.set_path("test_crate.json".into());
    input2.set_v_name(vname2);
    required_input.push(input2);

    let mut input3 = CompilationUnit_FileInput::new();
    let mut info3 = FileInfo::new();
    info3.set_path("src/add.rs".into());
    info3.set_digest("22e92ab1af9ea696b2dee80b38109a797856a0ddfead136d245605c65acfe6bc".into());
    input3.set_info(info3);
    let mut vname3 = VName::new();
    vname3.set_corpus("kythe".into());
    vname3.set_path("src/add.rs".into());
    input3.set_v_name(vname3);
    required_input.push(input3);

    let input_field = RepeatedField::from_vec(required_input);
    unit.set_required_input(input_field);

    // Set argument
    let argument: Vec<String> = Vec::new();
    let argument_field = RepeatedField::from_vec(argument);
    unit.set_argument(argument_field);

    // Set source_file
    let mut source_file: Vec<String> = Vec::new();
    source_file.push("src/main.rs".into());
    source_file.push("src/add.rs".into());
    let source_file_field = RepeatedField::from_vec(source_file);
    unit.set_source_file(source_file_field);

    // Set output_key
    unit.set_output_key("main".into());

    let mut indexed_compilation = IndexedCompilation::new();
    indexed_compilation.set_unit(unit);
    let bytes: Vec<u8> = indexed_compilation.write_to_bytes().unwrap();

    let mut file = File::create("/tmp/rust.proto").expect("Couldn't create file");
    file.write_all(&bytes.as_slice()).expect("Failed to write compilation unit proto");
}
