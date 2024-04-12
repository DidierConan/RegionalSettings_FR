# Script to define regional settings on Azure Virtual Machines deployed from the market place
# Author: Alexandre Verkinderen
# Blogpost: https://mscloud.be/configure-regional-settings-and-windows-locales-on-azure-virtual-machines/
#
######################################33
# Write-Host -BackgroundColor Red -ForegroundColor Black "ATTENTION LA VDI VA REBOOTER, merci de patienter"
#variables

$regionalsettingsURL = "https://github.com/DidierConan/RegionalSettings_FR/FrRegion.xml"
$RegionalSettings = "C:\Program Files (x86)\Outils\FrRegion.xml"

#downdload regional settings file
$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($regionalsettingsURL,$RegionalSettings)

# Set Locale, language etc. 
& $env:SystemRoot\System32\control.exe "intl.cpl,,/f:`"$RegionalSettings`""

# Set languages/culture. Not needed perse.
# Set-WinSystemLocale fr-FR
# Set-WinUserLanguageList -LanguageList fr-FR -Force
# Set-Culture -CultureInfo fr-FR
# Set-WinHomeLocation -GeoId 84

cmd /c 'reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v fEnableTimeZoneRedirection /t REG_DWORD /d 1 /f'


# restart virtual machine to apply regional settings to current user. You could also do a logoff and login.
Start-sleep -Seconds 40
Restart-Computer