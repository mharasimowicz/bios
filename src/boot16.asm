; SimpleBIOS
; Copyright (C) 2020 Michal Harasimowicz

; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;16 bit mode

; 0x90 - NOP will mean unused/uninitialized memory
%define NOT_INITIALIZED_OPCODE      0x90
%define REAL_MODE_START_ALIGNMENT   0x3000
%define REAL_MODE_START_CS          0xf000
%define BOOT_SIZE                   0x10

[bits 16]
; jumping to start
jmp REAL_MODE_START_CS:REAL_MODE_START_ALIGNMENT

times BOOT_SIZE - ($-$$) db NOT_INITIALIZED_OPCODE