LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_fibbonachi_generator IS 
END tb_fibbonachi_generator;


ARCHITECTURE sim OF tb_fibbonachi_generator IS 

COMPONENT fibbonachi_generator IS
PORT(
clk : IN STD_LOGIC;
output : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
reset : STD_LOGIC
);
END COMPONENT;  


SIGNAL s_clk : STD_LOGIC;
SIGNAL s_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL s_res : STD_LOGIC := '1';
SIGNAL counter : INTEGER := 0;

BEGIN

fibb: fibbonachi_generator
PORT MAP(
clk => s_clk,
output => s_out,
reset => s_res
);

pro_clk: PROCESS
BEGIN

IF counter = 7 THEN 
IF unsigned(s_out) = 5 THEN                    
REPORT "Success";
ELSE
REPORT "Bad";
END IF;
END IF;   

IF counter = 9 THEN 
IF unsigned(s_out) = 13 THEN                    
REPORT "Success";
ELSE
REPORT "Bad";
END IF;
END IF;

s_clk <= '0';
WAIT FOR 100 ns;
s_clk <= '1';
counter <= counter +1;
WAIT FOR 100 ns;

IF s_res = '0' THEN
WAIT;
END IF;
END PROCESS;

pro_res: PROCESS
BEGIN
s_res <= '1';
WAIT FOR 6000 ns;
s_res <= '0';
WAIT;
END PROCESS;

END ARCHITECTURE;
