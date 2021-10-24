LIBRARY ieee; -- obrovsk� knihovna

USE ieee.std_logic_1164.ALL; --  bal�k z knihovny (sing�ly, logick� oper�tory, vektroy..)
USE ieee.numeric_std.ALL; -- bal�k z knihovny (pokud potrebujeme po?�tat)


ENTITY nasobicka_async IS --
PORT
(
  input_A : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
  input_B : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
  output_RESULT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);

END nasobicka_async; 


ARCHITECTURE rtl OF nasobicka_async IS  

BEGIN -- telo architektury, vsechno co je mezi begin a end se deje v jeden okamziku

pro_1: PROCESS(input_A,input_B)
BEGIN
  
  output_RESULT <= std_logic_vector((unsigned(input_A)) * (unsigned(input_B)));
    
END PROCESS pro_1;

END ARCHITECTURE rtl; -- konec architecture a begin  