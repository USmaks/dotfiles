function global:prompt {
    $origLASTEXITCODE = $LASTEXITCODE
    Write-VcsStatus

    # Replace $home by ~ if current path includes $home
    $curPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    if ($curPath.ToLower().StartsWith($Home.ToLower()))
    {
        $curPath = "~" + $curPath.SubString($Home.Length)
    }

    # Limit path length up to maxPathLength
    $maxPathLength = 40
    if ($curPath.Length -gt $maxPathLength) {
        $curPath = '...' + $curPath.SubString($curPath.Length - $maxPathLength + 3)
    }

    Write-Host $curPath -ForegroundColor DarkGreen
    $global:LASTEXITCODE = $origLASTEXITCODE

    if ($?) {
        Write-Host " (*'-')"  -NoNewLine -ForegroundColor "DarkGreen"
    } else {
        Write-Host " (*;-;)"  -NoNewLine -ForegroundColor "Red"
    }
    return "> "
}
