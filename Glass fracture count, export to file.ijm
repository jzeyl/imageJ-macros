filename = getTitle()
print(filename)

//set output directory
outputdirectory = getDirectory("Choose output folder"); 
print("Saving to: " +outputdirectory)
//specify minimum size of particles
minval = getNumber("Select minimum particle size", 50);
//print(minval)

//duplicate image and do 8-bit
run("Duplicate...", "title=8bit");
run("8-bit");
//duplicate image 
run("Duplicate...", "title=blackbackground and binary");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Invert");
//watershed segmentation
run("Duplicate...", "title=watershed segmentation");
run("Watershed");

//saveAs("tiff", outputdirectory + filename + "_watershed.xls");

//count particles INCLUDING edges
run("Analyze Particles...", "size="+ minval + "-Infinity show=Nothing clear summarize ");
countwithedges = Table.get("Count",0);
print(countwithedges)
//save segmentation image
run("Analyze Particles...", "size="+ minval + "-Infinity show=Outlines clear");
saveAs("tiff", outputdirectory + filename + "_counted with edges.tif");
close();

//count particle count with edges EXLUDED
run("Analyze Particles...", "size="+ minval + "-Infinity show=Nothing exclude clear summarize");
countwithoutedges = Table.get("Count",1);
run("Analyze Particles...", "size="+ minval + "-Infinity show=Outlines exclude clear");
//run("Analyze Particles...", "size=50-Infinity show=Outlines exclude clear summarize");
saveAs("tiff", outputdirectory + filename + "_excluded edges.tif");
close();
//saveAs("results", outputdirectory + filename + "_results");

//save counts
resultpath = outputdirectory + "result.txt";
print("countwithedges: " + countwithedges);
File.append("\n ", resultpath);
File.append("countwithedges: " + countwithedges, resultpath);
File.append("countwithoutedges: " + countwithoutedges, resultpath);
close("*");