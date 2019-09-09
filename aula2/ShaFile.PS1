function Get-FileSHA1(){

    param(        
        [Parameter(
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = "FullName",
            Mandatory = $true
        )]
        [String] $filePath
    )

    begin{
        $sha1 = New-Object -TypeName System.Security.Cryptography.SHA1Managed;
        $prettyHashSB = New-Object System.Text.StringBuilder;
    }

    process{
        $fileContent = Get-Content $filePath;
        $fileBytes = [System.Text.Encoding]::UTF8.GetBytes($fileContent);
        $hash = $sha1.ComputeHash($fileBytes);        

        foreach ($byte in $hash) {
            $hexaNotation = $byte.ToString("X2");
            $prettyHashSB.Append($hexaNotation) > $null
        }
        $prettyHashSB.ToString()
    }

    end{
        $prettyHashSB.Clear() > $null;        
        $sha1.Dispose();
    }
}

function Get-FileSHA256($filePath){
    $fileContent = Get-Content $filePath;
    $fileBytes = [System.Text.Encoding]::UTF8.GetBytes($fileContent);
    
    $sha1 = New-Object -TypeName System.Security.Cryptography.SHA256Managed;
    $hash = $sha1.ComputeHash($fileBytes);

    $prettyHashSB = New-Object System.Text.StringBuilder;
    foreach ($byte in $hash) {
        $hexaNotation = $byte.ToString("X2");
        $prettyHashSB.Append($hexaNotation) > $null
    }
    $prettyHashSB.ToString()
}

function Get-FileSHA386(){

}