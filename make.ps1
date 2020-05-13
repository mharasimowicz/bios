if(-not($Env:PATH -contains "NASM")) {
    Write-Output "Ammending PATH  with NASM";
    $Env:PATH = "$($Env:PATH);C:\Program Files\NASM\";
} else {
    Write-Output "NASM present in PATH";
}
$AS = "nasm.exe";

function BuildBiosTarget {
    & $AS -f bin -o ./bin/bios.bin ./init.asm;
}

function CleanBinDirectoryTarget {
    if(Test-Path("./bin")) {
        rm -Verbose -Recurse ./bin
    }
}

function CreateBinDirectoryTarget {
    mkdir -Verbose bin
}

function BuildAllTarget {
    CleanBinDirectoryTarget
    CreateBinDirectoryTarget
    BuildBiosTarget
}

BuildAllTarget