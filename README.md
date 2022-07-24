# How to

## Build

Run this command in the root folder:
```
bazel build application --config=arm_none_eabi_<VERSION>
```

Supported arm-none-eabi-gcc versions:
- 10_3
- 11_2

## Add arm-none-eabi toolchain versions

Add http_archive to [WORKSPACE](WORKSPACE):

```python
http_archive(
    name = "<NAME_OF_TOOLHCAIN>",
    build_file = "@//toolchain:arm_none_eabi.BUILD",
    sha256 = "<SHA256_OF_TOOLCHAIN_ARCHIVE>",
    strip_prefix = "<STRIP_PATH>",
    url = "<URL_TO_TOOLHCAIN_ARCHIVE>",
)
```

Add toolchain to [toolchain/BUILD](toolchain/BUILD):

```python
cc_toolchain_suite(
    name = "arm_none_eabi_suite",
    toolchains = {
...
        "<NAME_OF_TOOLHCAIN>": "@<NAME_OF_TOOLHCAIN>//:arm_none_eabi_toolchain",
    },
)
```

Add these lines to [.bazelrc](.bazelrc):

```
build:<NAME_OF_TOOLHCAIN> --crosstool_top=//toolchain:arm_none_eabi_suite
build:<NAME_OF_TOOLHCAIN> --cpu=<NAME_OF_TOOLHCAIN>
build:<NAME_OF_TOOLHCAIN> --host_crosstool_top=@bazel_tools//tools/cpp:toolchain
```

# TODO

1. Make linker and compiler flags configurable.
2. Add more *arm-none-eabi* versions.
3. Add bootloader.
4. Move all application memory sections (e.g. *.text*) to RAM.
5. Add bazel target to generate *.hex file and flash it.