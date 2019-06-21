--------------
**** DHMP ****
--------------
DOOM High-resolution Model Project
* [Download](http://dhmp.hiriwa.com/)
* [GitHub](https://github.com/KuriKai/DHMP/)
* [Forum](http://dengine.net/forums/viewtopic.php?f=3&t=877#topic)




----------------------
**** Introduction ****
----------------------

History:
The DHMP (DOOM High-resolution Model Project) is a community driven project that had is birth as the dmp (Doom model project). Back when the doomsday engine had support for md2 and dmd low resolution models. Most of the models that were availible to play with looked nothing like the original sprites.

Aim:
The aim of the DHMP is to get faithfully recreated high resolution models that may also have inspiration from the concept sketches and models the id create when making DOOM

 It will also be a lot more tightly controlled than its predecessor, in regards to both copyrights and quality control.

---------------------------------
**** Copyright / Permissions ****
---------------------------------
All submitted work must be under the "Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License."

-----------------------
**** Participation ****
-----------------------

* [How to export models from blender to fbx format](https://github.com/KuriKai/dhmp/wiki/Model-exporting)
* [Tips on Dei creation](https://github.com/KuriKai/dhmp/wiki/Dei-creation)

----------------------------
**** Build Instructions ****
----------------------------


**Steps: Debian/Redhat based distro**  
git clone https://github.com/KuriKai/dhmp.git  
cd dhmp/build  
./dhmp-doomsday.sh  
   
**Steps: Windows with Git for Windows**   
1. Install [Git for Windows](https://gitforwindows.org/).   
   1. During "Select Components", make sure "Associate .sh files to be run with Bash" is ticked and installed.  
1. After installation, add zip command to Git for Windows.  

   Git for Windows does not have the zip command by default.
   It needs to be downloaded and installed correctly for the bash script to run correctly.    

   1. Follow the instructions at [Add zip into Git Bash for Windows](https://ranxing.wordpress.com/2016/12/13/add-zip-into-git-bash-on-windows/) to run the zip command without error.   

1. Download [DHMP](https://github.com/KuriKai/dhmp/), click "Clone or Download" -> "Download ZIP"  
1. Unpack the DHMP-master.zip with one of the following:  
   1. Windows Built-In: Right-Click the file -> "Open With" -> Windows Explorer. Select all files and copy them (e.g. your Desktop)  
   1. WinRAR: Right-Click the file -> "Unpack here"  
   1. 7-Zip: Right-Click the file -> "7-Zip" -> "Unpack Here"  
1. Open the "DHMP-master" folder, then open the "build" folder  
1. Run the required file (e.g. dhmp-all.sh)  
1. After it is done go back to the "DHMP-Master" folder and open the "doomsday" folder  
1. Select all files and put them into an archive with one of the following:  
   1. Windows built-in: Right-Click them and select "Sent to" -> "ZIP-compressed folder". Rename the created ZIP-File, the name can be any, however, the ideal name would be DHMP and the current date and the file-prefix should be PK3 (e.g. DHMP-20190516.pk3) so you know when this file was last updated.  
   1. 7-Zip: Right-Click them and select "7-Zip" -> "Add to archive". Select ZIP as the archive format. The name can be any, however, the ideal name would be DHMP and the current date and the file-prefix should be PK3 (e.g. DHMP-20190516.pk3) so you know when this file was last updated.   

