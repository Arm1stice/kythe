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

//! The purpose of this module is to implement functionality to recompile the
//! CompilationUnit and generate a save analysis that can be used by the rest of
//! the indexer to generate Kythe graph nodes.

use crate::error::KytheError;

extern crate rustc_error_codes;
extern crate rustc_errors;
extern crate rustc_hash;
extern crate rustc_interface;
extern crate rustc_save_analysis;
extern crate rustc_session;
use rustc_interface::{interface, run_compiler};
use rustc_save_analysis::CallbackHandler;
use rustc_session::{
    config::{self, rustc_optgroups, Input},
    getopts, DiagnosticOutput,
};

use rls_data::Analysis;
use std::path::PathBuf;

pub fn generate_analysis(args: Vec<String>, root_dir: &PathBuf) -> Result<Analysis, KytheError> {
    let config = gen_interface_config(args, root_dir)?;
    // println!("{:?}", &config.input);
    let mut analysis: Option<Analysis> = None;
    run_compiler(config, |compiler| {
        compiler.enter(|queries| {
            let input = compiler.input();
            let crate_name = queries.crate_name().unwrap().peek().clone();

            queries.global_ctxt().unwrap().peek_mut().enter(|tcx| {
                rustc_save_analysis::process_crate(
                    tcx,
                    &crate_name,
                    &input,
                    None,
                    CallbackHandler {
                        callback: &mut |a| {
                            let save_analysis = unsafe {::std::mem::transmute(a.clone())};
                            analysis = Some(save_analysis);
                        },
                    },
                );
            });
        });
    });
    while analysis.is_none() {};
    Ok(analysis.unwrap())
}

fn gen_interface_config(
    args: Vec<String>,
    root_dir: &PathBuf,
) -> Result<interface::Config, KytheError> {
    let mut opts = getopts::Options::new();
    for group in rustc_optgroups() {
        (group.apply)(&mut opts);
    }
    let matches = opts.parse(args).map_err(|f| KytheError::IndexerError(f.to_string()))?;

    let mut sopts = config::build_session_options(&matches);
    sopts.debugging_opts.save_analysis = true;
    sopts.maybe_sysroot = Some(root_dir.join("external/rust_linux_x86_64"));
    for path in sopts.search_paths.iter_mut() {
        path.dir = root_dir.join(path.dir.clone())
    }

    let cfg = interface::parse_cfgspecs(matches.opt_strs("cfg"));

    let input_file_path_str = &matches.free[0];
    let input_file_path = root_dir.join(input_file_path_str);
    println!("{:?}", input_file_path_str);
    let config = interface::Config {
        opts: sopts,
        crate_cfg: cfg,
        input: Input::File(input_file_path),
        input_path: None,
        output_dir: None,
        output_file: None,
        file_loader: None,
        diagnostic_output: DiagnosticOutput::Default,
        stderr: None,
        crate_name: None,
        lint_caps: rustc_hash::FxHashMap::default(),
        register_lints: None,
        override_queries: None,
        registry: rustc_errors::registry::Registry::new(&rustc_error_codes::DIAGNOSTICS),
    };
    Ok(config)
}
