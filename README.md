# ECE 1400 Grading Scripts

These scripts are meant to be used for speeding up the grading process for ECE 1400
students. Included currently are 2 scripts, `grade` and `grade_all.sh` (wip).

## `Grade`

To run grade, use the following format

```
grade [studentfile.c] [[inputfile]]
```

If the inputfile is not provided, it searches for an `input.txt` in the same directory as the student assignments. This is useful if you want to double check a student's answer with a second input file.

the grading scripts can be added to your system path by cloning this directory into the correct spots, or adding this directory to your path and granding it the correct permission.
