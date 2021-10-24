LIBRARY ieee;

USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;

ENTITY tb_D_async IS 
GENERIC (number_of_bits : integer := 4); -- tady mìním poèet bitù Déèka
END tb_D_async ; 

ARCHITECTURE simulace OF tb_D_async  IS 

COMPONENT D_async IS 
GENERIC (bits : integer := number_of_bits); -- POZOR!!! tohle je obecnì pro všechny Déèka ale pokud v GENERIC MAP napíšu nìco jnýho, tak platí to jiný (protože je nepoviný);
PORT(
  input_D : IN STD_LOGIC_VECTOR((bits-1) DOWNTO 0); 
  input_CLK : IN STD_LOGIC;
  input_RESET : IN STD_LOGIC;
  output_Q : OUT STD_LOGIC_VECTOR((bits-1) DOWNTO 0)
);

END COMPONENT;

SIGNAL d : STD_LOGIC_VECTOR(number_of_bits-1 DOWNTO 0); 
SIGNAL clk : STD_LOGIC;
SIGNAL res : STD_LOGIC;
SIGNAL q : STD_LOGIC_VECTOR (number_of_bits-1 DOWNTO 0); 

BEGIN

dut: D_async 
GENERIC MAP (bits => number_of_bits)
PORT MAP (
  input_D => d, 
  input_CLK => clk,
  input_RESET => res,
  output_Q => q
);
-- kdyz ptrebuju aby se neco delalo sekvence, nekonecne se opakujici kod.. pokud mu nereknu jinak (wait) 

d_process: PROCESS 
BEGIN
  FOR i IN 0 TO (2**number_of_bits) LOOP
  d <= STD_LOGIC_VECTOR(to_unsigned(i,number_of_bits));
  WAIT FOR 500 ns; 
  END LOOP;
  WAIT;
END PROCESS d_process;

r_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

res <= '1';
WAIT FOR 3200 ns; 
res <= '0';
WAIT;
END PROCESS r_process;


clk_process: PROCESS -- kdyz nema jmeno, tak je urceny JEN pro simulaci
BEGIN

clk <= '0';
WAIT FOR 100 ns; 

clk <= '1';
WAIT FOR 100 ns;

  IF res ='0' THEN 
   WAIT;
   
   END IF;
 

END PROCESS clk_process;

END ARCHITECTURE simulace;
-- v simulaci simulate, view window object, oznacit add wawe, dvojata sipka(start all), v okne wawe dám f  jako full scale a jedu
