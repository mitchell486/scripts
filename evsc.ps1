### GET VERSION NUMBER AND SET IT TO THE VARIABLE FOR LATER USE
$vpnui_ver=[System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe").FileVersion
### COMPARE VARIABLE TO VERSION
### THEN, IF VERSION DOES MATCH THE WRONG VERSION, UNINSTALL OLD FILE AND THEN INSTALL NEW MSI FILE WHICH IS A WORKING VERSION
If ($vpnui_ver -eq "3, 1, 05152")
{
### MAKE DIRECTORY FOR FILE AND SET A VARIABLE FOR THAT PATH
### GET FILE FROM INTERNET AND SAVE IT LOCALLY AS ANYCONNECT.ZIP IN THE NEW DIR
	mkdir "C:\TemporaryAnyConnect"
	$path="C:\TemporaryAnyConnect"
	$url="https://dl.dropboxusercontent.com/u/25040068/anyconnect-win-3.1.04059-k9.zip"
	$zip_path="C:\TemporaryAnyConnect\AnyConnect.zip"
	$client = new-object System.Net.WebClient
	$client.DownloadFile( $url, $zip_path )
### WRITE COMMAND-LET TO BE ABLE TO EXPAND FILES FROM ZIP AT ANY TIME USING -FILE AND -DESTINATION
		function Expand-ZIPFile($file, $destination)
			{
				$shell = new-object -com shell.application
				$zip = $shell.NameSpace($file)
				foreach($item in $zip.items())
					{
						$shell.Namespace($destination).copyhere($item)
					}
			}
	### USE PREVIOUSLY CREATED COMMAND-LET TO EXTRACT FILES TO DIRECTORY
		Expand-ZIPFile -File $zip_path -Destination "$path"
	### SET THIS VARIABLE TO THE PROCESS ID OF THE VPN AND KILL IT
		$vpnui=((gps vpnui*).Id)
		kill $vpnui
	### SET WMI INFORMATION OF ANYCONNECT TO VARIABLE FOR UNINSTALL THEN PUTS THE 2ND ARRAY OUTPUT INTO SECOND VARIABLE FOR LATER USE
		$any = (wmic product WHERE "Name like '%AnyConnect%'" get LocalPackage)
		$any2=$any[2]
	### USE 2ND VARIABLE TO UNINSTALL
		start-process -wait msiexec -ArgumentList /x,$any2,/quiet
	### THEN RE-INSTALL VIA MSI FILE THAT IS THE PROPER VERSION
		start-process -wait "$path\binaries\anyconnect-win-3.1.04059-web-deploy-k9.exe" -ArgumentList /quiet
	### START CISCO ANYCONNECT AFTER IT INSTALLS
		&'C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe'
	### TESTS FOR FILES TO REMOVE THEN REMOVES C:\TEMPORARYANYCONNECT AND ALL FILES
	If (Test-Path -path $path)
		{
		Remove-Item $path -Force -Recurse
		}
}