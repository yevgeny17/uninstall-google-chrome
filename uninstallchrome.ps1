#Following steps are being used to uninstall the current version of Google Chrome

Write-host "Un-Installing the current version of Google Chrome from your machine..."
if($AppInfo = Get-WmiObject Win32_Product -Filter "Name Like 'Google Chrome'"){
	Write-Host 'Using Win32_Product info to uninstall' -fore green
	& ${env:WINDIR}\System32\msiexec /x $AppInfo.IdentifyingNumber /Quiet /Passive /NoRestart
}
if($Reg32Key = Get-ItemProperty -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Google Chrome' -name Version -ErrorAction SilentlyContinue){
	Write-Host 'Reg 32 version found' -fore green
	if($Ver32Path = $Reg32Key.Version){
		Write-Host 'Reg 32 path' + $Ver32Path -fore green
		& ${env:ProgramFiles}\Google\Chrome\Application\$Ver32Path\Installer\setup.exe --uninstall --multi-install --chrome --system-level --force-uninstall
	}
}
if($Reg64Key = Get-ItemProperty -path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Google Chrome' -name Version -ErrorAction SilentlyContinue){
	Write-Host 'Reg 64 version found' -fore green
	if ($Ver64Path = $Reg64Key.Version){
		Write-Host 'Reg 64 path' + $Ver64Path -fore green
		& ${env:ProgramFiles}\Google\Chrome\Application\$Ver64Path\Installer\setup.exe --uninstall --multi-install --chrome --system-level --force-uninstall
	}
}
