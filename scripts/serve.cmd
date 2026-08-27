@echo off
setlocal
cd /d "%~dp0.."
call scripts\_ensure.cmd --hugo
if errorlevel 1 exit /b 1
hugo server --disableFastRender --cleanDestinationDir --config hugo.toml
exit /b %ERRORLEVEL%
