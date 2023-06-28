
macro "MaxIntensityFromPlotProfile" {
      if (nSlices>1) run("Clear Results");
      n = getSliceNumber();
      for (i=1; i<=nSlices; i++) {
          setSlice(i);
          prof = getProfile();
		  //Array.show(prof);
		  Array.getStatistics(prof, min, max, mean, stdDev);
          row = nResults;
          setResult("Max ", row, max);
      }
      setSlice(n);
      updateResults();
  }















