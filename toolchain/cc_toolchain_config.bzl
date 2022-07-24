load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
)

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "bin/arm-none-eabi-gcc",
        ),
        tool_path(
            name = "g++",
            path = "bin/arm-none-eabi-g++",
        ),
        tool_path(
            name = "ld",
            path = "bin/arm-none-eabi-ld",
        ),
        tool_path(
            name = "ar",
            path = "bin/arm-none-eabi-ar",
        ),
        tool_path(
            name = "cpp",
            path = "bin/arm-none-eabi-cpp",
        ),
        tool_path(
            name = "gcov",
            path = "/bin/false",
        ),
        tool_path(
            name = "nm",
            path = "/bin/false",
        ),
        tool_path(
            name = "objdump",
            path = "/bin/false",
        ),
        tool_path(
            name = "strip",
            path = "/bin/false",
        ),
    ]

    linker_flags = [
        "-g3",
        "-ggdb",
        "-mthumb",
        "-lstdc++",
        "-mabi=aapcs",
        "-mcpu=cortex-m4",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
        "-Wl,--gc-sections",
        # "--specs=nano.specs",
    ]

    cxx_flags = [
        "-g3",
        "-ggdb",
        "-lstdc++",
        "-no-canonical-prefixes",
        "-fno-canonical-system-headers",
        "-mcpu=cortex-m4",
        "-mthumb",
        "-mabi=aapcs",
        "-Wall",
        "-Werror",
        "-mfloat-abi=hard",
        "-mfpu=fpv4-sp-d16",
        "-ffunction-sections",
        "-fdata-sections",
        "-fno-strict-aliasing",
        "-fno-builtin",
        "-fshort-enums",
    ]

    toolchain_compiler_flags = feature(
        name = "compiler_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.assemble,
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.c_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.lto_backend,
                    ACTION_NAMES.clif_match,
                ],
                flag_groups = [
                    flag_group(flags = cxx_flags),
                ],
            ),
        ],
    )

    toolchain_linker_flags = feature(
        name = "linker_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.cpp_link_executable,
                ],
                flag_groups = [
                    flag_group(flags = linker_flags),
                ],
            ),
        ],
    )

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = [
            toolchain_compiler_flags,
            toolchain_linker_flags,
        ],
        cxx_builtin_include_directories = [
        ],
        toolchain_identifier = "local",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "cortex-m4",
        target_libc = "gcc",
        compiler = "arm-none-eabi",
        abi_version = "none-eabi",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
