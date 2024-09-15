@echo off
setlocal enabledelayedexpansion
color b
set pwshcmd=powershell -noprofile -command "&{[System.Reflection.Assembly]::LoadWithPartialName('System.windows.forms') | Out-Null;$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog; $OpenFileDialog.ShowDialog()|out-null; $OpenFileDialog.FileName}"
for /f "delims=" %%I in ('%pwshcmd%') do set "FileName=%%I"
set FnS=Dosya secilmedigi icin program kapatildi.
if "%FileName%"=="" (
    start cmd /c "@echo off & mode con cols=70 lines=10 & @color b & echo - %FnS% - & pause>nul"
    exit
)
    
@echo Lutfen bosluk miktarini giriniz (3 - 10) :
@set /p margins=
@cls

@echo [1] Premiere Pro
@echo [2] DaVinci Resolve
@echo [3] Final Cut Pro
@echo [4] Video ciktisi

set /p choice=Seciminizi yapin (1-4): 

if "%choice%"=="1" (
    set "export=--export premiere"
) else if "%choice%"=="2" (
    set "export=--export resolve"
) else if "%choice%"=="3" (
    set "export=--export final-cut-pro"
) else if "%choice%"=="4" (
    set "export="
) else (
    echo Gecersiz secim. Program kapatiliyor.
    pause
    exit
)

@cls
auto-editor "%FileName%" %export% --frame-margin %margins%
@pause
