cd /home/ise/daveland/github/Panotest/cpu1
if { [ catch { xload xmp cpu1.xmp } result ] } {
  exit 10
}

if { [catch {run init_bram} result] } {
  exit -1
}

exit 0
