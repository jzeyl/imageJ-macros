macro "glass_tempering_count [A]" {
//getdate and time
getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
TimeString ="Capture "//+DayNames[dayOfWeek]+" ";
if (dayOfMonth<10) {TimeString = TimeString+"0";}
TimeString = TimeString+dayOfMonth+"_"+month+"-"+year+"_";
if (hour<10) {TimeString = TimeString+"0";}
TimeString = TimeString+hour+"_";
if (minute<10) {TimeString = TimeString+"0";}
TimeString = TimeString+minute+"_";
if (second<10) {TimeString = TimeString+"0";}
TimeString = TimeString+second;
print(TimeString);

//set minimum pixel area to exclude, set file naming
minval = 50;
outputdirectory = "C:\\Users\\Lenovo M73\\Documents\\ImageJ\\macros\\";
filename = TimeString;

//makeRectangle(500, 724, 220, 238);///EDIT AND UNCOMMENT THIS LINE
run("Crop");
saveAs("Jpeg", outputdirectory + filename + "_original.jpg");
crop = getInfo("image.filename");
print(crop);
run("Gaussian Blur...", "sigma=1");
run("8-bit");
setAutoThreshold("Default");
run("Convert to Mask");
run("Watershed");

//create image with extra background fill on two sides, so that only two edges exclude particles from count
newImage("Untitled", "8-bit black", getWidth()+4, getHeight()+4, 1);//get dimensions
selectWindow(crop);
run("Select All");
selectWindow("Untitled");
run("Select None");
run("Restore Selection");
selectWindow(crop);
run("Copy");
selectWindow("Untitled");
run("Paste");
run("Select None");


//save segmentation image
minval = 50;
run("Analyze Particles...", "size="+ minval + "-Infinity show=Outlines exclude clear summarize");
selectWindow("Summary");
print("Num Images captured:" + Table.size);
count = Table.get("Count",Table.size-1);
print("count: "+count);
saveAs("Jpeg", outputdirectory + filename + "_outlines.jpg");
close();

//save counts
resultpath = outputdirectory + "result.txt";
File.append(filename+ ": " + count, resultpath);
close("*");
run("IJ webcam plugin", "camera=[Document camera 0] show custom width=1920 height=1080 unit=µm pixel_size=1.00000000 interval=1 frames=1 process");

}