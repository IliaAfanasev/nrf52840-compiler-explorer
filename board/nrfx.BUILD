cc_library(
    name = "bootloader",
    srcs = [
        "drivers/src/nrfx_uart.c",
        "mdk/gcc_startup_nrf52840.S",
        "mdk/system_nrf52840.c",
    ],
    hdrs = glob(["**"]),
    defines = [
        "NRFX_UART_ENABLED",
        "NRFX_UART0_ENABLED",
        "CONFIG_GPIO_AS_PINRESET",
        "NRF52840_XXAA",
        "__HEAP_SIZE=512",
        "__STACK_SIZE=512",
    ],
    includes = [
        ".",
        "drivers/include",
        "mdk/",
        "templates/",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "@cmsis//:cmsis-lib",
    ],
)

cc_library(
    name = "application",
    srcs = [
        "drivers/src/nrfx_uart.c",
        "mdk/gcc_startup_nrf52840.S",
        "mdk/system_nrf52840.c",
    ],
    hdrs = glob(["**"]),
    defines = [
        "NRFX_UART_ENABLED",
        "NRFX_UART0_ENABLED",
        "CONFIG_GPIO_AS_PINRESET",
        "NRF52840_XXAA",
        "__STARTUP_SKIP_ETEXT",
        "__HEAP_SIZE=8192",
        "__STACK_SIZE=8192",
    ],
    includes = [
        ".",
        "drivers/include",
        "mdk/",
        "templates/",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "@cmsis//:cmsis-lib",
    ],
)
