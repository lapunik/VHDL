LIBRARY ieee;

USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;

ENTITY tb_registr_8bit_async IS 
END tb_registr_8bit_async ; 

ARCHITECTURE simulace OF tb_registr_8bit_async IS -- klasika jako ve first_test

-- Components

COMPONENT registr_8bit_async IS -- neco trida v C# (nekde je napsaná t?ída a já jí tady chci pou?ít, tak ud?lám instanci), instanci delam v t?lu architektury (begin)  
                        -- jméno "first_test" asi musi byt stejne jako je v .vhd, nebo spí? ne
PORT
(
  input_IN : IN STD_LOGIC_VECTOR(0 TO 7); 
  input_CLK : IN STD_LOGIC;
  input_RESTART : IN STD_LOGIC;
  output_Q : OUT STD_LOGIC_VECTOR(0 TO 7)
);

END COMPONENT;

-- Signals

SIGNAL input : STD_LOGIC_VECTOR(0 TO 7);
SIGNAL clk : STD_LOGIC;
SIGNAL res : STD_LOGIC;
SIGNAL q : STD_LOGIC_VECTOR(0 TO 7);

BEGIN

dut: registr_8bit_async -- tohle je ta "instance" [dut = design under test]
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

  FOR i IN 0 TO 255 LOOP
  input <= STD_LOGIC_VECTOR(to_unsigned(i,8));
  WAIT UNTIL clk ='1';
  WAIT FOR 1 ns; -- jinak bude nasledujici podminka porad hazet tu "chybu"
  IF res = '0' AND to_integer(unsigned(q)) /= i THEN -- 255 je teï normlní int èíslo, nikoliv std_logic, proto nedávám uvozovky 
  REPORT("chyba");
  END IF;
  WAIT FOR 300 ns; 
  END LOOP;
  
  WAIT; 
  
END PROCESS in_process;

--chyba_process: PROCESS 
--BEGIN
--WAIT FOR 3000 ns;
--q <= (others => '0');                
--WAIT UNTIL clk = '1';
--WAIT UNTIL clk = '1';
--q <= (others => 'Z'); -- jiny zpusob jak zapsat same Z-tka  ("ZZZZZZZZ")
--WAIT;
--END PROCESS chyba_process;

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

  IF to_integer(unsigned(input)) = 255 THEN -- 255 je teï normlní int èíslo, nikoliv std_logic, proto nedávám uvozovky 
  WAIT; 
  END IF;
 

END PROCESS clk_process;

END ARCHITECTURE simulace;