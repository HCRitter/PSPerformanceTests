Import-Module Benchpress

$LargeFilePath = "$PSScriptRoot\10-million-password-list-top-1000000.txt"

bench -Technique @{
    "Get-Content -> Where-Object" = {
        $Lines = Get-Content -Path $LargeFilePath | Where-Object{$PSItem.Length -gt 10}
    }
    "Get-Content -> foreach()" = {
        $Content = Get-Content -Path $LargeFilePath
        $Lines = foreach($Line in $Content){
            if($Line.Length -gt 10){
                $line
            }
        }
    }
    "[system.io.file] --> ReadAllLines()" = {
        $Content = [system.io.file]::ReadAllLines($LargeFilePath)
        $Lines = foreach ($Line in $Content){
            if($Line.Length -gt 10){
                $line
            }
        }
    }
    "[System.IO.StreamReader] --> ReadLine()" = {
        $sread = [System.IO.StreamReader]::new($LargeFilePath) 
        $Lines = while ($line = $sread.ReadLine()) {
            if($Line.Length -gt 10){
                $Line
            }
        }
    }
    "Switch -File --> Default case" = {
        $Lines = Switch -File ($LargeFilePath){
            Default{
                if($PSitem.Length -gt 10){
                    $PSitem
                }
            }
        }
    }
    "Switch -File --> Condition case" = {
        $Lines = Switch -File ($LargeFilePath){
            {$PSitem.Length -gt 10}{
                $PSitem
            }
        }
    }



} -GroupName "Read Large Files" -RepeatCount 2

[PSCustomObject]@{
    Name = $null
    DisplayName = $null
    Telephone = $null
    EmailAddress = $null
    Gender = $null
    Street = $null
    City = $null
}