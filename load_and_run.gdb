set confirm off
target remote :3333
monitor reset halt
set $pc = *0x00000004
file bazel-bin/application/application
load
monitor resume
detach
quit