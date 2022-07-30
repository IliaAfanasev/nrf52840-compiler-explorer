# How to

## Build

Run command in the root folder to build 

bootloader:
```
bazel build bootloader
```

application:
```
bazel build application
```

prevent *strip*:
```
bazel build <TARGET> --strip=never
```

additional compiler flags:
```
bazel build <TARGET> --copt="<FLAGS>"
```

example:
```
bazel build application --strip=never --copt="-O3"
```

Optionally, you can specify compiler:
```
bazel build bootloader --config=arm_none_eabi_<VERSION>
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

* Add more *arm-none-eabi* versions.
* Add bazel target to flash targets.