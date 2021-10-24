LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fibbonachi_generator IS 
PORT(
clk : IN STD_LOGIC;
output : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
reset : STD_LOGIC
);
END fibbonachi_generator;

ARCHITECTURE rtl OF fibbonachi_generator IS 

SIGNAL n : INTEGER := 0;
SIGNAL n_1 : INTEGER := 0;
SIGNAL n_2 : INTEGER := 0;
SIGNAL counter : INTEGER := 0;

BEGIN
pro_1: PROCESS (clk)
BEGIN

output <= std_logic_vector(to_unsigned(n,8));

IF reset = '0' THEN
output <= std_logic_vector(to_unsigned(0,8));
n_1 <= 0;
n_2 <= 0;
counter <= 0;

ELSIF clk'event AND clk = '1' THEN

IF counter = 0 THEN 
n_1 <= 0;
n_2 <= 0;
counter <= counter +1;
ELSIF counter = 1 THEN
n_1 <= 0;
n_2 <= 0;
counter <= counter +1;
ELSIF counter = 2 THEN
n_1 <= 1;
n_2 <= 0;
counter <= counter +1;
ELSIF counter = 13 THEN
n_1 <= 0;
n_2 <= 0;
counter <= 0;
ELSE
n_1 <= 1;
n_2 <= 0;
counter <= counter +1;
n_2 <= n_1; 
n_1 <= n;
counter <= counter +1;           
END IF;
END IF;
END PROCESS;

n <= n_1 + n_2;

END ARCHITECTURE;