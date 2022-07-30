cc_library(
    name = "bootloader",
    srcs = ["src/support.cc"],
    linkopts = [
        "-u_write",
        "-T$(location :bootloader.ld)",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":bootloader.ld",
        "@nrfx//:bootloader",
    ],
)

cc_library(
    name = "application",
    srcs = ["src/support.cc"],
    linkopts = [
        "-u_write",
        "-T$(location :application.ld)",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":application.ld",
        "@nrfx//:application",
    ],
)
