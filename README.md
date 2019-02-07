# Update-UnattendXmlPassword
PowerShell function that changes the password in an Unattend.xml file

The password in an unattend.xml could defined in plain text or encrypted (meaning base64 encoded). The function helps to update an encrypted password.

First, the function looks for the value of the PlainText node within the given file:

    <AdministratorPassword>
      <Value>...</Value>
      <PlainText>false</PlainText>
    </AdministratorPassword>

If it is set to "false", the function will append the usage of the password (that is the name of the parent XML node, AdministratorPassword) to the given password. Afterwards, it will convert the resulting string to base64, update the Value node (see above) and save the file.

Please note: the function overwrites the given unattend.xml without warnings.
