BigDCD-parallel-Run is used for large dcd trajectories, and by taking advantage of parallel scripting, the Collective Variable from the trajectory can be achieved in less than one hour.

1) First, write our VMD code for the targeted collective variable in the main.tcl file. Make sure to put your code in the function "script" in the main.tcl file.
2) By the Linux terminal, perform:  "./parallel.sh" in the working directory  ---> It will generate 32 files similar to main.tcl, but each belongs to a different portion of the trajectory.
3) submit your job script by submit.pbs ---> make sure the cluster you are using supports PCP package. 
4) on your personal computer just use "./run.sh". Also, by adding ampersand (&) at the end of each line you can have a parallel run too. ***be careful not to overload your computer memory***)
5) When the run is over, change directory to the output folder, and by the Linux terminal, type:   cat *.dat > Data.dat

Data.dat is the collective variable of the entire dcd trajectory.
