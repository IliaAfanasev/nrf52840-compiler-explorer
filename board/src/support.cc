#include <cerrno>
#include <cstdint>
#include <cstdio>

#include <nrfx_uart.h>

namespace {

constexpr std::uint32_t uart_default_rx_pin{8U};
constexpr std::uint32_t uart_default_tx_pin{6U};

bool is_uart_inited{false};
nrfx_uart_t uart_instance = NRFX_UART_INSTANCE(0);
nrfx_uart_config_t uart_config = NRFX_UART_DEFAULT_CONFIG(uart_default_tx_pin, uart_default_rx_pin);

}  // namespace

/// Send data to uart
extern "C" int _write(int fd, char *ptr, int len) {
  // Check if uart was inited, do so if not
  if (!is_uart_inited) {
    if (nrfx_uart_init(&uart_instance, &uart_config, nullptr) != NRFX_SUCCESS) {
      errno = EIO;
      return -1;
    }
    is_uart_inited = true;
  }

  if (nrfx_uart_tx(&uart_instance, reinterpret_cast<const uint8_t *>(ptr), len) != NRFX_SUCCESS) {
    errno = EIO;
    return -1;
  }
  return len;
}

/// Read data from uart
extern "C" int _read(int fd, char *ptr, int len) {  // Check if uart was inited, do so if not
  // Check if uart was inited, do so if not
  if (!is_uart_inited) {
    if (nrfx_uart_init(&uart_instance, &uart_config, nullptr) != NRFX_SUCCESS) {
      errno = EIO;
      return -1;
    }
    is_uart_inited = true;
  }

  if (nrfx_uart_rx(&uart_instance, reinterpret_cast<uint8_t *>(ptr), len) != NRFX_SUCCESS) {
    errno = EIO;
    return -1;
  }
  return len;
}

/// Increase program data space
extern "C" void *_sbrk(int incr) {
  extern char __HeapBase;   // set by linker. NOLINT(bugprone-reserved-identifier)
  extern char __HeapLimit;  // set by linker. NOLINT(bugprone-reserved-identifier)

  static char *heap_end{nullptr};  // Previous end of heap or nullptr if none

  if (nullptr == heap_end) {
    // Initialize first time round
    heap_end = &__HeapBase;
  }

  char *prev_heap_end = heap_end;
  heap_end += incr;

  if (heap_end >= (&__HeapLimit)) {
    errno = ENOMEM;
    return reinterpret_cast<void *>(-1);  // NOLINT(performance-no-int-to-ptr)
  }
  return static_cast<void *>(prev_heap_end);
}

extern "C" int _fstat(int /*fd*/, struct stat * /*st*/) { return -1; }

extern "C" int _isatty(int /*fd*/) { return -1; }

extern "C" off_t _lseek(int /*fildes*/, off_t /*offset*/, int /*whence*/) { return -1L; }

extern "C" int _close(int /*fildes*/) { return -1; }

extern "C" void _exit(int /*rc*/) {}

extern "C" int _kill(pid_t /*pid*/, int /*sig*/) { return -1; }

extern "C" pid_t __attribute__((section("data"))) _getpid() { return 1; }
