LIBRARY ieee;

USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;

ENTITY tb_top_registr_sedmi_segment IS 
END tb_top_registr_sedmi_segment; 

ARCHITECTURE simulace OF tb_top_registr_sedmi_segment IS 

-- Components

COMPONENT top_registr_sedmi_segment IS -- neco trida v C# (nekde je napsaná t?ída a já jí tady chci pou?ít, tak ud?lám instanci), instanci delam v t?lu architektury (begin)  
                        -- jméno "first_test" asi musi byt stejne jako je v .vhd, nebo spí? ne
PORT
(
  input_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
  input_CLK : IN STD_LOGIC;
  input_RESTART : IN STD_LOGIC;
  output_SEGMENT_0_3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
  output_SEGMENT_4_7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
);

END COMPONENT;

-- Signals

SIGNAL input : STD_LOGIC_VECTOR(7 DOWNTO 0); 
SIGNAL clk : STD_LOGIC;
SIGNAL res : STD_LOGIC;
SIGNAL seg_0_3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL seg_4_7 : STD_LOGIC_VECTOR(6 DOWNTO 0) ;
SIGNAL stop : BOOLEAN;

BEGIN

dut: top_registr_sedmi_segment -- tohle je ta "instance" [dut = design under test]
-- klí?ová slova port, map
-- port map (a,b,c); -- napojeni signalu, první component a se napojí na první signál, je to rychlý ale ne?ikovný p?i více port?
PORT MAP (
  input_IN => input,
  input_CLK => clk,
  input_RESTART => res, 
  output_SEGMENT_0_3 => seg_0_3, 
  output_SEGMENT_4_7 => seg_4_7 
);
-- kdyz ptrebuju aby se neco delalo sekvence, nekonecne se opakujici kod.. pokud mu nereknu jinak (wait) 

in_process: PROCESS 
BEGIN

  FOR i IN 0 TO 255 LOOP
  input <= STD_LOGIC_VECTOR(to_unsigned(i,8));
  WAIT FOR 1000 ns; 
  END LOOP;
  stop <= true;
  WAIT;
    
END PROCESS in_process;

r_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

res <= '1';
WAIT FOR 200 ns; 
res <= '0';                    
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
