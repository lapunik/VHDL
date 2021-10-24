LIBRARY ieee;

USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;

ENTITY tb_picture_generator IS 
END tb_picture_generator; 

ARCHITECTURE simulace OF tb_picture_generator IS 

-- Components

COMPONENT picture_generator IS 
PORT
(
  input_CLK : IN STD_LOGIC;
  input_RESET : IN STD_LOGIC;
  input_X : IN STD_LOGIC_VECTOR(9 DOWNTO 0); -- (0 až 799)
  input_Y : IN STD_LOGIC_VECTOR(9 DOWNTO 0); -- (0 až 524)
  output_COLOR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)  
   
);

END COMPONENT;

-- Signals

SIGNAL clk : STD_LOGIC;
SIGNAL res : STD_LOGIC;
SIGNAL signal_x : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL signal_y : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL signal_color : STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL stop : BOOLEAN := false;

BEGIN

dut: picture_generator
PORT MAP (
  input_CLK => clk, 
  input_RESET => res, 
  input_X => signal_x, 
  input_Y => signal_y, 
  output_COLOR => signal_color 
);

in_process: PROCESS 
BEGIN

  FOR i IN 0 TO 524 LOOP
  
    FOR j IN 0 TO 799 LOOP
    
    signal_x <= STD_LOGIC_VECTOR(to_unsigned(j,10));
    signal_y <= STD_LOGIC_VECTOR(to_unsigned(i,10));
    
    WAIT FOR 500 ns; 
 
    END LOOP;
   
  END LOOP;
  WAIT;
    
END PROCESS in_process;
                         
                         
stop_process: PROCESS 
BEGIN

  IF (unsigned(signal_x) = 799)  AND (unsigned(signal_y) = 524) THEN 
  stop <= true;
  WAIT;
  
  ELSE
  
   WAIT FOR 10 ns; 
  
  END IF;  
END PROCESS stop_process;

r_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

res <= '0';
WAIT FOR 200 ns; 
res <= '1';

WAIT;
END PROCESS r_process;


clk_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

IF stop THEN
WAIT;
END IF;

clk <= '0';
WAIT FOR 100 ns; 
clk <= '1';
WAIT FOR 100 ns;

END PROCESS clk_process;

END ARCHITECTURE simulace;     