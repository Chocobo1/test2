@echo off
rem Place this file at the root of the src lib

call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x64_x86

set OPENSSL_X32_DIR=c:\openssl_32

mkdir _build && cd _build

C:\Strawberry\perl\bin\perl ..\Configure VC-WIN32 no-shared --prefix="%OPENSSL_X32_DIR%" --openssldir="%OPENSSL_X32_DIR%\ssl"
powershell -Command "& { (Get-Content 'makefile') | ForEach-Object { $_ -replace '/debug', '/debug /opt:ref /opt:icf /incremental:no' } |  Set-Content 'makefile' }"

nmake install

copy "app.pdb" "%OPENSSL_X32_DIR%\lib"
