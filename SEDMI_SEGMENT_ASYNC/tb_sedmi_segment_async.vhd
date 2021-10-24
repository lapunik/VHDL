LIBRARY ieee;

USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;

ENTITY tb_sedmi_segment_async IS 
END tb_sedmi_segment_async; 

ARCHITECTURE simulace OF tb_sedmi_segment_async IS 

-- Components

COMPONENT sedmi_segment_async IS -- neco trida v C# (nekde je napsan� t?�da a j� j� tady chci pou?�t, tak ud?l�m instanci), instanci delam v t?lu architektury (begin)  
                        -- jm�no "first_test" asi musi byt stejne jako je v .vhd, nebo sp�? ne
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
-- kl�?ov� slova port, map
-- port map (a,b,c); -- napojeni signalu, prvn� component a se napoj� na prvn� sign�l, je to rychl� ale ne?ikovn� p?i v�ce port?
                 
-- pro v�c port?:
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