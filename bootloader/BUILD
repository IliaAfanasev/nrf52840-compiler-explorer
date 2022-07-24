cc_binary(
    name = "bootloader",
    srcs = [
        "src/main.cc",
    ],
    linkopts = [
        "-T$(location :bootloader.ld)",
    ],
    deps = [
        ":bootloader.ld",
        "//board",
    ],
)
