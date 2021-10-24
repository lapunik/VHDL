-- pak to bude first_test.vhd , otevrít z ModelSim (edit.new.file.vhd) 
-- asi by to chtelo se podivat jak PSPad s VHLD, jestli dostahnout nebo jak..

-- CTRL + F9 = KOMPILACE normálnì podle modelsimu 

LIBRARY ieee; -- obrovská knihovna

USE ieee.std_logic_1164.ALL; --  balík z knihovny (singály, logické operátory, vektroy..)
USE ieee.numeric_std.ALL; -- balík z knihovny (pokud potrebujeme po?ítat)


ENTITY sedmi_segment IS --
PORT
(
  input_IN : IN STD_LOGIC_VECTOR(0 TO 3); 
  input_CLK : IN STD_LOGIC;
  input_RESTART : IN STD_LOGIC;
  output_Q : OUT STD_LOGIC_VECTOR(0 TO 6)
);

END sedmi_segment; 


ARCHITECTURE rtl OF sedmi_segment IS  

BEGIN -- telo architektury, vsechno co je mezi begin a end se deje v jeden okamziku

pro_1: PROCESS(input_CLK,input_RESTART)
BEGIN
  IF input_RESTART ='1' THEN 
 
  FOR i IN 0 TO 6 LOOP
  output_Q(i) <= '0';
  END LOOP;
 
  ELSIF input_CLK'event AND input_CLK ='1' THEN
  
  segment: CASE input_IN IS
              WHEN "0000" =>
        output_Q <= "1111110";
              WHEN "0001" =>
        output_Q <= "0000110";
              WHEN "0010" =>
        output_Q <= "1011011";
              WHEN "0011" =>
        output_Q <= "1001111";
              WHEN "0100" =>
        output_Q <= "0100111";
              WHEN "0101" =>
        output_Q <= "1101101";
              WHEN "0110" =>
        output_Q <= "1111101";
              WHEN "0111" =>
        output_Q <= "1000110";
              WHEN "1000" =>
        output_Q <= "1111111";
              WHEN "1001" =>
        output_Q <= "1101111";           
              WHEN "1010" =>
        output_Q <= "1110111";
              WHEN "1011" =>
        output_Q <= "0111101";
              WHEN "1100" =>
        output_Q <= "1111000";
              WHEN "1101" =>
        output_Q <= "0011111";
              WHEN "1110" =>
        output_Q <= "1111001";
              WHEN "1111" =>
        output_Q <= "1110001";
               WHEN others =>
        output_Q <= "0000000";
              
    END CASE;
    
  END IF;
END PROCESS pro_1;

END ARCHITECTURE rtl; -- konec architecture a begin  

