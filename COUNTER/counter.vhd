-- pak to bude first_test.vhd , otevrít z ModelSim (edit.new.file.vhd) 
-- asi by to chtelo se podivat jak PSPad s VHLD, jestli dostahnout nebo jak..

-- CTRL + F9 = KOMPILACE normálnì podle modelsimu 

LIBRARY ieee; -- obrovská knihovna

USE ieee.std_logic_1164.ALL; --  balík z knihovny (singály, logické operátory, vektroy..)
USE ieee.numeric_std.ALL; -- balík z knihovny (pokud potrebujeme po?ítat)


ENTITY counter IS --

GENERIC
(
number_of_bits : positive := 4
);

PORT
(
  input_CLK : IN STD_LOGIC;
  input_RESTART : IN STD_LOGIC;
  output_Q : OUT STD_LOGIC_VECTOR((number_of_bits-1) DOWNTO 0)
);

END counter; 


ARCHITECTURE rtl OF counter IS  
SIGNAL pomocna: STD_LOGIC_VECTOR ((number_of_bits-1) DOWNTO 0) := std_logic_vector(to_unsigned(0, number_of_bits)); --"0000" ;
BEGIN -- telo architektury, vsechno co je mezi begin a end se deje v jeden okamziku

pro_1: PROCESS(input_CLK,input_RESTART)
BEGIN
  IF input_RESTART ='1' THEN 
 
  FOR i IN (number_of_bits-1) DOWNTO 0 LOOP
  output_Q(i) <= '0';
  END LOOP;
 
  ELSIF input_CLK'event AND input_CLK ='1' THEN
  
  pomocna <= STD_LOGIC_VECTOR(unsigned(pomocna) + 1);
  
  output_Q <= pomocna;
  
  END IF;
END PROCESS pro_1;

-- output_y <= input_a and input_b; -- zapsani do portu nebo signalu <=, and, not, nor, xor atd.., ZAVORKOVAT!! divny veci s prioritama

END ARCHITECTURE rtl; -- konec architecture a begin  

