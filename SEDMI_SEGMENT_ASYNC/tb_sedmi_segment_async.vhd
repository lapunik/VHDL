LIBRARY ieee;

USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;

ENTITY tb_sedmi_segment_async IS 
END tb_sedmi_segment_async; 

ARCHITECTURE simulace OF tb_sedmi_segment_async IS 

-- Components

COMPONENT sedmi_segment_async IS -- neco trida v C# (nekde je napsaná t?ída a já jí tady chci pou?ít, tak ud?lám instanci), instanci delam v t?lu architektury (begin)  
                        -- jméno "first_test" asi musi byt stejne jako je v .vhd, nebo spí? ne
PORT
(
  input_IN : IN STD_LOGIC_VECTOR(0 TO 3); 
  output_SEGMENT : OUT STD_LOGIC_VECTOR(0 TO 6)
);

END COMPONENT;

-- Signals

SIGNAL input : STD_LOGIC_VECTOR(0 TO 3);
SIGNAL seg : STD_LOGIC_VECTOR(0 TO 6);

BEGIN

dut: sedmi_segment_async -- tohle je ta "instance" [dut = design under test]
-- klí?ová slova port, map
-- port map (a,b,c); -- napojeni signalu, první component a se napojí na první signál, je to rychlý ale ne?ikovný p?i více port?
                 
-- pro víc port?:
PORT MAP (
  input_IN => input, 
  output_SEGMENT => seg
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

END ARCHITECTURE simulace;