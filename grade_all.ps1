# Read input file
$stdin = Get-Content $args[1]

# Change to file directory
Set-Location $args[0]

# For each c file in the directory
$total = (Get-ChildItem *.c | Measure-Object).Count
$count = 1

Write-Host $total
foreach ($item in Get-ChildItem *.c) {
    Write-Host "`rGrading assignment" $count "/" $total

    # Compile and run with test input found in .\input.txt
    $exe = ".\" + (Get-Item $item).BaseName + ".exe"
    $name = "`"" + $item.BaseName + ".c" + "`""
    # Only Error's and Warning during compile time are displayed.
    Invoke-Expression "cl /nologo $name" -ErrorVariable output

    if (!$LASTEXITCODE) {
        # Run program with input.txt as stdin, save output
        $output += "`n" + ($stdin | & $exe)
        # Character limit break
        $data = Get-Content $item
        foreach ($line in $data) {
            if ($line.Length -gt 80) {
                $output += Write-Output "`nLine exceeds 80 characters`n"
                break
            }
        }
        
    }# run if compile fails
    else {
        Write-Host -ForegroundColor Red ("Compile failed for " + $item)
    }

    # Prepends the program output to the c file
    Write-Output $output
    ("/* PROGRAM OUPUT" + "`n" + ($output) + "`n*/`n" + (Get-Content $item -Encoding UTF8 -Raw) + "`n") | Set-Content $item -Encoding UTF8
    
    # Clean directory
    Remove-Item *.exe
    Remove-Item *.obj

    $count += 1
}