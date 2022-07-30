cc_binary(
    name = "bootloader",
    srcs = [
        "src/main.cc",
    ],
    deps = [
        "//board:bootloader",
    ],
)

genrule(
    name = "hex",
    srcs = [":bootloader"],
    outs = ["bootloader.hex"],
    cmd = "$(execpath @arm_none_eabi_10_3//:objcopy) -O ihex $< $@",
    tools = ["@arm_none_eabi_10_3//:objcopy"],
)