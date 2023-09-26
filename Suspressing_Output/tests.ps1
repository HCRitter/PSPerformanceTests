Import-Module Benchpress

$sizes = 10,100,1000,10000,100000,1000000,10000000

$Reports = $sizes.ForEach({
    bench -Technique @{

        "Size: $PSitem - Out-Null -InputObject" = {
            $a = new-object Collections.ArrayList
            Out-Null -InputObject (0..$PSItem).ForEach({$a.Add(5)})
        }
        "Size: $PSitem - [void]" = {
            $a = new-object Collections.ArrayList
            [void](0..$PSItem).ForEach({$a.Add(5)})
        }
    
    } -RepeatCount 2
})

$UserGroups = (Get-ADUser -Identity $UPN -Property MemberOf).MemberOf.ForEach({
    ($PSItem | get-AdGrup).Name
})

$PredefindedGroups = @("A","B","C")
$GroupMemberShip = [ordered] @{

}
$PredefindedGroups.ForEach({
    $GroupMemberShip[$PSItem] = $UserGroups.contains($PSItem)
})
