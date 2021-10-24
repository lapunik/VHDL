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

COMPONENT counter IS -- neco trida v C# (nekde je napsaná t?ída a já jí tady chci pou?ít, tak ud?lám instanci), instanci delam v t?lu architektury (begin)  
                        -- jméno "first_test" asi musi byt stejne jako je v .vhd, nebo spí? ne
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
-- klí?ová slova port, map
-- port map (a,b,c); -- napojeni signalu, první component a se napojí na první signál, je to rychlý ale ne?ikovný p?i více port?
                 
-- pro víc port?:
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

  IF res = '1' THEN -- 255 je teï normlní int èíslo, nikoliv std_logic, proto nedávám uvozovky 
  WAIT; 
  END IF;
 

END PROCESS clk_process;

END ARCHITECTURE simulace;
