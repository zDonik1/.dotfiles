Invoke-Expression (&starship init powershell)

function Invoke-Starship-PreCommand {
    $loc = $executionContext.SessionState.Path.CurrentLocation;
    $prompt = "$([char]27)]9;12$([char]7)"
        if ($loc.Provider.Name -eq "FileSystem")
        {
            $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
        }
    $host.ui.Write($prompt)
}

# aliases
Set-Alias -Name j -Value just
Set-Alias -Name led -Value hledger 

# environment variables
$env:EDITOR = "nvim"
$env:LEDGER_FILE = "D:\ledger\2024.journal"
