### Written by: Mitch Bumgarner 03/14/14
### This script is to check if a certain xml file exists, if so
### it then removes the file and runs rest of the script, if not, ends.

# MAIN FUNCTION TO TEST IF FILE EXISTS.
If (Test-Path -path 'C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Profile\Frattu.xml')
	{
	# IF DOES EXISTS, REMOVE. SET VARIABLE TO GET-PROCESS. .Id IS THE HEADER THAT FILTERS OUTPUT
	# SETS THAT OUTPUT TO THE VARIABLE.
		Remove-Item 'C:\ProgramData\Cisco\Cisco AnyConnect Secure Mobility Client\Profile\Frattu.xml'
		$vpnui=((gps vpnui*).Id)
		# IF VARIABLE IS NOT NULL, KILL VARIABLE OUTPUT WHICH SHOULD BE PROCESS ID
		# RE-RUN EXE AFTER KILLING IT.
		if ($vpnui -ne $null)
			{
			kill $vpnui
			&'C:\Program Files (x86)\Cisco\Cisco AnyConnect Secure Mobility Client\vpnui.exe'
			}
	}

