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
        name = "raze__adler32__1_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/adler32/adler32-1.1.0.crate",
        type = "tar.gz",
        sha256 = "567b077b825e468cc974f0020d4082ee6e03132512f207ef1a02fd5d00d1f32d",
        strip_prefix = "adler32-1.1.0",
        build_file = Label("//kythe/rust/indexer/cargo/remote:adler32-1.1.0.BUILD"),
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
        name = "raze__cc__1_0_54",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cc/cc-1.0.54.crate",
        type = "tar.gz",
        sha256 = "7bbb73db36c1246e9034e307d0fba23f9a2e251faa47ade70c1bd252220c8311",
        strip_prefix = "cc-1.0.54",
        build_file = Label("//kythe/rust/indexer/cargo/remote:cc-1.0.54.BUILD"),
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
        name = "raze__flate2__1_0_14",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/flate2/flate2-1.0.14.crate",
        type = "tar.gz",
        sha256 = "2cfff41391129e0a856d6d822600b8d71179d46879e310417eb9c762eb178b42",
        strip_prefix = "flate2-1.0.14",
        build_file = Label("//kythe/rust/indexer/cargo/remote:flate2-1.0.14.BUILD"),
    )

    _new_http_archive(
        name = "raze__libc__0_2_71",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libc/libc-0.2.71.crate",
        type = "tar.gz",
        sha256 = "9457b06509d27052635f90d6466700c65095fdf75409b3fbdd903e988b886f49",
        strip_prefix = "libc-0.2.71",
        build_file = Label("//kythe/rust/indexer/cargo/remote:libc-0.2.71.BUILD"),
    )

    _new_http_archive(
        name = "raze__miniz_oxide__0_3_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/miniz_oxide/miniz_oxide-0.3.7.crate",
        type = "tar.gz",
        sha256 = "791daaae1ed6889560f8c4359194f56648355540573244a5448a83ba1ecc7435",
        strip_prefix = "miniz_oxide-0.3.7",
        build_file = Label("//kythe/rust/indexer/cargo/remote:miniz_oxide-0.3.7.BUILD"),
    )

    _new_http_archive(
        name = "raze__pkg_config__0_3_17",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/pkg-config/pkg-config-0.3.17.crate",
        type = "tar.gz",
        sha256 = "05da548ad6865900e60eaba7f589cc0783590a92e940c26953ff81ddbab2d677",
        strip_prefix = "pkg-config-0.3.17",
        build_file = Label("//kythe/rust/indexer/cargo/remote:pkg-config-0.3.17.BUILD"),
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
        name = "raze__serde__1_0_114",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/serde/serde-1.0.114.crate",
        type = "tar.gz",
        sha256 = "5317f7588f0a5078ee60ef675ef96735a1442132dc645eb1d12c018620ed8cd3",
        strip_prefix = "serde-1.0.114",
        build_file = Label("//kythe/rust/indexer/cargo/remote:serde-1.0.114.BUILD"),
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
        name = "raze__winapi__0_3_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi/winapi-0.3.8.crate",
        type = "tar.gz",
        sha256 = "8093091eeb260906a183e6ae1abdba2ef5ef2257a21801128899c3fc699229c6",
        strip_prefix = "winapi-0.3.8",
        build_file = Label("//kythe/rust/indexer/cargo/remote:winapi-0.3.8.BUILD"),
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

