#!/usr/bin/python3
"""Wrapper for gcc compiler to be called by compiler explorer."""

import sys
import subprocess
import serial
import shutil
from serial.threaded import LineReader
from serial.threaded import ReaderThread
from elftools.elf.elffile import ELFFile

def flash(path):
    elf_path = path + ".elf"
    shutil.copyfile(path, elf_path)

    with open(elf_path, 'rb') as f:
        elffile = ELFFile(f)
        section = elffile.get_section_by_name('.symtab')

        reset_handler_address = hex(section.get_symbol_by_name('Reset_Handler')[0].entry.st_value)
        stack_pointer = hex(section.get_symbol_by_name('__StackTop')[0].entry.st_value)

        subprocess.run(["nrfjprog", "-f", "nrf52", "--program", elf_path, "--verify"], stdout=subprocess.DEVNULL)
        subprocess.run(["nrfjprog", "-f", "nrf52", "--run", "--pc", reset_handler_address, "--sp", stack_pointer], stdout=subprocess.DEVNULL)

class PrintLines(LineReader):
    def connection_made(self, transport):
        super(PrintLines, self).connection_made(transport)
        self.TERMINATOR = b'\n'

    def handle_line(self, data):
        print(data)

    def connection_lost(self, exc):
        pass

def main():
    ser = serial.serial_for_url('/dev/ttyACM0', baudrate=115200, timeout=1)
    with ReaderThread(ser, PrintLines):
        flash(sys.argv[1])

if __name__ == "__main__":
    main()