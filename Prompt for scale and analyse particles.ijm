
ID = getImageID();

//convert to 8-bit so can be thresholded
run("8-bit");

//Set Threshold
run("Threshold...");  // open Threshold tool
title = "Set Threshold";
msg = "Use the \"Threshold\" tool to\nadjust the threshold, then click \"Apply\" and\"OK\".";
waitForUser(title, msg);

//convert threshold to binary for analysis
setTool("line");//select line tool
setOption("BlackBackground", true);
run("Convert to Mask");

//SET SCALE
title = "Set Scale";
msg = "Draw Scale line, then click \"OK\".";
waitForUser(title, msg);//display message
//USER INPUTS
run("Set Scale...");//open dialog
//
//Set selection tool
setTool("freehand");
title = "Select ROI";
msg = "Draw ROI for particle analysis";
waitForUser(title, msg);//display message

//run particle analysis
run("Analyze Particles...", "  show=Outlines display exclude clear summarize");

