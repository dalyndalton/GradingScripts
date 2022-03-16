$in = $args[0]
$stdin = $args[1]


code $in -r
$item = Get-Item $in
# Compile and run with test input found in .\input.txt
$exe = ".\" + ($item).BaseName + ".exe"
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
    
# Clean directory
Remove-Item *.exe
Remove-Item *.obj