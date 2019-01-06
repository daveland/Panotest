proc pnsynth {} {
  cd /home/ise/daveland/github/Panotest/cpu1
  if { [ catch { xload xmp cpu1.xmp } result ] } {
    exit 10
  }
  if { [catch {run netlist} result] } {
    return -1
  }
  return $result
}
if { [catch {pnsynth} result] } {
  exit -1
}
exit $result
