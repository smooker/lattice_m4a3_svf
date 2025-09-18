#!/bin/bash
openocd -f ../scripts/board/numato_telesto10m16.cfg -c init -c "svf -quiet ../counter.svf" -c shutdown
