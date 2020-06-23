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
use protobuf::{CodedOutputStream, Message};
use std::io::Write;
use storage_rust_proto::*;

/// A trait for writing Kythe graph entries to an output.
pub trait KytheWriter {
    /// Write an entry to the output.
    ///
    /// Given an Kythe storage proto Entry, write that entry to the output of
    /// the KytheWriter. If the operation is successful, the function will
    /// return Ok with a void value.KytheError
    ///
    /// # Errors
    ///
    /// If the writer fails to write the entry to output, a
    /// [WriterError][KytheError::WriterError] will be returned.
    fn write_entry(&mut self, entry: Entry) -> Result<(), KytheError>;
}

/// A [KytheWriter] that writes entries to a [CodedOutputStream]
pub struct StreamWriter<'a> {
    output_stream: CodedOutputStream<'a>,
}

impl<'a> StreamWriter<'a> {
    /// Create a new instance of StreamWriter
    ///
    /// Given a writer that implements [Write], initializes a CodedOutputStream
    /// and returns a new [StreamWriter].
    pub fn new(writer: &'a mut dyn Write) -> StreamWriter<'a> {
        Self { output_stream: CodedOutputStream::new(writer) }
    }
}

impl<'a> KytheWriter for StreamWriter<'a> {
    /// Given an [Entry], writes the entry using a CodedOutputStream.
    /// First writes a varint32 of the size of the entry, then writes the actual
    /// entry.
    ///
    /// # Errors
    ///
    /// If any of these writes fails, a [WriterError][KytheError::WriterError]
    /// is returned.
    fn write_entry(&mut self, entry: Entry) -> Result<(), KytheError> {
        let entry_size = entry.compute_size();
        self.output_stream.write_raw_varint32(entry_size).map_err(KytheError::WriterError)?;
        entry.write_to_with_cached_sizes(&mut self.output_stream).map_err(KytheError::WriterError)
    }
}

/// A [KytheWriter] that writes entries to a Vec.
#[derive(Default)]
pub struct ArrayWriter {
    entries: Vec<Entry>,
}

impl ArrayWriter {
    /// Returns a new ArrayWriter
    pub fn new() -> Self {
        Self { entries: Vec::new() }
    }
    /// Returns a clone of the stored vector of entries.
    pub fn get_entries(&self) -> Vec<Entry> {
        self.entries.clone()
    }
}

impl KytheWriter for ArrayWriter {
    /// Given an [Entry], push it onto the vector. Never returns an error.
    fn write_entry(&mut self, entry: Entry) -> Result<(), KytheError> {
        self.entries.push(entry);
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn array_writer_test() {
        let entry = Entry::new();
        let mut test_vec = Vec::new();
        test_vec.push(entry.clone());

        let mut writer = ArrayWriter::new();
        assert!(writer.write_entry(entry).is_ok());
        assert_eq!(writer.get_entries(), test_vec);
    }
}
