$manifestProperties = @{
    Path         = '.\PlasterManifest.xml'
    Title        = 'New PowerShell module'
    TemplateName = 'ScriptModuleTemplate'
    TemplateType = 'Project'
    TemplateVersion = '0.1.0'
    Author       = 'Halvarsson'
    Description  = 'Scaffolds the files required for a PowerShell script module'
    Tags         = 'PowerShell, Module, ModuleManifest'
    AddContent = $false
}
$Folder = Split-Path -Path $manifestProperties.Path -Parent
if (-not(Test-Path -Path $Folder -PathType Container)) {
    New-Item -Path $Folder -ItemType Directory | Out-Null
}
#New-PlasterManifest @manifestProperties
$invokePlasterTemplateProperties = @{
    TemplatePath         = '.\'
    DestinationPath      = 'D:\PSLog'
    Force                = $true
    ModuleName           = 'PSLog'
    ModuleDesc           = 'Logger for powershell scripts';
    Verbose = $true

}
if (Test-Path $invokePlasterTemplateProperties['DestinationPath'] ) {
    Remove-Item -Force -Path $invokePlasterTemplateProperties['DestinationPath'] -Recurse
}
Invoke-Plaster @invokePlasterTemplateProperties
