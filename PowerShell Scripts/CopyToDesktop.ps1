$DesktopPath = [Environment]::GetFolderPath("Desktop")
$File = $DesktopPath + "\(File name)"

if(![System.IO.File]::Exists($File)){
    # file with path $path doesn't exist
    xcopy "Src" "Dst"
}