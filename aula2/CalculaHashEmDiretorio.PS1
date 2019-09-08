param($diretorio)

$ErrorActionPreference = "stop"

. .\aula2\ShaFile.PS1
$arquivos = Get-ChildItem $diretorio -File -Recurse

foreach ($arquivo in $arquivos | Select-Object FullName) {
    $hashDoArquivo = Get-FileSHA1 $arquivo
    Write-Host "O hash do arquivo $arquivo eh $hashDoArquivo !"
}

