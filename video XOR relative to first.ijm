
//specify folder
Dialog.create("Specify folder with image stack");
Dialog.addDirectory("Image stack folder", "defaultPath")
Dialog.addString("png stack file names", "pngout");
Dialog.show();
dir = Dialog.getString();
outname = Dialog.getString();
print("directory used:" + dir);

//open file sequence
//File.openSequence(dir);

//getImageInfo();
File.makeDirectory(dir + "\\imgseq");
subdir = dir + "imgseq/";
run("Image Sequence... ", "dir="+subdir+" format=PNG name="+outname);
close();
File.openSequence(dir+ "\\imgseq", "virtual");
//crop
makeRectangle(888, 344, 320, 149); 
run("Crop");

//conver to 8-bit in order to run thresehold at 160
run("8-bit");
setThreshold(160, 255, "raw");


//set measurments
run("Set Measurements...", "area display redirect=None decimal=3");

roiManager("reset") 

//find particles in stack and add to roi manager
run("Analyze Particles...", "size=500-Infinity display overlay add composite stack");


//get XOR deviation 
roiManager("Show None");
roiManager("Select", 0);
// Loop through each slice in the stack and add to end of stack XOR selection
for (i = 1; i < nSlices; ++i) {
roiManager("Select", 0);
roiManager("Select", i);
roiManager("Select", newArray(0,i));
roiManager("XOR");
roiManager("Add");
roiManager("Select", i);
}

run("Clear Results");

numSelections = roiManager("size")
// Loop through each selection and measure and rename
for (i = 0; i < numSelections; i++) {
	    roiManager("Select", i);
	    if(i == 0){
	    	roiManager("rename", "Original FIRST")
	    	
	    }
	if(i<nSlices){
		roiManager("rename", "Original" + i)
		roiManager("Set Fill Color", "red");
		
	}
	else{
		roiManager("rename", "XOR" + i-nSlices+1)
roiManager("Set Fill Color", "yellow");
	}

    run("Measure");
}
getInfo("selection.name");

//save selections:
roiManager("Save", dir + "RoiSet.zip");
saveAs("Results", dir + "Results.csv");





































