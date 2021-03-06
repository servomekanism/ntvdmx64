if "%_NTDRIVE%"=="" set _NTDRIVE=W:
if "%_NTROOT%"=="" set _NTROOT=\nt

pushd %_NTDRIVE%%_NTROOT%\private
setlocal

call %_NTDRIVE%%_NTROOT%\public\tools\chksizzle.cmd
if errorlevel 1    goto End

cd %_NTROOT%\private

if exist zUPDNTVERP.cmd (
    call zUPDNTVERP.cmd
    if errorlevel 1 goto Error
)

cd %_NTROOT%\private
if exist zUPDRES.cmd (
    call zUPDRES.cmd
    if errorlevel 1 goto Error
)
%_NTDRIVE%

echo Building mvdm
cd %_NTROOT%\private\mvdm
set HAXM=1
build %BldFlags%
if errorlevel 1 goto Error
cd %_NTROOT%\private

:Error
echo.
echo Build error. Process aborted.
echo.
goto End

:End

endlocal
popd
