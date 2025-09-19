
########## Tcl recorder starts at 09/16/25 07:38:11 ##########

set version "5.0"
set proj_dir "C:/users/smooker/cpld/test1"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]

switch $tcl_platform(platform) {
   windows {
      set fpga_bin [file join $fpga_dir "bin" "nt"]
	     if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
	        set env(PATH) "$fpga_bin;$env(PATH)" } }
   unix {
      set fpga_bin [file join $fpga_dir "bin" "sol"]
      if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
         set env(PATH) "$fpga_bin;$env(PATH)"}}}

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" test.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 07:38:11 ###########


########## Tcl recorder starts at 09/16/25 08:30:14 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/sch2blf\" -dev lattice -sup test.sch  -err automake.err"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bls\" -o \"test.bl0\" -ipo  -family -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" -i test.bl0 -o test.bl1 -collapse none -reduce none  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"test.bl1\" -o \"m4a3_64_smooker.bl2\" -omod \"m4a3_64_smooker\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj m4a3_64_smooker -lci m4a3_64_smooker.lct -log m4a3_64_smooker.imp -err automake.err -tti m4a3_64_smooker.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci m4a3_64_smooker.lct -blifopt  m4a3_64_smooker.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" m4a3_64_smooker.bl2 -sweep -mergefb -err automake.err -o m4a3_64_smooker.bl3  @m4a3_64_smooker.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci m4a3_64_smooker.lct -dev mach4a -diofft  m4a3_64_smooker.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" m4a3_64_smooker.bl3 -pla -family amdmach -idev van -o m4a3_64_smooker.tt2 -oxrf m4a3_64_smooker.xrf -err automake.err  @m4a3_64_smooker.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/tt2tott3\" -prj m4a3_64_smooker -dir $proj_dir -log m4a3_64_smooker.log -tti m4a3_64_smooker.tt2 -tto m4a3_64_smooker.tt3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci m4a3_64_smooker.lct -dev mach4a -prefit  m4a3_64_smooker.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -inp m4a3_64_smooker.tt3 -out m4a3_64_smooker.tt4 -err automake.err -log m4a3_64_smooker.log -percent m4a3_64_smooker.tte -mod test  @m4a3_64_smooker.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" m4a3_64_smooker.tte -o m4a3_64_smooker.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/lci2vci\" -lci m4a3_64_smooker.lct -out m4a3_64_smooker.vct -log m4a3_64_smooker.l2v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open m4a3_64_smooker.rsp w} rspFile] {
	puts stderr "Cannot create response file m4a3_64_smooker.rsp: $rspFile"
} else {
	puts $rspFile "-inp \"m4a3_64_smooker.tt4\" -vci \"m4a3_64_smooker.vct\" -log \"m4a3_64_smooker.log\" -eqn \"m4a3_64_smooker.eq3\" -dev mach464a -dat \"$install_dir/ispcpld/dat/mach4a/\" -msg \"$install_dir/ispcpld/dat/\" -err automake.err -tmv \"noinput.tmv\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/machfitr\" \"@m4a3_64_smooker.rsp\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete m4a3_64_smooker.rsp
if [runCmd "\"$cpld_bin/lci2vci\" -vci m4a3_64_smooker.vco -out m4a3_64_smooker.lco -log m4a3_64_smooker.v2l"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj m4a3_64_smooker -if m4a3_64_smooker.jed -j2s -log m4a3_64_smooker.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:30:14 ###########


########## Tcl recorder starts at 09/16/25 08:31:01 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
if [runCmd "\"$cpld_bin/prefit\" -inp m4a3_64_smooker.tt3 -out m4a3_64_smooker.tt4 -err automake.err -log m4a3_64_smooker.log -percent m4a3_64_smooker.tte -mod test  @m4a3_64_smooker.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" m4a3_64_smooker.tte -o m4a3_64_smooker.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/lci2vci\" -lci m4a3_64_smooker.lct -out m4a3_64_smooker.vct -log m4a3_64_smooker.l2v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open m4a3_64_smooker.rsp w} rspFile] {
	puts stderr "Cannot create response file m4a3_64_smooker.rsp: $rspFile"
} else {
	puts $rspFile "-inp \"m4a3_64_smooker.tt4\" -vci \"m4a3_64_smooker.vct\" -log \"m4a3_64_smooker.log\" -eqn \"m4a3_64_smooker.eq3\" -dev mach464a -dat \"$install_dir/ispcpld/dat/mach4a/\" -msg \"$install_dir/ispcpld/dat/\" -err automake.err -tmv \"noinput.tmv\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/machfitr\" \"@m4a3_64_smooker.rsp\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete m4a3_64_smooker.rsp
if [runCmd "\"$cpld_bin/lci2vci\" -vci m4a3_64_smooker.vco -out m4a3_64_smooker.lco -log m4a3_64_smooker.v2l"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj m4a3_64_smooker -if m4a3_64_smooker.jed -j2s -log m4a3_64_smooker.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src m4a3_64_smooker.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/mach4a/mach464ace.dev\" -postfit -lci m4a3_64_smooker.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:31:01 ###########


########## Tcl recorder starts at 09/16/25 08:36:32 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" main.vhd -o main.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/sch2jhd\" test.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:36:32 ###########


########## Tcl recorder starts at 09/16/25 08:36:44 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open main.cmd w} rspFile] {
	puts stderr "Cannot create response file main.cmd: $rspFile"
} else {
	puts $rspFile "PROJECT: main
working_path: \"$proj_dir\"
module: main
vhdl_file_list: main.vhd
output_file_name: main
suffix_name: edi
part: m4a3-64/32-7vc
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/synpwrap\" -e main -target mach"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete main.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf main.edi -out main.bl0 -err automake.err -log main.log -prj m4a3_64_smooker -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_vcc vcc -net_gnd gnd -nbx -dse -tlw -cvt yes -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:36:44 ###########


########## Tcl recorder starts at 09/16/25 08:37:20 ##########

# Commands to make the Process: 
# Update All Schematic Files
if [runCmd "\"$cpld_bin/updatesc\" test.sch -yield"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:37:20 ###########


########## Tcl recorder starts at 09/16/25 08:37:42 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/sch2jhd\" test.sch "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:37:42 ###########


########## Tcl recorder starts at 09/16/25 08:38:07 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" main.vhd -o main.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:38:07 ###########


########## Tcl recorder starts at 09/16/25 08:38:08 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open main.cmd w} rspFile] {
	puts stderr "Cannot create response file main.cmd: $rspFile"
} else {
	puts $rspFile "PROJECT: main
working_path: \"$proj_dir\"
module: main
vhdl_file_list: main.vhd
output_file_name: main
suffix_name: edi
part: m4a3-64/32-7vc
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/synpwrap\" -e main -target mach"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete main.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf main.edi -out main.bl0 -err automake.err -log main.log -prj m4a3_64_smooker -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_vcc vcc -net_gnd gnd -nbx -dse -tlw -cvt yes -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:38:08 ###########


########## Tcl recorder starts at 09/16/25 08:41:41 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" main.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"main.bl1\" -o \"m4a3_64_smooker.bl2\" -omod \"m4a3_64_smooker\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj m4a3_64_smooker -lci m4a3_64_smooker.lct -log m4a3_64_smooker.imp -err automake.err -tti m4a3_64_smooker.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci m4a3_64_smooker.lct -blifopt  m4a3_64_smooker.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" m4a3_64_smooker.bl2 -sweep -mergefb -err automake.err -o m4a3_64_smooker.bl3  @m4a3_64_smooker.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci m4a3_64_smooker.lct -dev mach4a -diofft  m4a3_64_smooker.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" m4a3_64_smooker.bl3 -pla -family amdmach -idev van -o m4a3_64_smooker.tt2 -oxrf m4a3_64_smooker.xrf -err automake.err  @m4a3_64_smooker.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/tt2tott3\" -prj m4a3_64_smooker -dir $proj_dir -log m4a3_64_smooker.log -tti m4a3_64_smooker.tt2 -tto m4a3_64_smooker.tt3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci m4a3_64_smooker.lct -dev mach4a -prefit  m4a3_64_smooker.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -inp m4a3_64_smooker.tt3 -out m4a3_64_smooker.tt4 -err automake.err -log m4a3_64_smooker.log -percent m4a3_64_smooker.tte -mod main  @m4a3_64_smooker.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" m4a3_64_smooker.tte -o m4a3_64_smooker.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/lci2vci\" -lci m4a3_64_smooker.lct -out m4a3_64_smooker.vct -log m4a3_64_smooker.l2v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open m4a3_64_smooker.rsp w} rspFile] {
	puts stderr "Cannot create response file m4a3_64_smooker.rsp: $rspFile"
} else {
	puts $rspFile "-inp \"m4a3_64_smooker.tt4\" -vci \"m4a3_64_smooker.vct\" -log \"m4a3_64_smooker.log\" -eqn \"m4a3_64_smooker.eq3\" -dev mach464a -dat \"$install_dir/ispcpld/dat/mach4a/\" -msg \"$install_dir/ispcpld/dat/\" -err automake.err -tmv \"noinput.tmv\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/machfitr\" \"@m4a3_64_smooker.rsp\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete m4a3_64_smooker.rsp
if [runCmd "\"$cpld_bin/lci2vci\" -vci m4a3_64_smooker.vco -out m4a3_64_smooker.lco -log m4a3_64_smooker.v2l"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj m4a3_64_smooker -if m4a3_64_smooker.jed -j2s -log m4a3_64_smooker.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:41:41 ###########


########## Tcl recorder starts at 09/16/25 08:43:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" main.vhd -o main.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:43:59 ###########


########## Tcl recorder starts at 09/16/25 08:44:04 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open main.cmd w} rspFile] {
	puts stderr "Cannot create response file main.cmd: $rspFile"
} else {
	puts $rspFile "PROJECT: main
working_path: \"$proj_dir\"
module: main
vhdl_file_list: main.vhd
output_file_name: main
suffix_name: edi
part: m4a3-64/32-7vc
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/synpwrap\" -e main -target mach"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete main.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf main.edi -out main.bl0 -err automake.err -log main.log -prj m4a3_64_smooker -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_vcc vcc -net_gnd gnd -nbx -dse -tlw -cvt yes -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:44:04 ###########


########## Tcl recorder starts at 09/16/25 08:45:16 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" main.vhd -o main.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:45:16 ###########


########## Tcl recorder starts at 09/16/25 08:45:23 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open main.cmd w} rspFile] {
	puts stderr "Cannot create response file main.cmd: $rspFile"
} else {
	puts $rspFile "PROJECT: main
working_path: \"$proj_dir\"
module: main
vhdl_file_list: main.vhd
output_file_name: main
suffix_name: edi
part: m4a3-64/32-7vc
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/synpwrap\" -e main -target mach"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete main.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf main.edi -out main.bl0 -err automake.err -log main.log -prj m4a3_64_smooker -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_vcc vcc -net_gnd gnd -nbx -dse -tlw -cvt yes -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:45:23 ###########


########## Tcl recorder starts at 09/16/25 08:45:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" main.vhd -o main.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:45:43 ###########


########## Tcl recorder starts at 09/16/25 08:47:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" main.vhd -o main.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:47:10 ###########


########## Tcl recorder starts at 09/16/25 08:51:39 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open main.cmd w} rspFile] {
	puts stderr "Cannot create response file main.cmd: $rspFile"
} else {
	puts $rspFile "PROJECT: main
working_path: \"$proj_dir\"
module: main
vhdl_file_list: main.vhd
output_file_name: main
suffix_name: edi
part: m4a3-64/32-7vc
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/synpwrap\" -e main -target mach"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete main.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf main.edi -out main.bl0 -err automake.err -log main.log -prj m4a3_64_smooker -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_vcc vcc -net_gnd gnd -nbx -dse -tlw -cvt yes -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:51:39 ###########


########## Tcl recorder starts at 09/16/25 08:52:10 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vhd2jhd\" main.vhd -o main.jhd -m \"$install_dir/ispcpld/generic/lib/vhd/location.map\" -p \"$install_dir/ispcpld/generic/lib\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:52:10 ###########


########## Tcl recorder starts at 09/16/25 08:52:14 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open main.cmd w} rspFile] {
	puts stderr "Cannot create response file main.cmd: $rspFile"
} else {
	puts $rspFile "PROJECT: main
working_path: \"$proj_dir\"
module: main
vhdl_file_list: main.vhd
output_file_name: main
suffix_name: edi
part: m4a3-64/32-7vc
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/synpwrap\" -e main -target mach"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete main.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf main.edi -out main.bl0 -err automake.err -log main.log -prj m4a3_64_smooker -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_vcc vcc -net_gnd gnd -nbx -dse -tlw -cvt yes -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/16/25 08:52:14 ###########


########## Tcl recorder starts at 09/19/25 06:09:58 ##########

# Commands to make the Process: 
# Hierarchy Browser
# - none -
# Application to view the Process: 
# Hierarchy Browser
if [runCmd "\"$cpld_bin/hierbro\" m4a3_64_smooker.jid  main"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:09:58 ###########


########## Tcl recorder starts at 09/19/25 06:13:09 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/mblifopt\" main.bl0 -collapse none -reduce none -keepwires  -err automake.err -family"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"main.bl1\" -o \"m4a3_64_smooker.bl2\" -omod \"m4a3_64_smooker\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj m4a3_64_smooker -lci m4a3_64_smooker.lct -log m4a3_64_smooker.imp -err automake.err -tti m4a3_64_smooker.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci m4a3_64_smooker.lct -blifopt  m4a3_64_smooker.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" m4a3_64_smooker.bl2 -sweep -mergefb -err automake.err -o m4a3_64_smooker.bl3  @m4a3_64_smooker.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci m4a3_64_smooker.lct -dev mach4a -diofft  m4a3_64_smooker.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" m4a3_64_smooker.bl3 -pla -family amdmach -idev van -o m4a3_64_smooker.tt2 -oxrf m4a3_64_smooker.xrf -err automake.err  @m4a3_64_smooker.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/tt2tott3\" -prj m4a3_64_smooker -dir $proj_dir -log m4a3_64_smooker.log -tti m4a3_64_smooker.tt2 -tto m4a3_64_smooker.tt3"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci m4a3_64_smooker.lct -dev mach4a -prefit  m4a3_64_smooker.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -inp m4a3_64_smooker.tt3 -out m4a3_64_smooker.tt4 -err automake.err -log m4a3_64_smooker.log -percent m4a3_64_smooker.tte -mod main  @m4a3_64_smooker.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" m4a3_64_smooker.tte -o m4a3_64_smooker.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/lci2vci\" -lci m4a3_64_smooker.lct -out m4a3_64_smooker.vct -log m4a3_64_smooker.l2v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open m4a3_64_smooker.rsp w} rspFile] {
	puts stderr "Cannot create response file m4a3_64_smooker.rsp: $rspFile"
} else {
	puts $rspFile "-inp \"m4a3_64_smooker.tt4\" -vci \"m4a3_64_smooker.vct\" -log \"m4a3_64_smooker.log\" -eqn \"m4a3_64_smooker.eq3\" -dev mach464a -dat \"$install_dir/ispcpld/dat/mach4a/\" -msg \"$install_dir/ispcpld/dat/\" -err automake.err -tmv \"noinput.tmv\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/machfitr\" \"@m4a3_64_smooker.rsp\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete m4a3_64_smooker.rsp
if [runCmd "\"$cpld_bin/lci2vci\" -vci m4a3_64_smooker.vco -out m4a3_64_smooker.lco -log m4a3_64_smooker.v2l"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj m4a3_64_smooker -if m4a3_64_smooker.jed -j2s -log m4a3_64_smooker.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:13:09 ###########


########## Tcl recorder starts at 09/19/25 06:13:40 ##########

# Commands to make the Process: 
# JEDEC File
if [runCmd "\"$cpld_bin/prefit\" -inp m4a3_64_smooker.tt3 -out m4a3_64_smooker.tt4 -err automake.err -log m4a3_64_smooker.log -percent m4a3_64_smooker.tte -mod main  @m4a3_64_smooker.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" m4a3_64_smooker.tte -o m4a3_64_smooker.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/lci2vci\" -lci m4a3_64_smooker.lct -out m4a3_64_smooker.vct -log m4a3_64_smooker.l2v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open m4a3_64_smooker.rsp w} rspFile] {
	puts stderr "Cannot create response file m4a3_64_smooker.rsp: $rspFile"
} else {
	puts $rspFile "-inp \"m4a3_64_smooker.tt4\" -vci \"m4a3_64_smooker.vct\" -log \"m4a3_64_smooker.log\" -eqn \"m4a3_64_smooker.eq3\" -dev mach464a -dat \"$install_dir/ispcpld/dat/mach4a/\" -msg \"$install_dir/ispcpld/dat/\" -err automake.err -tmv \"noinput.tmv\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/machfitr\" \"@m4a3_64_smooker.rsp\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete m4a3_64_smooker.rsp
if [runCmd "\"$cpld_bin/lci2vci\" -vci m4a3_64_smooker.vco -out m4a3_64_smooker.lco -log m4a3_64_smooker.v2l"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj m4a3_64_smooker -if m4a3_64_smooker.jed -j2s -log m4a3_64_smooker.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:13:40 ###########


########## Tcl recorder starts at 09/19/25 06:13:55 ##########

# Commands to make the Process: 
# Post-Fit Pinouts
if [runCmd "\"$cpld_bin/prefit\" -inp m4a3_64_smooker.tt3 -out m4a3_64_smooker.tt4 -err automake.err -log m4a3_64_smooker.log -percent m4a3_64_smooker.tte -mod main  @m4a3_64_smooker.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" m4a3_64_smooker.tte -o m4a3_64_smooker.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/lci2vci\" -lci m4a3_64_smooker.lct -out m4a3_64_smooker.vct -log m4a3_64_smooker.l2v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open m4a3_64_smooker.rsp w} rspFile] {
	puts stderr "Cannot create response file m4a3_64_smooker.rsp: $rspFile"
} else {
	puts $rspFile "-inp \"m4a3_64_smooker.tt4\" -vci \"m4a3_64_smooker.vct\" -log \"m4a3_64_smooker.log\" -eqn \"m4a3_64_smooker.eq3\" -dev mach464a -dat \"$install_dir/ispcpld/dat/mach4a/\" -msg \"$install_dir/ispcpld/dat/\" -err automake.err -tmv \"noinput.tmv\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/machfitr\" \"@m4a3_64_smooker.rsp\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete m4a3_64_smooker.rsp
if [runCmd "\"$cpld_bin/lci2vci\" -vci m4a3_64_smooker.vco -out m4a3_64_smooker.lco -log m4a3_64_smooker.v2l"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj m4a3_64_smooker -if m4a3_64_smooker.jed -j2s -log m4a3_64_smooker.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Post-Fit Pinouts
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-src m4a3_64_smooker.tt4 -type PLA -devfile \"$install_dir/ispcpld/dat/mach4a/mach464ace.dev\" -postfit -lci m4a3_64_smooker.lco
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:13:55 ###########


########## Tcl recorder starts at 09/19/25 06:14:18 ##########

# Commands to make the Process: 
# ISC-1532 File
if [runCmd "\"$cpld_bin/prefit\" -inp m4a3_64_smooker.tt3 -out m4a3_64_smooker.tt4 -err automake.err -log m4a3_64_smooker.log -percent m4a3_64_smooker.tte -mod main  @m4a3_64_smooker.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" m4a3_64_smooker.tte -o m4a3_64_smooker.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/lci2vci\" -lci m4a3_64_smooker.lct -out m4a3_64_smooker.vct -log m4a3_64_smooker.l2v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open m4a3_64_smooker.rsp w} rspFile] {
	puts stderr "Cannot create response file m4a3_64_smooker.rsp: $rspFile"
} else {
	puts $rspFile "-inp \"m4a3_64_smooker.tt4\" -vci \"m4a3_64_smooker.vct\" -log \"m4a3_64_smooker.log\" -eqn \"m4a3_64_smooker.eq3\" -dev mach464a -dat \"$install_dir/ispcpld/dat/mach4a/\" -msg \"$install_dir/ispcpld/dat/\" -err automake.err -tmv \"noinput.tmv\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/machfitr\" \"@m4a3_64_smooker.rsp\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete m4a3_64_smooker.rsp
if [runCmd "\"$cpld_bin/lci2vci\" -vci m4a3_64_smooker.vco -out m4a3_64_smooker.lco -log m4a3_64_smooker.v2l"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj m4a3_64_smooker -if m4a3_64_smooker.jed -j2i "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:14:18 ###########


########## Tcl recorder starts at 09/19/25 06:14:25 ##########

# Commands to make the Process: 
# Pre-Fit Equations
if [runCmd "\"$cpld_bin/prefit\" -inp m4a3_64_smooker.tt3 -out m4a3_64_smooker.tt4 -err automake.err -log m4a3_64_smooker.log -percent m4a3_64_smooker.tte -mod main  @m4a3_64_smooker.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" m4a3_64_smooker.tte -o m4a3_64_smooker.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:14:25 ###########


########## Tcl recorder starts at 09/19/25 06:14:32 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/prefit\" -inp m4a3_64_smooker.tt3 -out m4a3_64_smooker.tt4 -err automake.err -log m4a3_64_smooker.log -percent m4a3_64_smooker.tte -mod main  @m4a3_64_smooker.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blif2eqn\" m4a3_64_smooker.tte -o m4a3_64_smooker.eq3 -use_short -err automake.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/lci2vci\" -lci m4a3_64_smooker.lct -out m4a3_64_smooker.vct -log m4a3_64_smooker.l2v"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open m4a3_64_smooker.rsp w} rspFile] {
	puts stderr "Cannot create response file m4a3_64_smooker.rsp: $rspFile"
} else {
	puts $rspFile "-inp \"m4a3_64_smooker.tt4\" -vci \"m4a3_64_smooker.vct\" -log \"m4a3_64_smooker.log\" -eqn \"m4a3_64_smooker.eq3\" -dev mach464a -dat \"$install_dir/ispcpld/dat/mach4a/\" -msg \"$install_dir/ispcpld/dat/\" -err automake.err -tmv \"noinput.tmv\" 
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/machfitr\" \"@m4a3_64_smooker.rsp\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete m4a3_64_smooker.rsp
if [runCmd "\"$cpld_bin/lci2vci\" -vci m4a3_64_smooker.vco -out m4a3_64_smooker.lco -log m4a3_64_smooker.v2l"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj m4a3_64_smooker -if m4a3_64_smooker.jed -j2s -log m4a3_64_smooker.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 09/19/25 06:14:32 ###########

