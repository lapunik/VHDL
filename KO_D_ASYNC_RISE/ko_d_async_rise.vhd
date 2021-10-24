-- pak to bude first_test.vhd , otevr�t z ModelSim (edit.new.file.vhd) 
-- asi by to chtelo se podivat jak PSPad s VHLD, jestli dostahnout nebo jak..

-- CTRL + F9 = KOMPILACE norm�ln� podle modelsimu 

LIBRARY ieee; -- obrovsk� knihovna

USE ieee.std_logic_1164.ALL; --  bal�k z knihovny (sing�ly, logick� oper�tory, vektroy..)
USE ieee.numeric_std.ALL; -- bal�k z knihovny (pokud potrebujeme po?�tat)

ENTITY ko_d_async_rise IS --

PORT
(
  input_D : IN STD_LOGIC; 
  input_CLK : IN STD_LOGIC;
  input_RESTART : IN STD_LOGIC;
  output_Q : OUT STD_LOGIC
);

END ko_d_async_rise; 


ARCHITECTURE rtl OF ko_d_async_rise IS  

CONSTANT nula: STD_LOGIC := '0';   -- je mo�n� t�mto zp�sobem si ud�lat konstanty v�eho druhu, jako v C
CONSTANT jedna: STD_LOGIC := '1';

BEGIN -- telo architektury, vsechno co je mezi begin a end se deje v jeden okamzik

pro_1: PROCESS(input_CLK,input_RESTART)
BEGIN
  IF input_RESTART ='1' THEN 
  output_Q <= '0';
 
  ELSIF input_CLK'event and input_CLK ='1' then output_Q <= input_D;
  END IF;
END PROCESS pro_1;

-- output_y <= input_a and input_b; -- zapsani do portu nebo signalu <=, and, not, nor, xor atd.., ZAVORKOVAT!! divny veci s prioritama

END ARCHITECTURE rtl; -- konec architecture a begin  
