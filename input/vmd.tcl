set fs [open "phi_psi_2jln.dat" w]

set mol2 [mol load psf ../../common/4D1B_2JLN_share_fin.psf pdb ../../common/4D1B_sim_fun.pdb]
mol delrep 1 $mol2

proc phi_2jln {frame} {
global fs  mol2

#  344-348
    set ca1 [atomselect $mol2 "protein and alpha and residue 344 to 347" frame $frame]
    set phi_t [$ca1 get phi]
    set psi_t [$ca1 get psi]
    puts $fs "$phi_t  $psi_t \t" 
}

source bigdcd.tcl
bigdcd phi_2jln dcd ../../01-equilibrium/2JLN/output_000/equ_2JLN.dcd  ../../01-equilibrium/2JLN/output_001/equ_2JLN.dcd
bigdcd_wait 
 
close $fs
exit
