LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


ENTITY multiplexor IS
GENERIC (size : INTEGER);
PORT
(
x : IN STD_LOGIC_VECTOR ((size*size)-1 DOWNTO 0);
a : IN STD_LOGIC_VECTOR (size-1 DOWNTO 0);
clk : IN STD_LOGIC;
y : OUT STD_LOGIC
);
END multiplexor; 

ARCHITECTURE rtl OF multiplexor IS
BEGIN 

proces_1: PROCESS(clk)
BEGIN

IF clk'event AND clk = '1' THEN
y <= x(to_integer(unsigned(a)));
END IF;

END PROCESS proces_1;

END ARCHITECTURE rtl;  
