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

pub struct EntryEmitter<'a> {
    writer: &'a mut dyn KytheWriter,
}

impl<'a> EntryEmitter<'a> {
    pub fn new(writer: &'a mut dyn KytheWriter) -> Self {
        Self { writer }
    }

    /// Takes a file name, fact name, and fact value. Creates a node with the
    /// provided information and writes it to the KytheWriter.
    ///
    /// # Errors
    /// If an error occurs while writing the entry, a [KytheError::WriterError]
    /// is returned.
    pub fn emit_node(
        &mut self,
        vname: VName,
        fact_name: String,
        fact_value: Vec<u8>,
    ) -> Result<(), KytheError> {
        // let vname = self.get_vname(&file_name)?;
        let mut entry = Entry::new();
        entry.set_source(vname);
        entry.set_fact_name(fact_name);
        entry.set_fact_value(fact_value);

        self.writer.write_entry(entry)
    }

    // Given a signature, returns a VName
    // TODO: Figure out how to fill out the other fields
    pub fn vname_from_signature(signature: &str) -> VName {
        let mut vname = VName::new();
        vname.set_signature(signature.into());
        vname
    }
}
