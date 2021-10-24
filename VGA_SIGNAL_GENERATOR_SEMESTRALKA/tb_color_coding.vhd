LIBRARY ieee;

USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;

ENTITY tb_color_coding IS 
END tb_color_coding ; 

ARCHITECTURE simulace OF tb_color_coding IS -- klasika jako ve first_test

-- Components

COMPONENT color_coding IS -- neco trida v C# (nekde je napsaná t?ída a já jí tady chci pou?ít, tak ud?lám instanci), instanci delam v t?lu architektury (begin)  
                        -- jméno "first_test" asi musi byt stejne jako je v .vhd, nebo spí? ne
PORT
(
  input_IN : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  input_CLK : IN STD_LOGIC;
  input_RESET : IN STD_LOGIC; 
  output_SYNC : OUT STD_LOGIC;
  output_BLANK : OUT STD_LOGIC;
  output_RED : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  output_GREEN : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  output_BLUE : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
);

END COMPONENT;

-- Signals

SIGNAL i : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL clk : STD_LOGIC;
SIGNAL res : STD_LOGIC;
SIGNAL sync : STD_LOGIC;
SIGNAL blank : STD_LOGIC;
SIGNAL r : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL g : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL b : STD_LOGIC_VECTOR(9 DOWNTO 0);

BEGIN

dut: color_coding 

PORT MAP (
  input_IN => i,
  input_CLK => clk,
  input_RESET => res,
  output_SYNC => sync,
  output_BLANK => blank,
  output_RED => r,
  output_GREEN => g,
  output_BLUE => b
);

-- kdyz ptrebuju aby se neco delalo sekvence, nekonecne se opakujici kod.. pokud mu nereknu jinak (wait) 

r_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

res <= '0'; 
res <= '1';        
WAIT FOR 10000 ns;       
res <= '0';                
WAIT;
END PROCESS r_process;

in_process: PROCESS 
BEGIN

  FOR j IN 0 TO 15 LOOP
  i <= STD_LOGIC_VECTOR(to_unsigned(j,4));
  WAIT FOR 500 ns; 
  END LOOP;
  WAIT; 
  
END PROCESS in_process;

clk_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

clk <= '0';
WAIT FOR 100 ns; 

clk <= '1';
WAIT FOR 100 ns;

  IF res = '0' THEN -- 255 je teï normlní int èíslo, nikoliv std_logic, proto nedávám uvozovky 
  WAIT; 
  END IF;
 

END PROCESS clk_process;

END ARCHITECTURE simulace;
