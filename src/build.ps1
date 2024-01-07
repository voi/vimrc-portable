using namespace System.IO
using namespace System.Collections
using namespace System.Collections.Generic

####
$lines = [List[string]]::new()

####
foreach($file in (Get-ChildItem *.vim | Sort-Object)) {
    ##
    $lines.Add('" *****************************************************************************') | Out-Null
    $lines.Add('"""" ' + $file.Name + '  {{{') | Out-Null

    foreach($line in Get-Content -LiteralPath $file -Encoding UTF8) {
        $lines.Add($line) | Out-Null
    }

    $lines.Add('"""" }}}') | Out-Null
    $lines.Add('') | Out-Null
}

####
foreach($file in (Get-ChildItem plugin/*.vim | Sort-Object)) {
    ##
    $lines.Add('" *****************************************************************************') | Out-Null
    $lines.Add('"""" plugin/' + $file.Name + '  {{{') | Out-Null

    foreach($line in Get-Content -LiteralPath $file -Encoding UTF8) {
        $lines.Add($line) | Out-Null
    }

    $lines.Add('"""" }}}') | Out-Null
    $lines.Add('') | Out-Null
}

####
$lines.Add('""""""""') | Out-Null
$lines.Add('runtime _local_*.vim') | Out-Null
$lines.Add('') | Out-Null

$path = Resolve-Path -LiteralPath ..\vimrc
$lines | Set-Content -LiteralPath $path -Encoding UTF8
$lines = [File]::ReadAllText($path).Replace("`r`n", "`n")
[File]::WriteAllText($path, $lines)

