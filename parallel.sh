#!/bin/bash
core=31
for m in $(seq 1 $core)
 do
   cp main.tcl $(printf 'S%02d.tcl' $m) 
 done
wait

 let bin=131808/$core+1 ; # Find out the number of frame in the DCD file   50667 
 for n in $(seq 1 $core)
  do 
    let j=$n-1
    let new1=$bin*$j
    let new2=$bin*$n-1
    echo $new1  $new2 $n
    old1=$(awk  'NR==3{print $3}' main.tcl)
    old2=$(awk  'NR==4{print $3}' main.tcl)
    old=$(awk  'NR==2{print $3}' main.tcl)
    sed -i "s/set fst $old1/set fst $new1/g" $(printf 'S%02d.tcl' $n) >> $(printf 'S%02d.tcl' $n)
    sed -i "s/set lst $old2/set lst $new2/g" $(printf 'S%02d.tcl' $n) >> $(printf 'S%02d.tcl' $n)
    sed -i "s/set ii $old/set ii $n/g" $(printf 'S%02d.tcl' $n) >> $(printf 'S%02d.tcl' $n)
 done
 
