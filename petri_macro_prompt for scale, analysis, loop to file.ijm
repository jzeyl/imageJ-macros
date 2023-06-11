
//wrap image processing sequence as a function
function process (){
	run("Rotate 90 Degrees Left");
	// prompt the user to set scalebar to known distance of 10 cm
	setTool("line");
	run("8-bit");// convert image to 8-bit grayscale
	title = "Set Scale";//dialog prompt
	msg = "Draw Scale line for 15cm bar, then click \"OK\".";
	waitForUser(title, msg);//display message
	run("Measure");//to get the length of the line drawn, to be printed to the log
	//print(Table.title);
	print("Drawn scale line is "+ Table.get("Length") + " pixels");
	drawnlngth = Table.get("Length");//take the length from measurement table and use to set scale
	run("Set Scale...", "distance="+drawnlngth+" known=15 unit=cm");//sets length to 10cm
	//run("Set Scale...");
	//4. prompt user to crop the region of interest
	setTool("rectangle");
	title = "Crop region of interest";//dialog prompt
	msg = "Draw rectangle around samples, then click \"OK\".";
	waitForUser(title, msg);//display message
	//5. crop selected rectangle
	run("Crop");
	//setAutoThreshold("Default dark no-reset");
	//run("Auto Threshold", "method=Default white");
	//run("Auto Threshold", "method=MaxEntropy white");
	run("Threshold...");
 	title = "Set Threshold";//dialog prompt
	msg = "Set threshold, then click \"OK\".";
	waitForUser(title, msg);//display message
    run("Analyze Particles...");
    //sort results table by size
	Table.sort("Area");
	//sort descending by area (high to low)
	n = Table.size;
	print(n);
	Table.setColumn("idx", Array.reverse(Array.getSequence(n)));
	Table.sort("idx");
	Table.deleteColumn("idx");
	//run("Analyze Particles...", "size=0.01-Infinity display clear");
	for (i=0; i<nResults; i++) {
	result_feret = getResult("Feret",i);
	result_area = getResult("Area",i);
	result = filename+ "," + result_feret +" , " + result_area;
	print(result);
	File.append(result, outputFilePath);	
	}

}
//draw max ferets diameter on all selections  
function drawAllFeretsDiameters() {
    for (i=0; i<nResults; i++) {
        x = getResult('XStart', i);
        y = getResult('YStart', i);
        doWand(x,y);
        drawFeretsDiameter();
        if (i%5==0) showProgress(i/nResults);
   }
    run("Select None");
}

function drawFeretsDiameter() {
     requires("1.29n");
     run("Line Width...", "line=2");
     diameter = 0.0;
     getSelectionCoordinates(xCoordinates, yCoordinates);
     n = xCoordinates.length;
     for (i=0; i<n; i++) {
        for (j=i; j<n; j++) {
            dx = xCoordinates[i] - xCoordinates[j];
            dy = yCoordinates[i] - yCoordinates[j];
            d = sqrt(dx*dx + dy*dy);
            if (d>diameter) {
                diameter = d;
                i1 = i;
                i2 = j;
            }
        }
    }
    setForegroundColor(255,127,255);
    drawLine(xCoordinates[i1], yCoordinates[i1],xCoordinates[i2],yCoordinates[i2]);
}

//process();

dir = getDirectory("Choose a Directory"); // Select the folder containing the image files
outputFilePath = dir + "results.txt"; // Path to the output text file
fileList = getFileList(dir); // Get a list of all files in the directory
Array.print(fileList); 
print(dir + fileList[0])
for (i = 0; i < fileList.length; i++) {
    filePath = dir + fileList[i];
    if (endsWith(filePath, ".png")) {
        print(filePath);
    open(filePath); // Open the image file
    filename = getTitle();
    process(); // Replace "Your_Process" with the actual process you want to run
    drawAllFeretsDiameters();  
    //close(); // Close the image file
    }
}





















































