LIBRARY ieee;

USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;

ENTITY tb_T_async IS 
END tb_T_async; 

ARCHITECTURE simulace OF tb_T_async  IS -- klasika jako ve first_test

-- Components

COMPONENT T_async IS -- neco trida v C# (nekde je napsaná t?ída a já jí tady chci pou?ít, tak ud?lám instanci), instanci delam v t?lu architektury (begin)  
                        -- jméno "first_test" asi musi byt stejne jako je v .vhd, nebo spí? ne
PORT
(
  input_T : IN STD_LOGIC; 
  input_RESET : IN STD_LOGIC;
  output_Q : OUT STD_LOGIC;
  output_Q_non : OUT STD_LOGIC
);

END COMPONENT;

-- Signals

SIGNAL t : STD_LOGIC;
SIGNAL res : STD_LOGIC;
SIGNAL q : STD_LOGIC;
SIGNAL q_non : STD_LOGIC;

BEGIN

dut: T_async -- tohle je ta "instance" [dut = design under test]

PORT MAP (
  input_T => t, 
  input_RESET => res,
  output_Q_non => q_non,
  output_Q => q
);


r_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

res <= '1';
WAIT FOR 3200 ns; 
res <= '0';
WAIT;
END PROCESS r_process;


t_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

t <= '0';
WAIT FOR 100 ns; 

t <= '1';
WAIT FOR 100 ns;

  IF res ='0' THEN 
   WAIT;
   
   END IF;
 

END PROCESS t_process;

END ARCHITECTURE simulace;
-- v simulaci simulate, view window object, oznacit add wawe, dvojata sipka(start all), v okne wawe dám f  jako full scale a jedu
