//select input file
path = File.openDialog("Select input File");
open(path); // open the file
  
//set output directory
outputdirectory = getDirectory("Choose output folder"); 
print("Saving to: " +outputdirectory)

//to hardcode the output directory, putyour path in the line below (remove first two '//' from next line to allow code to run) 
//outputdirectory = "C:\\Users\\user\\Desktop\\output_TEST\\"
//print("Saving to: " +outputdirectory)

//get filename
filename = getTitle()
print("filename:" + filename)

//USE CODE IN THIS SECTION TO select regions by wand tool, if desired///
//setTool("wand");
//title = "Select ROI 1";
//msg = "Select left region, then click \"OK\".";
//waitForUser(title, msg);
//roiManager("Add");
//select region 2 by wand
//title = "Select ROI 2";
//msg = "Select right region, then click \"OK\".";
//waitForUser(title, msg);
//roiManager("Add");

//select white particles
setOption("BlackBackground", true); // should be used at the start of any macro
run("Make Binary");
//run("Create Selection");
//setThreshold(127, 255);
run("Create Selection");
run("Analyze Particles...", "  show=Nothing clear record"); //add 'display' between Nothing and clear to show results


//sort results table by size
Table.sort("Area");

//sort descending by area (high to low)
n = Table.size;
print(n)
Table.setColumn("idx", Array.reverse(Array.getSequence(n)));
Table.sort("idx");
Table.deleteColumn("idx");

// delete all particle except the two largest
Table.deleteRows(2, n-1);

//sort descending by xStart (i.e., the one on the left is first)
Table.sort("XStart");

//add particle results tables as ROIs
for (i=0; i<nResults; i++) {
      x = getResult('XStart', i);
      y = getResult('YStart', i);
      doWand(x,y);
      roiManager("add");
  }

//get selection coordinates of second ROI
roiManager("select", 1);
run("Interpolate", "interval=1");
roiManager("update");
getSelectionCoordinates(u, v);
len0 = u.length;
//print(len0)


//get selection coordinates first ROI
roiManager("select", 0);
run("Interpolate", "interval=1");
roiManager("update");
getSelectionCoordinates(x, y);
len1 = x.length;
//print(len1)

//calculate shortest distance between two regions
distFinal = sqrt((u[0]-x[0])*(u[0]-x[0]) + (v[0]-y[0])*(v[0]-y[0]));
xStart = u[0];
yStart = v[0];
uEnd = x[0];
vEnd = y[0];
for(j=1; j<len0; j++)
	for(i=1; i<len1; i++) {
	dist = sqrt((u[j]-x[i])*(u[j]-x[i]) + (v[j]-y[i])*(v[j]-y[i]));
	if(dist < distFinal) {
		distFinal = dist;
		xStart = x[i];
		yStart = y[i];
		uEnd = u[j];
		vEnd = v[j];
	}
}

//get filename
filename = getTitle()
print("filename:" + filename)

//print results
print("filename: "+filename)
print("smallest_distance: "+distFinal)	
print("coordiatePoint1X: "+xStart	)
print("coordinatePoint1Y: "+yStart)	
print("coordinatePoint2X: "+uEnd)	
print("coordianatepoint2Y: "+vEnd)


//assign line as ROI
makeLine(xStart, yStart, uEnd, vEnd);
roiManager("add");
roiManager("Select", roiManager("count")-1);
roiManager("Rename", "shortest_line");
run("Draw", "slice");


//save data
resultpath = outputdirectory + filename+"_result.csv";
File.append("filename, " + "smallest_distance,"+ "coordiatePoint1X,"+ "coordinatePoint1Y,"+"coordinatePoint1Y", resultpath);
File.append(filename + "," + distFinal + "," + xStart + "," + yStart + "," + uEnd + "," + vEnd, resultpath);
print("Saved to: "+ resultpath);
saveAs("tiff", outputdirectory + filename + "_drawn_distance.tif");

// To close all open windows, run the code below (remove the '//' at the beginning of each line
//if (isOpen("Log")) {
//     selectWindow("Log");
//     run("Close" );
//}
//close("*");
//if(isOpen("ROI Manager")) {
//selectWindow("ROI Manager");
//         run("Close" );
//}
//close("*");



























































































