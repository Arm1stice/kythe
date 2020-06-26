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

pub mod util;

extern crate kythe_rust_indexer;
use kythe_rust_indexer::providers::KzipFileProvider;
use kythe_rust_indexer::{indexer::KytheIndexer, writer::StreamWriter};

use anyhow::{Context, Result};
use std::{env, fs::File, path::{Path, PathBuf}};
use tempfile::tempdir;

fn main() -> Result<()> {
    // Accepts kzip path as an argument
    // Calls indexer on each compilation unit
    // Returns 0 if ok or 1 if error
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Path argument is required");
        std::process::exit(1);
    }

    // Get kzip path from argument and use it to create a KzipFileProvider
    let kzip_path = Path::new(&args[1]);
    let kzip_file = File::open(kzip_path).context("File does not exist")?;
    let mut kzip_provider =
        KzipFileProvider::new(kzip_file).context("Failed to open kzip archive")?;
    let compilation_units = kzip_provider
        .get_compilation_units()
        .context("Failed to get compilation units from kzip")?;

    let mut stdout_writer = std::io::stdout();
    let writer = StreamWriter::new(&mut stdout_writer);
    let mut indexer = KytheIndexer::new(&writer);
    for unit in compilation_units {
        Create a temporary directory to store required files
        let temp_dir = tempdir().context("Couldn't create temporary directory")?;
        let temp_path = PathBuf::new().join(temp_dir.path());
        util::extract_from_kzip(&unit, &temp_path, &mut kzip_provider)?;
        indexer.index_cu(&unit, &temp_path);
    }
    Ok(())
}
