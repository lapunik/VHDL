LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_multiplexer IS
END tb_multiplexer;

ARCHITECTURE sim OF tb_multiplexer IS

CONSTANT s : INTEGER := 2;

SIGNAL input_x : STD_LOGIC_VECTOR(((s*s)-1) DOWNTO 0);
SIGNAL input_a : STD_LOGIC_VECTOR((s-1) DOWNTO 0);
SIGNAL output_y : STD_LOGIC;
SIGNAL input_clk : STD_LOGIC;
SIGNAL e : STD_LOGIC;

COMPONENT multiplexor IS
GENERIC (size : INTEGER := s);
PORT 
(
x : IN STD_LOGIC_VECTOR (((size*size)-1) DOWNTO 0);
a : IN STD_LOGIC_VECTOR ((size-1) DOWNTO 0);
clk : IN STD_LOGIC;
y : OUT STD_LOGIC
);

END COMPONENT; 

BEGIN

mux: multiplexor
PORT MAP
(
x => input_x,
a => input_a,
clk => input_clk, 
y => output_y 
);

proces_clk: PROCESS
BEGIN 

input_clk <= '0';
WAIT FOR 20 ns;
input_clk <= '1';
WAIT FOR 20 ns;

IF e = '1' THEN 
WAIT;
END IF;
END PROCESS;


proces_input: PROCESS
BEGIN 
e <= '0';

input_x <= "0000";
WAIT FOR 400 ns;

FOR i IN 0 TO ((s*s)-1) LOOP

input_x <= STD_LOGIC_VECTOR((to_unsigned(1,s*s)) SLL i);

WAIT FOR 400 ns;


END LOOP;

e <= '1';
WAIT;
END PROCESS; 

proces_adress: PROCESS
BEGIN 

FOR i IN 0 TO ((s*s)-1) LOOP
input_a <= STD_LOGIC_VECTOR(to_unsigned(i,s));
WAIT FOR 100 ns;
END LOOP;

IF e = '1' THEN 
WAIT;
END IF;

END PROCESS;

END ARCHITECTURE sim; 
