function Update-UnattendXmlPassword
{
  param
  (
    [Parameter(Mandatory)]
    $Path
    ,
    [Parameter(Mandatory)]
    [string]
    $Password
  )
  $ErrorActionPreference = 'Stop'
  try
  {
    [xml]$UnattendXml = Get-Content -Path $Path
    $AdminPW = $UnattendXml.unattend.settings.component.useraccounts.administratorpassword
    if ($AdminPW.PlainText -eq 'false')
    {
      $PlainText = '{0}AdministratorPassword' -f $Password
      $AdminPW.Value = [System.Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($PlainText))
    }
    else
    {
      $AdminPW.Value = $Password
    }
    $UnattendXml.Save($Path)
  }
  catch
  {
    $_.Exception.Message
  }
}
