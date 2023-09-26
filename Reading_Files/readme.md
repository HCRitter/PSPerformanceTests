# PowerShell performance tests for file reading

## Test scenario

Goal is to read a large file and find all lines which are longer than 10 characters
The Test file is a public weak password list from this Github-Repository

## Methods tested

- Get-Content -> Where-Object
- Get-Content -> foreach()
- [system.io.file] --> ReadAllLines()
- [System.IO.StreamReader] --> ReadLine()
- Switch -File --> Default case
- Switch -File --> Condition case


All tests have been made with the PowerShell 'Benchpress' module
