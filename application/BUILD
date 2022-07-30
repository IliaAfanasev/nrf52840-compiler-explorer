cc_binary(
    name = "application",
    srcs = [
        "src/main.cc",
    ],
    deps = [
        "//board:application",
    ],
)

genrule(
    name = "hex",
    srcs = [":application"],
    outs = ["application.hex"],
    cmd = "$(execpath @arm_none_eabi_10_3//:objcopy) -O ihex $< $@",
    tools = ["@arm_none_eabi_10_3//:objcopy"],
)