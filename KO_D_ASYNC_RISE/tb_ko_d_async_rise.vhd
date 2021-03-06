LIBRARY ieee;

USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;

ENTITY tb_ko_d_async_rise IS 
END tb_ko_d_async_rise ; 

ARCHITECTURE simulace OF tb_ko_d_async_rise  IS -- klasika jako ve first_test

-- Components

COMPONENT ko_d_async_rise IS -- neco trida v C# (nekde je napsan? t??da a j? j? tady chci pou??t, tak ud?l?m instanci), instanci delam v t?lu architektury (begin)  
                        -- jm?no "first_test" asi musi byt stejne jako je v .vhd, nebo sp?? ne
PORT
(
  input_D : IN STD_LOGIC; 
  input_CLK : IN STD_LOGIC;
  input_RESTART : IN STD_LOGIC;
  output_Q : OUT STD_LOGIC
);

END COMPONENT;

-- Signals

SIGNAL d : STD_LOGIC;
SIGNAL clk : STD_LOGIC;
SIGNAL res : STD_LOGIC;
SIGNAL q : STD_LOGIC;

BEGIN

dut: ko_d_async_rise -- tohle je ta "instance" [dut = design under test]
-- kl??ov? slova port, map
-- port map (a,b,c); -- napojeni signalu, prvn? component a se napoj? na prvn? sign?l, je to rychl? ale ne?ikovn? p?i v?ce port?
                 
-- pro v?c port?:
PORT MAP (
  input_D => d, 
  input_CLK => clk,
  input_RESTART => res,
  output_Q => q
);
-- kdyz ptrebuju aby se neco delalo sekvence, nekonecne se opakujici kod.. pokud mu nereknu jinak (wait) 

d_process: PROCESS 
BEGIN

d <= '0';
WAIT FOR 1000 ns; 

d <= '1';
WAIT FOR 200 ns; 

d <= '0';
WAIT FOR 200 ns;
d <= '1';
WAIT FOR 500 ns; 

d <= '0';
WAIT FOR 500 ns;
d <= '1';
WAIT FOR 1000 ns; 

d <= '0';
WAIT FOR 1000 ns;

WAIT;
END PROCESS d_process;

r_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

res <= '0';
WAIT FOR 3200 ns; 
res <= '1';
WAIT;
END PROCESS r_process;


clk_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

clk <= '0';
WAIT FOR 100 ns; 

clk <= '1';
WAIT FOR 100 ns;

  IF res ='1' THEN 
   WAIT;
   
   END IF;
 

END PROCESS clk_process;

END ARCHITECTURE simulace;
-- v simulaci simulate, view window object, oznacit add wawe, dvojata sipka(start all), v okne wawe d?m f  jako full scale a jedu
