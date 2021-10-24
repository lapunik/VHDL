-- pak to bude first_test.vhd , otevr�t z ModelSim (edit.new.file.vhd) 
-- asi by to chtelo se podivat jak PSPad s VHLD, jestli dostahnout nebo jak..

-- CTRL + F9 = KOMPILACE norm�ln� podle modelsimu 

LIBRARY ieee; -- obrovsk� knihovna

USE ieee.std_logic_1164.ALL; --  bal�k z knihovny (sing�ly, logick� oper�tory, vektroy..)
USE ieee.numeric_std.ALL; -- bal�k z knihovny (pokud potrebujeme po?�tat)


ENTITY registr_8bit_async IS --
PORT
(
  input_IN : IN STD_LOGIC_VECTOR(0 to 7); 
  input_CLK : IN STD_LOGIC;
  input_RESTART : IN STD_LOGIC;
  output_Q : OUT STD_LOGIC_VECTOR(0 to 7)
);

END registr_8bit_async; 


ARCHITECTURE rtl OF registr_8bit_async IS  

CONSTANT nula: STD_LOGIC := '0';   -- je mo�n� t�mto zp�sobem si ud�lat konstanty v�eho druhu, jako v C
CONSTANT jedna: STD_LOGIC := '1';

BEGIN -- telo architektury, vsechno co je mezi begin a end se deje v jeden okamziku

pro_1: PROCESS(input_CLK,input_RESTART)
BEGIN
  IF input_RESTART ='1' THEN 
 
  FOR i IN 0 TO 7 LOOP
  output_Q(i) <= '0';
  END LOOP;
 
  ELSIF input_CLK'event and input_CLK ='1' then
  FOR i IN 0 TO 7 LOOP
  output_Q(i) <= input_IN(i);
  END LOOP;
  
  END IF;
END PROCESS pro_1;

-- output_y <= input_a and input_b; -- zapsani do portu nebo signalu <=, and, not, nor, xor atd.., ZAVORKOVAT!! divny veci s prioritama

END ARCHITECTURE rtl; -- konec architecture a begin  

