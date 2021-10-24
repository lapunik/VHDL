LIBRARY ieee;

USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;

ENTITY tb_sedmi_segment IS 
END tb_sedmi_segment; 

ARCHITECTURE simulace OF tb_sedmi_segment IS 

-- Components

COMPONENT sedmi_segment IS -- neco trida v C# (nekde je napsaná t?ída a já jí tady chci pou?ít, tak ud?lám instanci), instanci delam v t?lu architektury (begin)  
                        -- jméno "first_test" asi musi byt stejne jako je v .vhd, nebo spí? ne
PORT
(
  input_IN : IN STD_LOGIC_VECTOR(0 TO 3); 
  input_CLK : IN STD_LOGIC;
  input_RESTART : IN STD_LOGIC;
  output_Q : OUT STD_LOGIC_VECTOR(0 TO 6)
);

END COMPONENT;

-- Signals

SIGNAL input : STD_LOGIC_VECTOR(0 TO 3);
SIGNAL clk : STD_LOGIC;
SIGNAL res : STD_LOGIC;
SIGNAL q : STD_LOGIC_VECTOR(0 TO 6);

BEGIN

dut: sedmi_segment -- tohle je ta "instance" [dut = design under test]
-- klí?ová slova port, map
-- port map (a,b,c); -- napojeni signalu, první component a se napojí na první signál, je to rychlý ale ne?ikovný p?i více port?
                 
-- pro víc port?:
PORT MAP (
  input_IN => input, 
  input_CLK => clk,
  input_RESTART => res,
  output_Q => q
);
-- kdyz ptrebuju aby se neco delalo sekvence, nekonecne se opakujici kod.. pokud mu nereknu jinak (wait) 

in_process: PROCESS 
BEGIN

  FOR i IN 0 TO 15 LOOP
  input <= STD_LOGIC_VECTOR(to_unsigned(i,4));
  WAIT FOR 500 ns; 
  END LOOP;
  WAIT; 
  
END PROCESS in_process;

r_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

res <= '1'; 
res <= '0';        
WAIT FOR 4000 ns;       
--res <= '1';                
WAIT;
END PROCESS r_process;


clk_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

clk <= '0';
WAIT FOR 100 ns; 

clk <= '1';
WAIT FOR 100 ns;

  IF to_integer(unsigned(input)) = 15 THEN  
  WAIT; 
  END IF;
 
END PROCESS clk_process;

END ARCHITECTURE simulace;