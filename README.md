# ECE 1400 Grading Scripts

These scripts are meant to be used for speeding up the grading process for ECE 1400
students. Included currently are 2 scripts, `grade` and `grade_all.sh` (wip).\

For grading scripts created in visual studio, the `grade.ps1` and `grade_all.ps1` scripts will work. Add them to your windows system path and run them from the Visual Studio Developer powershell.

## `Grade`

To run grade, use the following format

```
grade [studentfile.c] [[inputfile]]
```

If the inputfile is not provided, it searches for an `input.txt` in the same directory as the student assignments. This is useful if you want to double check a student's answer with a second input file.

the grading scripts can be added to your system path by cloning this directory into the correct spots, or adding this directory to your path and granding it the correct permission.

by default, the grading script will attempt to open the file in a vscode window, this can be disabled by removing the `code "$file" -r` line
