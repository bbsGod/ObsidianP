set REPOSITORY_PATH=D:\WorkTools\Tools\Maven\misbootOffline
rem 正在搜索...
for /f "delims=" %%i in ('dir /b /s "%REPOSITORY_PATH%\*_remote.repositories*"') do (
    del /s /q %%i
)
rem 搜索完毕
pause