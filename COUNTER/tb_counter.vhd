LIBRARY ieee;

USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;

ENTITY tb_counter IS 

GENERIC
(
number_of_bits : positive := 4
);

END tb_counter ; 

ARCHITECTURE simulace OF tb_counter IS -- klasika jako ve first_test

-- Components

COMPONENT counter IS -- neco trida v C# (nekde je napsan� t?�da a j� j� tady chci pou?�t, tak ud?l�m instanci), instanci delam v t?lu architektury (begin)  
                        -- jm�no "first_test" asi musi byt stejne jako je v .vhd, nebo sp�? ne
PORT
(
  input_CLK : IN STD_LOGIC;
  input_RESTART : IN STD_LOGIC;
  output_Q : OUT STD_LOGIC_VECTOR((number_of_bits-1) DOWNTO 0)
);

END COMPONENT;

-- Signals

SIGNAL clk : STD_LOGIC;
SIGNAL res : STD_LOGIC;
SIGNAL q : STD_LOGIC_VECTOR((number_of_bits-1) DOWNTO 0);

BEGIN

dut: counter -- tohle je ta "instance" [dut = design under test]
-- kl�?ov� slova port, map
-- port map (a,b,c); -- napojeni signalu, prvn� component a se napoj� na prvn� sign�l, je to rychl� ale ne?ikovn� p?i v�ce port?
                 
-- pro v�c port?:
PORT MAP (
  input_CLK => clk,
  input_RESTART => res,
  output_Q => q
);
-- kdyz ptrebuju aby se neco delalo sekvence, nekonecne se opakujici kod.. pokud mu nereknu jinak (wait) 

r_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

res <= '1'; 
res <= '0';        
WAIT FOR 10000 ns;       
res <= '1';                
WAIT;
END PROCESS r_process;


clk_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

clk <= '0';
WAIT FOR 100 ns; 

clk <= '1';
WAIT FOR 100 ns;

  IF res = '1' THEN -- 255 je te� normln� int ��slo, nikoliv std_logic, proto ned�v�m uvozovky 
  WAIT; 
  END IF;
 

END PROCESS clk_process;

END ARCHITECTURE simulace;
