param($tipoDeExportacao)
$ErrorActionPreference = "stop";
#comentario

<#
comentário 
varias 
linhas
#>

$ExpName = @{
    Label="Nome";
    Expression={$_.Name}
};

$ExpLength = @{
    Label="Tamanho";
    Expression={ "{0:N2}KB" -f ($_.length / 1kb) }
};

$params = $ExpName, $ExpLength; 

$resultado = Get-ChildItem -Recurse -File |
    Where-Object Name -like "*relatorio*" |
    Select-Object $params;

if($tipoDeExportacao -eq "html"){
    $estilos = Get-Content estilos.css;
    $styletage = "<style>$estilos</style>"
    $tituloPagina = "Relatorio de scripts em migração"
    $tituloBody = "<h1>$tituloPagina</h1>"
    
    $resultado | 
        ConvertTo-Html -Head $styletage -Title $tituloPagina -Body $tituloBody| 
        Out-File "relatorio.html"
} elseif ($tipoDeExportacao -eq "json"){
    $resultado |
    ConvertTo-Json |
    Out-File "relatorio.json"
} elseif($tipoDeExportacao -eq "csv"){
    $resultado |
    ConvertTo-Csv -NoTypeInformation |
    Out-File "relatorio.csv"
}
