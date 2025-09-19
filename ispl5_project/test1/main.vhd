library ieee;
use ieee.std_logic_1164.all;


entity main is
  port (
    input_1    : in  std_logic;
    input_2    : in  std_logic;
    and_result : out std_logic
  );
	attribute LOC : string;
	attribute LOC of input_1: signal is "PA1231231";
	attribute LOC of input_2: signal is "PA2";
	attribute LOC of and_result: signal is "PA0";
end main;

architecture behavioral of main is
	signal and_gate : std_logic;
begin
  and_gate <= input_1 and input_2;
  and_result <= and_gate;
end behavioral;

