# SPECIAL GRADER FOR PROGRAM 6 ONLY
[CmdletBinding()]
param (
    [Parameter(Mandatory=$true, Position=0)]
    [System.IO.File] $in

    [Parameter(Position=1)]
)


$in = $args[0]
$inputFile = $args[1]

# Compile and run with test input found in .\input.txt
$exe = ".\" + (Get-Item $in).BaseName + ".exe"

# Only Error's and Warning during compile time are displayed.
cl $in 1> $null 4> $null 5> $null 6> $null 

$exe | python validate.py
Start-Sleep -s 1
$exe | python validate.py
Start-Sleep -s 1
$exe | python validate.py

# Character limit break
$data = Get-Content $in
foreach ($line in $data) {
    if ($line.Length -gt 80) {
        Write-Host -ForegroundColor DarkYellow "`nLine exceeds 80 characters"
        break
    }
}