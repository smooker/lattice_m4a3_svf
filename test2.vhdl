--  Hello world program
library ieee;
use ieee.std_logic_1164.all;

use std.textio.all; -- Imports the standard textio package.

--  Defines a design entity, without any ports.
entity hello_world is
	port (clk: out std_logic);
end hello_world;

architecture archname of hello_world is
  signal clk3, rst : std_logic := '0';
--  variable l2 : line;

begin
  test_process: process
    variable l : line;
  begin
    write (l, String'("Hello world!"));
    writeline (output, l);
    wait;
  end process;

clk_process: process
   variable l : line;
   variable clk2 : integer := 0;
  begin
    clk <= '0';
    wait for 100 ms;
    clk <= '1';
    wait for 20 ms;
    clk2 := clk2 + 1;
--    write (l, clk2);
--    writeline (output, l);
  end process;
--    write (l2, String'("Hello world22!"));
--    writeline (output, l2);
end;
