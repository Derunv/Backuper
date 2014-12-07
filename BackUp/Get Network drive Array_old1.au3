; Script Start
#include<ButtonConstants.au3>
#include<GUIConstantsEx.au3>
#include<GUIConstants.au3>
#include<Array.au3>
Func NetDrivesSave()
$aNetDrive = DriveGetDrive('NETWORK')
$i = 0
$avNetDriveIniWrite = $aNetDrive
ReDim $avNetDriveIniWrite[UBound($aNetDrive)][2]
While $i<= UBound($aNetDrive)-1
		$avNetDriveIniWrite[$i][0] = $aNetDrive[$i];
		$avNetDriveIniWrite[$i][1] = DriveMapGet($aNetDrive[$i]);
	$i += 1
WEnd
IniWriteSection('backup.ini', 'NetworkDrives', $avNetDriveIniWrite)
EndFunc