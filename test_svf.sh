#!/bin/bash
#openocd --debug=2 -f ./um232h_smooker_6010.cfg -c "adapter speed 1000; transport select jtag; jtag newtap auto0 tap -irlen 6;init;" -c "svf -quiet ./test2.svf" -c shutdown


#BSDLISCispMACH4A3-643244PinTQFP.BSM
openocd --debug=2 -f ./um232h_smooker_6010.cfg -c "adapter speed 200; transport select jtag; jtag newtap auto0 tap -irlen 6;init;" -c "svf ./test2.svf" -c shutdown
