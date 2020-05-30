# SimpleBIOS
# Copyright (C) 2020 Michal Harasimowicz

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

$AS = "nasm.exe";

function BuildBiosTarget {

    & $AS -f bin -o ./obj/stage0.bin ./src/boot16.asm; # this should be last in the file!!
    & $AS -f bin -o ./obj/stage1.bin ./src/init16.asm;
    & $AS -f bin -o ./obj/stage2.bin ./src/init32.asm;

    $path = (Resolve-Path .)

    Join-File  "$path/obj/stage1.bin","$path/obj/stage2.bin","$path/obj/stage0.bin" "$path/bin/bios.bin"
}

function Join-File (
    [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$true)]
    [string[]] $Path,
    [parameter(Position=1,Mandatory=$true)]
    [string] $Destination
)
{
    write-verbose "Join-File: Open Destination1 $Destination"
    $OutFile = [System.IO.File]::Create($Destination)
    foreach ( $File in $Path ) {
        write-verbose "   Join-File: Open Source $File"
        $InFile = [System.IO.File]::OpenRead($File)
        $InFile.CopyTo($OutFile)
        $InFile.Dispose()
    }
    $OutFile.Dispose()
    write-verbose "Join-File: finished"
} 

function CleanBinDirectoryTarget {
    if(Test-Path("./bin")) {
        rm -Verbose -Recurse -Force ./bin
    }
    if(Test-Path("./obj")) {
        rm -Verbose -Recurse -Force ./obj
    }
}

function CreateBinDirectoryTarget {
    mkdir -Verbose obj
    mkdir -Verbose bin
}

function BuildAllTarget {
    CleanBinDirectoryTarget
    CreateBinDirectoryTarget
    BuildBiosTarget
}

BuildAllTarget