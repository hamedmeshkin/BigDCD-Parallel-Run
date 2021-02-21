 
set ii 1
set fst 0
set lst 10
set step 100

set args {../../02-equilibrium/2JLN/equ_2JLN.dcd};    # Address of the dcd file
set fileE [open [format output/data_%02d.dat $ii] w]; # output file


set mol2 [mol load psf ../../common/4D1B_2JLN_share_fin.psf pdb ../../common/2JLN_sim_fun.pdb]
mol delrep 1 $mol2

#  RMSD Measurment
        proc script {frame} {
        global fileE  mol2
                set reference [atomselect top "protein and name CA" frame 0]
                set compare   [atomselect top "protein and name CA" frame 0]
                        $compare frame $frame
                        set trans_mat [measure fit $compare $reference]
                        $compare move $trans_mat
                        set rmsd [measure rmsd $compare $reference]
                        puts $fileE $rmsd
        }


  set interval [expr ($lst-$fst)/$step]
 
foreach dcd $args {
  for {set cnt 0} {$cnt <= $interval} {incr cnt} { 
      animate delete beg 1 end -1
      set init [expr $fst+($cnt*$step)]
      if {$cnt!=$interval} { set fnsh [expr $init+$step-1]
      } else { set fnsh $lst}
      mol addfile $dcd type dcd first $init last $fnsh  waitfor -1
      for {set frm 1} {$frm < [molinfo $mol2 get numframes]} {incr frm} {
        script $frm
      }
   }
}


close $fileE
exit











