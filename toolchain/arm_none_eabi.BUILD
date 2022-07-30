load("@//toolchain:cc_toolchain_config.bzl", "cc_toolchain_config")

package(default_visibility = ["//visibility:public"])

filegroup(
    name = "all_files",
    srcs = glob(["**/*"]),
)

filegroup(
    name = "objcopy",
    srcs = glob(["bin/arm-none-eabi-objcopy*"]),
)

cc_toolchain_config(
    name = "arm_none_eabi_config",
)

cc_toolchain(
    name = "arm_none_eabi_toolchain",
    all_files = ":all_files",
    ar_files = ":all_files",
    as_files = ":all_files",
    compiler_files = ":all_files",
    dwp_files = ":all_files",
    linker_files = ":all_files",
    objcopy_files = ":all_files",
    strip_files = ":all_files",
    supports_param_files = 1,
    toolchain_config = ":arm_none_eabi_config",
    toolchain_identifier = "arm-none-eabi-toolchain",
)
