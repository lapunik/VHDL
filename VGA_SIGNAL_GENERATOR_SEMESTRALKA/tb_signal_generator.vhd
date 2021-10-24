LIBRARY ieee;

USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;

ENTITY tb_signal_generator IS 

GENERIC
(
number_of_bits : positive := 10
);

END tb_signal_generator ; 

ARCHITECTURE simulace OF tb_signal_generator IS -- klasika jako ve first_test

-- Components

COMPONENT signal_generator IS -- neco trida v C# (nekde je napsan� t?�da a j� j� tady chci pou?�t, tak ud?l�m instanci), instanci delam v t?lu architektury (begin)  
                        -- jm�no "first_test" asi musi byt stejne jako je v .vhd, nebo sp�? ne
PORT
(
  input_CLK : IN STD_LOGIC;
  input_RESET : IN STD_LOGIC;
  output_X : OUT STD_LOGIC_VECTOR((number_of_bits-1) DOWNTO 0);
  output_Y : OUT STD_LOGIC_VECTOR((number_of_bits-1) DOWNTO 0);
  output_VERTICAL_SYNC : OUT STD_LOGIC;
  output_HORIZONTAL_SYNC : OUT STD_LOGIC
);

END COMPONENT;

-- Signals

SIGNAL clk : STD_LOGIC;
SIGNAL res : STD_LOGIC;
SIGNAL x : STD_LOGIC_VECTOR((number_of_bits-1) DOWNTO 0);
SIGNAL y : STD_LOGIC_VECTOR((number_of_bits-1) DOWNTO 0); 
SIGNAL vertical : STD_LOGIC;
SIGNAL horizontal : STD_LOGIC;

BEGIN

dut: signal_generator -- tohle je ta "instance" [dut = design under test]
-- kl�?ov� slova port, map
-- port map (a,b,c); -- napojeni signalu, prvn� component a se napoj� na prvn� sign�l, je to rychl� ale ne?ikovn� p?i v�ce port?
                 
-- pro v�c port?:
PORT MAP (
  input_CLK => clk,
  input_RESET => res,
  output_X => x,
  output_Y => y,
  output_VERTICAL_SYNC => vertical,
  output_HORIZONTAL_SYNC => horizontal
);

-- kdyz ptrebuju aby se neco delalo sekvence, nekonecne se opakujici kod.. pokud mu nereknu jinak (wait) 

r_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

res <= '0'; 
res <= '1';        
WAIT FOR 100000000 ns;       
res <= '0';                
WAIT;
END PROCESS r_process;


clk_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

clk <= '0';
WAIT FOR 100 ns; 

clk <= '1';
WAIT FOR 100 ns;

  IF res = '0' THEN -- 255 je te� normln� int ��slo, nikoliv std_logic, proto ned�v�m uvozovky 
  WAIT; 
  END IF;
 

END PROCESS clk_process;

END ARCHITECTURE simulace;
