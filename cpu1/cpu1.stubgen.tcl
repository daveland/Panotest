cd /home/ise/daveland/github/Panotest/cpu1/
if { [ catch { xload xmp cpu1.xmp } result ] } {
  exit 10
}
xset hdl vhdl
run stubgen
exit 0
