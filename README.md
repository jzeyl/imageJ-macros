# ImageJ plugins
This repository is a collection of plugins to automate image analysis in [ImageJ](https://imagej.net/). Mainly these are written mainly written in the [ImageJ macro language](https://imagej.net/ij/developer/macro/macros.html#ext) and often include pop-up GUI dialog boxes to adjust routine parameters. These are 
|FileName|Purpose|
|--------|-------|
|*draw feretds diameter and bounding box.txt*|Routine to set scale, crop, detect threshold, and measure ferrets diameter of high contrast objects (leaf measurement)|
|*draw, measure and save shortest distance btwn selections.ijm*|Automatically detect particles and calculate distance between first and second largest regions in image. Save to file. |
|*Max_IntensityFromPlotProfile.ijm*| Save the results of the plot profile method (pixel values across a line ROI) for a stack of images |
|*jul28_ tempering*| Count particles of tempered glass and save to file, exclude only 2 edges from particle count. Intented for use with webcam module to capture images with a hotkey press|
|*video XOR relative to first.ijm*| Computes ROI for each slice in an image stack, then computes XOR selection between selection in each slice and first alice, saves to text file |

# Options to Run or Install an ImageJ Macro Plugin

## OPTION 1 - RUN MACRO by simply opening file:
Go to Plugins>Macro>Run… and select the .ijm macro file. Macro code will run.
## OR
## OPTION 2 - OPEN CONTENTS OF MACRO and then run all or part of the macro code:
Go to Plugins>Macros>Edit… and select the .ijm file.
In the Macro editor that opens, you can run specific lines (select code regions and press 
Ctrl+Shift+R), or the entire macro (press Ctrl+R)
## OR
## OPTION 3 - INSTALL MACRO into the Imagej menu:
To install a macro so that it is available inside the ImageJ plugins menu, go to Plugins> 
Install... At the prompt, upload the .ijm file. Next you are prompted with the location to save 
the macro. It will by default show the 'Plugins' folder of your ImageJ installation. Saving here 
will mean that the macro will be saved and appear under the ‘Plugins’ menu bar. To have the 
macro available under Plugins>Macros, save the ijm file inside the Macros subfolder of the 
‘Plugins’ folder. After restarting ImageJ, the macro will be available to run from the menu. 
Note the macro filename should have an underscore in the name to be recognized from the 
menu