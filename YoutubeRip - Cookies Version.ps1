$location = "TEMP" #UPDATE TO YOUR OUTPUT LOCATION WITH A \ AT THE END E.G. C:TEMP\

$logfile = $location+"logs\$date.log"
$pythonScriptPath = "$psscriptroot\Backend_Files\cookies.py"

# Check if the "logs" folder already exists
if (-not (Test-Path -Path $location"logs" -PathType Container)) {
    # Create the "logs" folder if it doesn't exist
    New-Item -Path $location"logs" -ItemType Directory
    Write-Host "The 'logs' folder has been created."
} else {
    Write-Host "The 'logs' folder already exists."
}

Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}

$lb = "`n --------------------------- `n"

Set-Location -Path $psscriptroot
$linksfile = "$psscriptroot\links.txt"
$links = Get-Content $linksfile

python $pythonScriptPath -Wait
Logwrite "Python Script run, Cookies.txt made"
Start-Sleep -Seconds 60
Logwrite "Importing links"

Logwrite "$lb Setting location to: $location"

$day = get-date -Format dd-MM-yyyy-hh-mm #current Date

Logwrite "$lb Date is: $day"

$date = "Batch-" + $day #folder name

Logwrite "$lb Folder name is: $date"


$name = "\%(playlist_title)s\%(title)s.%(ext)s" #YT-dl file name

$endpath = $location + "Batch-" + $day #folder location and name

New-Item -ItemType Directory -Path $endpath

Logwrite "$lb Folder made location is: $endpath"

Logwrite "$lb Starting donwloads"



foreach ($line in $links){

Write-Host $line

$path = "`"$endpath$name`"" #combined path and file name


Write-host "$lb DOWNLOADING"

Logwrite "$lb DOWNLOADING..."


#Video + Subs
.\yt-dlp.exe --write-sub --convert-subs srt --sub-lang en -f bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best --newline -i -o $path --ignore-config --hls-prefer-native --cookies "$psscriptroot\cookies.txt" $line

#Just Subs
#.\yt-dlp.exe --write-sub --convert-subs srt --sub-lang en --skip-download -o $path --ignore-config --cookies "$psscriptroot\cookies.txt" $line

Write-host "$lb DOWNLOADED"

Logwrite "$lb DOWNLOAD FINISHED"



Logwrite "$lb Sleep started, next download in 5 seconds..."

$i = 5
do {
   Logwrite "$i"
    Sleep 1
    $i--
} while ($i -gt 0)

}