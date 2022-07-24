#include <cstdint>
#include <cstdio>

#include "mdk/nrf52.h"

extern const std::uint8_t __application_isr_vector__[];

void start_application(std::uintptr_t vector_table_addr) {
  const std::uint32_t stack_pointer = *reinterpret_cast<std::uint32_t *>(vector_table_addr);
  const std::uint32_t reset_handler = *reinterpret_cast<std::uint32_t *>(vector_table_addr + 4U);

  __set_CONTROL(0x00000000U);
  __set_PRIMASK(0x00000000U);
  __set_BASEPRI(0x00000000U);
  __set_FAULTMASK(0x00000000U);
  __set_MSP(stack_pointer);

  using reset_handler_t = void (*)();
  reinterpret_cast<reset_handler_t>(reset_handler)();
}

int main() {
  printf("bootloader\r\n");

  start_application(reinterpret_cast<std::uintptr_t>(__application_isr_vector__));

  // Unreachable
  while (true) {
  }
  return 0;
}