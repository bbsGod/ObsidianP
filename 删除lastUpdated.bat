set REPOSITORY_PATH=D:\WorkTools\Tools\Maven\misbootOffline\responstyNew122
for /f "delims=" %%i in ('dir /b /s "%REPOSITORY_PATH%\*lastUpdated*"') do (
    del /s /q %%i
)
pause
