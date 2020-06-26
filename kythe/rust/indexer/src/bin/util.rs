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
        // Create directories
        let input_path = required_input.get_info().get_path();
        let output_path = temp_path.join(input_path);
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
