# SPECIAL GRADER FOR PROGRAM 6 ONLY

$in = $args[0]

# Compile and run with test input found in .\input.txt
$exe = ".\" + (Get-Item $in).BaseName + ".exe"

# Only Error's and Warning during compile time are displayed.
cl $in /nologo 1> $null 4> $null 5> $null 6> $null 

& $exe | python -m validate
Start-Sleep -s 1
& $exe | python -m validate
Start-Sleep -s 1
& $exe | python -m validate

# Character limit break
$data = Get-Content $in
foreach ($line in $data) {
    if ($line.Length -gt 80) {
        Write-Host -ForegroundColor DarkYellow "`nLine exceeds 80 characters"
        break
    }
}