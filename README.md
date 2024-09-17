# Bulk-Youtube-dlp
This is my personal script setup for downloading videos from youtube or similar sites in bulk. There are two version of the script available, the Base copy and one that utilises your Youtube cookies.

**Base Version:** This script will take all of the links located in the links.txt file and will recursively download them to your designated Output folder, along with their subtitles.

**Cookies Version:** The Cookies version of the script will perform all the same steps as the Base version but will utilise a python script to extract your Youtube cookies to the script folder and download the files using your cookies. This should be used if you are trying to download private videos you have permission to or content behind a youtube membership.

Usage: **If running the cookies version of the script ensure you have closed all Firefox windows before starting the script. Once the cookies file is generated you can reopen Firefox fine.** 
1. No matter which script you are running, ensure you update the output location in line 1 with your desired output location.
2. Update links.txt with your desired playlists/videos.
3. Run the respective .ps1 file, either the base version or cookies version.
4. The script will proceed to download the videos and their subtitles, if present, one after another and deposit them in the output folder set in step 1.
5. Navigate to your output location where you should now find the the videos located in a file named with the date and time it was generated, "Batch-%%-%%-%%%%-%%-%%", lone videos will be in their own folders named NA, if you donwloaded a playlist it will have the playlist title as the folder name.


If you are using the version with cookies, ensure you have installed the browser-cookie3 python package and insure that you are signed into youtube on Firefox.
```
pip install browser-cookie3
```
