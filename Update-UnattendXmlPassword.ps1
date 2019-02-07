function Update-UnattendXmlPassword {
  param (
    [Parameter(Mandatory)]
    $Path,

    [Parameter(Mandatory)]
    [string]
    $Password
  )
  $ErrorActionPreference = 'Stop'
  try {
    $ResolvedPath = (Resolve-Path -Path $Path).Path
    [xml]$UnattendXml = Get-Content -Path $ResolvedPath
    $AdminPW = $UnattendXml.unattend.settings.component.useraccounts.administratorpassword
    if ($AdminPW.PlainText -eq 'false') {
      $PlainText = '{0}AdministratorPassword' -f $Password
      $AdminPW.Value = [System.Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($PlainText))
    }
    else {
      $AdminPW.Value = $Password
    }
    $UnattendXml.Save($ResolvedPath)
  }
  catch {
    $_.Exception.Message
  }
}
