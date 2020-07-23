"""
cargo-raze crate workspace functions

DO NOT EDIT! Replaced on runs of cargo-raze
"""
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")

def _new_http_archive(name, **kwargs):
    if not native.existing_rule(name):
        http_archive(name=name, **kwargs)

def _new_git_repository(name, **kwargs):
    if not native.existing_rule(name):
        new_git_repository(name=name, **kwargs)

def raze_fetch_remote_crates():

    _new_http_archive(
        name = "raze__adler__0_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/adler/adler-0.2.3.crate",
        type = "tar.gz",
        sha256 = "ee2a4ec343196209d6594e19543ae87a39f96d5534d7174822a3ad825dd6ed7e",
        strip_prefix = "adler-0.2.3",
        build_file = Label("//kythe/rust/indexer/cargo/remote:adler-0.2.3.BUILD"),
    )

    _new_http_archive(
        name = "raze__anyhow__1_0_31",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/anyhow/anyhow-1.0.31.crate",
        type = "tar.gz",
        sha256 = "85bb70cc08ec97ca5450e6eba421deeea5f172c0fc61f78b5357b2a8e8be195f",
        strip_prefix = "anyhow-1.0.31",
        build_file = Label("//kythe/rust/indexer/cargo/remote:anyhow-1.0.31.BUILD"),
    )

    _new_http_archive(
        name = "raze__byteorder__1_3_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/byteorder/byteorder-1.3.4.crate",
        type = "tar.gz",
        sha256 = "08c48aae112d48ed9f069b33538ea9e3e90aa263cfa3d1c24309612b1f7472de",
        strip_prefix = "byteorder-1.3.4",
        build_file = Label("//kythe/rust/indexer/cargo/remote:byteorder-1.3.4.BUILD"),
    )

    _new_http_archive(
        name = "raze__bzip2__0_3_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bzip2/bzip2-0.3.3.crate",
        type = "tar.gz",
        sha256 = "42b7c3cbf0fa9c1b82308d57191728ca0256cb821220f4e2fd410a72ade26e3b",
        strip_prefix = "bzip2-0.3.3",
        build_file = Label("//kythe/rust/indexer/cargo/remote:bzip2-0.3.3.BUILD"),
    )

    _new_http_archive(
        name = "raze__bzip2_sys__0_1_9_1_0_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bzip2-sys/bzip2-sys-0.1.9+1.0.8.crate",
        type = "tar.gz",
        sha256 = "ad3b39a260062fca31f7b0b12f207e8f2590a67d32ec7d59c20484b07ea7285e",
        strip_prefix = "bzip2-sys-0.1.9+1.0.8",
        build_file = Label("//kythe/rust/indexer/cargo/remote:bzip2-sys-0.1.9+1.0.8.BUILD"),
    )

    _new_http_archive(
        name = "raze__cc__1_0_58",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cc/cc-1.0.58.crate",
        type = "tar.gz",
        sha256 = "f9a06fb2e53271d7c279ec1efea6ab691c35a2ae67ec0d91d7acec0caf13b518",
        strip_prefix = "cc-1.0.58",
        build_file = Label("//kythe/rust/indexer/cargo/remote:cc-1.0.58.BUILD"),
    )

    _new_http_archive(
        name = "raze__cfg_if__0_1_10",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cfg-if/cfg-if-0.1.10.crate",
        type = "tar.gz",
        sha256 = "4785bdd1c96b2a846b2bd7cc02e86b6b3dbf14e7e53446c4f54c92a361040822",
        strip_prefix = "cfg-if-0.1.10",
        build_file = Label("//kythe/rust/indexer/cargo/remote:cfg-if-0.1.10.BUILD"),
    )

    _new_http_archive(
        name = "raze__crc32fast__1_2_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/crc32fast/crc32fast-1.2.0.crate",
        type = "tar.gz",
        sha256 = "ba125de2af0df55319f41944744ad91c71113bf74a4646efff39afe1f6842db1",
        strip_prefix = "crc32fast-1.2.0",
        build_file = Label("//kythe/rust/indexer/cargo/remote:crc32fast-1.2.0.BUILD"),
    )

    _new_http_archive(
        name = "raze__derive_new__0_5_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/derive-new/derive-new-0.5.8.crate",
        type = "tar.gz",
        sha256 = "71f31892cd5c62e414316f2963c5689242c43d8e7bbcaaeca97e5e28c95d91d9",
        strip_prefix = "derive-new-0.5.8",
        build_file = Label("//kythe/rust/indexer/cargo/remote:derive-new-0.5.8.BUILD"),
    )

    _new_http_archive(
        name = "raze__either__1_5_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/either/either-1.5.3.crate",
        type = "tar.gz",
        sha256 = "bb1f6b1ce1c140482ea30ddd3335fc0024ac7ee112895426e0a629a6c20adfe3",
        strip_prefix = "either-1.5.3",
        build_file = Label("//kythe/rust/indexer/cargo/remote:either-1.5.3.BUILD"),
    )

    _new_http_archive(
        name = "raze__flate2__1_0_16",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/flate2/flate2-1.0.16.crate",
        type = "tar.gz",
        sha256 = "68c90b0fc46cf89d227cc78b40e494ff81287a92dd07631e5af0d06fe3cf885e",
        strip_prefix = "flate2-1.0.16",
        build_file = Label("//kythe/rust/indexer/cargo/remote:flate2-1.0.16.BUILD"),
    )

    _new_http_archive(
        name = "raze__fst__0_3_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/fst/fst-0.3.5.crate",
        type = "tar.gz",
        sha256 = "927fb434ff9f0115b215dc0efd2e4fbdd7448522a92a1aa37c77d6a2f8f1ebd6",
        strip_prefix = "fst-0.3.5",
        build_file = Label("//kythe/rust/indexer/cargo/remote:fst-0.3.5.BUILD"),
    )

    _new_http_archive(
        name = "raze__getrandom__0_1_14",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/getrandom/getrandom-0.1.14.crate",
        type = "tar.gz",
        sha256 = "7abc8dd8451921606d809ba32e95b6111925cd2906060d2dcc29c070220503eb",
        strip_prefix = "getrandom-0.1.14",
        build_file = Label("//kythe/rust/indexer/cargo/remote:getrandom-0.1.14.BUILD"),
    )

    _new_http_archive(
        name = "raze__itertools__0_8_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/itertools/itertools-0.8.2.crate",
        type = "tar.gz",
        sha256 = "f56a2d0bc861f9165be4eb3442afd3c236d8a98afd426f65d92324ae1091a484",
        strip_prefix = "itertools-0.8.2",
        build_file = Label("//kythe/rust/indexer/cargo/remote:itertools-0.8.2.BUILD"),
    )

    _new_http_archive(
        name = "raze__itoa__0_4_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/itoa/itoa-0.4.6.crate",
        type = "tar.gz",
        sha256 = "dc6f3ad7b9d11a0c00842ff8de1b60ee58661048eb8049ed33c73594f359d7e6",
        strip_prefix = "itoa-0.4.6",
        build_file = Label("//kythe/rust/indexer/cargo/remote:itoa-0.4.6.BUILD"),
    )

    _new_http_archive(
        name = "raze__json__0_11_15",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/json/json-0.11.15.crate",
        type = "tar.gz",
        sha256 = "92c245af8786f6ac35f95ca14feca9119e71339aaab41e878e7cdd655c97e9e5",
        strip_prefix = "json-0.11.15",
        build_file = Label("//kythe/rust/indexer/cargo/remote:json-0.11.15.BUILD"),
    )

    _new_http_archive(
        name = "raze__libc__0_2_73",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libc/libc-0.2.73.crate",
        type = "tar.gz",
        sha256 = "bd7d4bd64732af4bf3a67f367c27df8520ad7e230c5817b8ff485864d80242b9",
        strip_prefix = "libc-0.2.73",
        build_file = Label("//kythe/rust/indexer/cargo/remote:libc-0.2.73.BUILD"),
    )

    _new_http_archive(
        name = "raze__log__0_4_11",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/log/log-0.4.11.crate",
        type = "tar.gz",
        sha256 = "4fabed175da42fed1fa0746b0ea71f412aa9d35e76e95e59b192c64b9dc2bf8b",
        strip_prefix = "log-0.4.11",
        build_file = Label("//kythe/rust/indexer/cargo/remote:log-0.4.11.BUILD"),
    )

    _new_http_archive(
        name = "raze__miniz_oxide__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/miniz_oxide/miniz_oxide-0.4.0.crate",
        type = "tar.gz",
        sha256 = "be0f75932c1f6cfae3c04000e40114adf955636e19040f9c0a2c380702aa1c7f",
        strip_prefix = "miniz_oxide-0.4.0",
        build_file = Label("//kythe/rust/indexer/cargo/remote:miniz_oxide-0.4.0.BUILD"),
    )

    _new_http_archive(
        name = "raze__pkg_config__0_3_18",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/pkg-config/pkg-config-0.3.18.crate",
        type = "tar.gz",
        sha256 = "d36492546b6af1463394d46f0c834346f31548646f6ba10849802c9c9a27ac33",
        strip_prefix = "pkg-config-0.3.18",
        build_file = Label("//kythe/rust/indexer/cargo/remote:pkg-config-0.3.18.BUILD"),
    )

    _new_http_archive(
        name = "raze__podio__0_1_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/podio/podio-0.1.7.crate",
        type = "tar.gz",
        sha256 = "b18befed8bc2b61abc79a457295e7e838417326da1586050b919414073977f19",
        strip_prefix = "podio-0.1.7",
        build_file = Label("//kythe/rust/indexer/cargo/remote:podio-0.1.7.BUILD"),
    )

    _new_http_archive(
        name = "raze__ppv_lite86__0_2_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/ppv-lite86/ppv-lite86-0.2.8.crate",
        type = "tar.gz",
        sha256 = "237a5ed80e274dbc66f86bd59c1e25edc039660be53194b5fe0a482e0f2612ea",
        strip_prefix = "ppv-lite86-0.2.8",
        build_file = Label("//kythe/rust/indexer/cargo/remote:ppv-lite86-0.2.8.BUILD"),
    )

    _new_http_archive(
        name = "raze__proc_macro2__1_0_19",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/proc-macro2/proc-macro2-1.0.19.crate",
        type = "tar.gz",
        sha256 = "04f5f085b5d71e2188cb8271e5da0161ad52c3f227a661a3c135fdf28e258b12",
        strip_prefix = "proc-macro2-1.0.19",
        build_file = Label("//kythe/rust/indexer/cargo/remote:proc-macro2-1.0.19.BUILD"),
    )

    _new_http_archive(
        name = "raze__protobuf__2_8_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/protobuf/protobuf-2.8.2.crate",
        type = "tar.gz",
        sha256 = "70731852eec72c56d11226c8a5f96ad5058a3dab73647ca5f7ee351e464f2571",
        strip_prefix = "protobuf-2.8.2",
        patches = [
            "@io_bazel_rules_rust//proto/raze/patch:protobuf-2.8.2.patch",
        ],
        patch_args = [
            "-p1",
        ],
        build_file = Label("//kythe/rust/indexer/cargo/remote:protobuf-2.8.2.BUILD"),
    )

    _new_http_archive(
        name = "raze__quick_error__1_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/quick-error/quick-error-1.2.3.crate",
        type = "tar.gz",
        sha256 = "a1d01941d82fa2ab50be1e79e6714289dd7cde78eba4c074bc5a4374f650dfe0",
        strip_prefix = "quick-error-1.2.3",
        build_file = Label("//kythe/rust/indexer/cargo/remote:quick-error-1.2.3.BUILD"),
    )

    _new_http_archive(
        name = "raze__quote__1_0_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/quote/quote-1.0.7.crate",
        type = "tar.gz",
        sha256 = "aa563d17ecb180e500da1cfd2b028310ac758de548efdd203e18f283af693f37",
        strip_prefix = "quote-1.0.7",
        build_file = Label("//kythe/rust/indexer/cargo/remote:quote-1.0.7.BUILD"),
    )

    _new_http_archive(
        name = "raze__rand__0_7_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand/rand-0.7.3.crate",
        type = "tar.gz",
        sha256 = "6a6b1679d49b24bbfe0c803429aa1874472f50d9b363131f0e89fc356b544d03",
        strip_prefix = "rand-0.7.3",
        build_file = Label("//kythe/rust/indexer/cargo/remote:rand-0.7.3.BUILD"),
    )

    _new_http_archive(
        name = "raze__rand_chacha__0_2_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_chacha/rand_chacha-0.2.2.crate",
        type = "tar.gz",
        sha256 = "f4c8ed856279c9737206bf725bf36935d8666ead7aa69b52be55af369d193402",
        strip_prefix = "rand_chacha-0.2.2",
        build_file = Label("//kythe/rust/indexer/cargo/remote:rand_chacha-0.2.2.BUILD"),
    )

    _new_http_archive(
        name = "raze__rand_core__0_5_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_core/rand_core-0.5.1.crate",
        type = "tar.gz",
        sha256 = "90bde5296fc891b0cef12a6d03ddccc162ce7b2aff54160af9338f8d40df6d19",
        strip_prefix = "rand_core-0.5.1",
        build_file = Label("//kythe/rust/indexer/cargo/remote:rand_core-0.5.1.BUILD"),
    )

    _new_http_archive(
        name = "raze__rand_hc__0_2_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_hc/rand_hc-0.2.0.crate",
        type = "tar.gz",
        sha256 = "ca3129af7b92a17112d59ad498c6f81eaf463253766b90396d39ea7a39d6613c",
        strip_prefix = "rand_hc-0.2.0",
        build_file = Label("//kythe/rust/indexer/cargo/remote:rand_hc-0.2.0.BUILD"),
    )

    _new_http_archive(
        name = "raze__redox_syscall__0_1_57",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/redox_syscall/redox_syscall-0.1.57.crate",
        type = "tar.gz",
        sha256 = "41cc0f7e4d5d4544e8861606a285bb08d3e70712ccc7d2b84d7c0ccfaf4b05ce",
        strip_prefix = "redox_syscall-0.1.57",
        build_file = Label("//kythe/rust/indexer/cargo/remote:redox_syscall-0.1.57.BUILD"),
    )

    _new_http_archive(
        name = "raze__remove_dir_all__0_5_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/remove_dir_all/remove_dir_all-0.5.3.crate",
        type = "tar.gz",
        sha256 = "3acd125665422973a33ac9d3dd2df85edad0f4ae9b00dafb1a05e43a9f5ef8e7",
        strip_prefix = "remove_dir_all-0.5.3",
        build_file = Label("//kythe/rust/indexer/cargo/remote:remove_dir_all-0.5.3.BUILD"),
    )

    _new_http_archive(
        name = "raze__rls_analysis__0_18_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rls-analysis/rls-analysis-0.18.1.crate",
        type = "tar.gz",
        sha256 = "534032993e1b60e5db934eab2dde54da7afd1e46c3465fddb2b29eb47cb1ed3a",
        strip_prefix = "rls-analysis-0.18.1",
        build_file = Label("//kythe/rust/indexer/cargo/remote:rls-analysis-0.18.1.BUILD"),
    )

    _new_http_archive(
        name = "raze__rls_data__0_19_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rls-data/rls-data-0.19.0.crate",
        type = "tar.gz",
        sha256 = "76c72ea97e045be5f6290bb157ebdc5ee9f2b093831ff72adfaf59025cf5c491",
        strip_prefix = "rls-data-0.19.0",
        build_file = Label("//kythe/rust/indexer/cargo/remote:rls-data-0.19.0.BUILD"),
    )

    _new_http_archive(
        name = "raze__rls_span__0_5_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rls-span/rls-span-0.5.2.crate",
        type = "tar.gz",
        sha256 = "f2e9bed56f6272bd85d9d06d1aaeef80c5fddc78a82199eb36dceb5f94e7d934",
        strip_prefix = "rls-span-0.5.2",
        build_file = Label("//kythe/rust/indexer/cargo/remote:rls-span-0.5.2.BUILD"),
    )

    _new_http_archive(
        name = "raze__ryu__1_0_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/ryu/ryu-1.0.5.crate",
        type = "tar.gz",
        sha256 = "71d301d4193d031abdd79ff7e3dd721168a9572ef3fe51a1517aba235bd8f86e",
        strip_prefix = "ryu-1.0.5",
        build_file = Label("//kythe/rust/indexer/cargo/remote:ryu-1.0.5.BUILD"),
    )

    _new_http_archive(
        name = "raze__serde__1_0_114",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/serde/serde-1.0.114.crate",
        type = "tar.gz",
        sha256 = "5317f7588f0a5078ee60ef675ef96735a1442132dc645eb1d12c018620ed8cd3",
        strip_prefix = "serde-1.0.114",
        build_file = Label("//kythe/rust/indexer/cargo/remote:serde-1.0.114.BUILD"),
    )

    _new_http_archive(
        name = "raze__serde_json__1_0_56",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/serde_json/serde_json-1.0.56.crate",
        type = "tar.gz",
        sha256 = "3433e879a558dde8b5e8feb2a04899cf34fdde1fafb894687e52105fc1162ac3",
        strip_prefix = "serde_json-1.0.56",
        build_file = Label("//kythe/rust/indexer/cargo/remote:serde_json-1.0.56.BUILD"),
    )

    _new_http_archive(
        name = "raze__syn__1_0_35",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/syn/syn-1.0.35.crate",
        type = "tar.gz",
        sha256 = "fb7f4c519df8c117855e19dd8cc851e89eb746fe7a73f0157e0d95fdec5369b0",
        strip_prefix = "syn-1.0.35",
        build_file = Label("//kythe/rust/indexer/cargo/remote:syn-1.0.35.BUILD"),
    )

    _new_http_archive(
        name = "raze__tempfile__3_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/tempfile/tempfile-3.1.0.crate",
        type = "tar.gz",
        sha256 = "7a6e24d9338a0a5be79593e2fa15a648add6138caa803e2d5bc782c371732ca9",
        strip_prefix = "tempfile-3.1.0",
        build_file = Label("//kythe/rust/indexer/cargo/remote:tempfile-3.1.0.BUILD"),
    )

    _new_http_archive(
        name = "raze__time__0_1_43",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/time/time-0.1.43.crate",
        type = "tar.gz",
        sha256 = "ca8a50ef2360fbd1eeb0ecd46795a87a19024eb4b53c5dc916ca1fd95fe62438",
        strip_prefix = "time-0.1.43",
        build_file = Label("//kythe/rust/indexer/cargo/remote:time-0.1.43.BUILD"),
    )

    _new_http_archive(
        name = "raze__unicode_xid__0_2_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/unicode-xid/unicode-xid-0.2.1.crate",
        type = "tar.gz",
        sha256 = "f7fe0bb3479651439c9112f72b6c505038574c9fbb575ed1bf3b797fa39dd564",
        strip_prefix = "unicode-xid-0.2.1",
        build_file = Label("//kythe/rust/indexer/cargo/remote:unicode-xid-0.2.1.BUILD"),
    )

    _new_http_archive(
        name = "raze__wasi__0_9_0_wasi_snapshot_preview1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/wasi/wasi-0.9.0+wasi-snapshot-preview1.crate",
        type = "tar.gz",
        sha256 = "cccddf32554fecc6acb585f82a32a72e28b48f8c4c1883ddfeeeaa96f7d8e519",
        strip_prefix = "wasi-0.9.0+wasi-snapshot-preview1",
        build_file = Label("//kythe/rust/indexer/cargo/remote:wasi-0.9.0+wasi-snapshot-preview1.BUILD"),
    )

    _new_http_archive(
        name = "raze__winapi__0_3_9",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi/winapi-0.3.9.crate",
        type = "tar.gz",
        sha256 = "5c839a674fcd7a98952e593242ea400abe93992746761e38641405d28b00f419",
        strip_prefix = "winapi-0.3.9",
        build_file = Label("//kythe/rust/indexer/cargo/remote:winapi-0.3.9.BUILD"),
    )

    _new_http_archive(
        name = "raze__winapi_i686_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-i686-pc-windows-gnu/winapi-i686-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        sha256 = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6",
        strip_prefix = "winapi-i686-pc-windows-gnu-0.4.0",
        build_file = Label("//kythe/rust/indexer/cargo/remote:winapi-i686-pc-windows-gnu-0.4.0.BUILD"),
    )

    _new_http_archive(
        name = "raze__winapi_x86_64_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-x86_64-pc-windows-gnu/winapi-x86_64-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        sha256 = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f",
        strip_prefix = "winapi-x86_64-pc-windows-gnu-0.4.0",
        build_file = Label("//kythe/rust/indexer/cargo/remote:winapi-x86_64-pc-windows-gnu-0.4.0.BUILD"),
    )

    _new_http_archive(
        name = "raze__zip__0_5_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/zip/zip-0.5.6.crate",
        type = "tar.gz",
        sha256 = "58287c28d78507f5f91f2a4cf1e8310e2c76fd4c6932f93ac60fd1ceb402db7d",
        strip_prefix = "zip-0.5.6",
        build_file = Label("//kythe/rust/indexer/cargo/remote:zip-0.5.6.BUILD"),
    )

