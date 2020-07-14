package(default_visibility = ["//visibility:public"])
load("@io_bazel_rules_rust//rust:rust.bzl", "rust_binary", "rust_library", "rust_test", "rust_clippy")
load("@io_bazel_rules_rust//proto:toolchain.bzl", "PROTO_COMPILE_DEPS")

rust_library(
  name = "kythe_rust_indexer",
  srcs = glob(
    include = ["src/**/*.rs"],
    exclude = ["src/bin/**"]
  ),
  deps = [
    "//kythe/proto:analysis_rust_proto",
    "//kythe/proto:storage_rust_proto",
    "//kythe/rust/indexer/cargo:protobuf",
    "//kythe/rust/indexer/cargo:quick_error",
    "//kythe/rust/indexer/cargo:zip",
    "//kythe/rust/indexer/cargo:rls_data",
    "//kythe/rust/indexer/cargo:rls_analysis",
    "//kythe/rust/indexer/cargo:lazy_static",
  ] + PROTO_COMPILE_DEPS,
  edition = "2018",
)

rust_binary(
  name = "indexer",
  srcs = glob(
    include = ["src/bin/**/*.rs"],
  ),
  crate_root = ":src/bin/main.rs",
  deps = [
    ":kythe_rust_indexer",
    "//kythe/proto:analysis_rust_proto",
    "//kythe/proto:storage_rust_proto",
    "//kythe/rust/indexer/cargo:tempfile",
    "//kythe/rust/indexer/cargo:anyhow",
    "//kythe/rust/indexer/cargo:protobuf",
  ],
  edition = "2018",
)

rust_test(
  name = "library_inline_tests",
  crate = ":kythe_rust_indexer",
)

rust_test(
  name = "binary_inline_tests",
  crate = ":indexer",
)

rust_test(
  name = "integration_tests",
  srcs = glob(["tests/*.rs"]),
  deps = [
    "//kythe/proto:analysis_rust_proto",
    "//kythe/proto:storage_rust_proto",
    ":kythe_rust_indexer",
    ":library_inline_tests",
    ":indexer",
    ":binary_inline_tests",
    "@io_bazel_rules_rust//tools/runfiles",
  ],
  data = glob(["testfiles/**"]),
)

rust_clippy(
    name = "clippy",
    deps = [
        ":kythe_rust_indexer",
        ":indexer",
    ],
)
