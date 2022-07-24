cc_library(
    name = "board",
    srcs = ["src/support.cc"],
    linkopts = [
        "-T$(location :linkerscript.ld)",
        "-u_write",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":linkerscript.ld",
        "@nrfx//:nrfx-lib",
    ],
)
