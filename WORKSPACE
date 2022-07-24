load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "nrfx",
    build_file = "@//board:nrfx.BUILD",
    sha256 = "99fedd89c4139ce5f504b366cfbd2a3f673cbff1dc5d53f71cef359ee6b3999f",
    strip_prefix = "nrfx-2.9.0",
    url = "https://github.com/NordicSemiconductor/nrfx/archive/refs/tags/v2.9.0.zip",
)

http_archive(
    name = "cmsis",
    build_file = "@//board:cmsis.BUILD",
    sha256 = "3d4bfaf8783c633149510d098630a9d2f273dc090ea5e807103cc9b7acbb6708",
    strip_prefix = "CMSIS_5-5.9.0",
    url = "https://github.com/ARM-software/CMSIS_5/archive/refs/tags/5.9.0.zip",
)

http_archive(
    name = "arm_none_eabi_11_2",
    build_file = "@//toolchain:arm_none_eabi.BUILD",
    sha256 = "8c5acd5ae567c0100245b0556941c237369f210bceb196edfe5a2e7532c60326",
    strip_prefix = "gcc-arm-11.2-2022.02-x86_64-arm-none-eabi",
    url = "https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi.tar.xz",
)

http_archive(
    name = "arm_none_eabi_10_3",
    build_file = "@//toolchain:arm_none_eabi.BUILD",
    sha256 = "97dbb4f019ad1650b732faffcc881689cedc14e2b7ee863d390e0a41ef16c9a3",
    strip_prefix = "gcc-arm-none-eabi-10.3-2021.10",
    url = "https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2",
)
