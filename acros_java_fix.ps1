### SET VARIABLE FOR THE PROPERTIES FILE
$prop = "~\appdata\locallow\sun\java\deployment\deployment.properties"
### SET VARIABLE FOR IF HIDE_RUN HAS BE SET
$results = (Get-Content $prop | Select-String "deployment.security.mixcode=HIDE_RUN" -quiet)
### TEST FILE TO SEE IF THAT VALUE IS ALREADY SET, IF SO, NOTHING HAPPENS. IF NOT SET, CONTINUE
If ($results -ne "True")
                {
### APPENDS THE TEXT TO THE END OF THE FILE WITH A NEW LINE
add-content -Path $prop -Value "deployment.security.mixcode=HIDE_RUN"
                }
