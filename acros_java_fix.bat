@echo off
rem START JAVA SO THAT FILE IS CREATED.
"C:\Program Files (x86)\Java\jre6\bin\javacpl.exe"
rem FIND PROCESS ID AND KILL IT AGAIN
for /f "TOKENS=1" %%a in ('wmic PROCESS where "Name='javaw.exe'" get ProcessID ^| findstr [0-9]') do set PID=%%a
rem KILL PROCESS BASED ON VARIABLE
taskkill /PID %PID% /F
rem SET VARIABLE FOR THE PROPERTIES FILE
set prop=%userprofile%\appdata\locallow\sun\java\deployment\deployment.properties
rem CHECKS FOR STRING
findstr "deployment.security.mixcode=HIDE_RUN" %prop% &&(
                set var=1
                ) || (
                set var=0
                )
rem TEST FILE TO SEE IF THAT VALUE IS ALREADY SET. IF SO, VAR IS 1, IF NOT, VAR IS 0
rem IF VAR IS 1, DO NOTHING, IF VAR IS 0, APPEND DATA
If %var% == 0 (
                echo deployment.security.mixcode=HIDE_RUN>> %prop%
                )
rem SHOULD WORK JUST FINE FROM NOW ON.
