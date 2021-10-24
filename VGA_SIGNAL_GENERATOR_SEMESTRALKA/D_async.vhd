LIBRARY ieee; -- obrovská knihovna
USE ieee.std_logic_1164.ALL; --  balík z knihovny (singály, logické operátory, vektroy..)
USE ieee.numeric_std.ALL; -- balík z knihovny (pokud potrebujeme po?ítat)

ENTITY D_async IS --
GENERIC (bits : integer);
PORT
(
  input_D : IN STD_LOGIC_VECTOR((bits-1) DOWNTO 0); 
  input_CLK : IN STD_LOGIC;
  input_RESET : IN STD_LOGIC;
  output_Q : OUT STD_LOGIC_VECTOR((bits-1) DOWNTO 0)
);
END D_async; 
           
ARCHITECTURE rtl OF D_async IS  

BEGIN -- telo architektury, vsechno co je mezi begin a end se deje v jeden okamzik

process_1: PROCESS(input_CLK,input_RESET)
BEGIN
  IF input_RESET ='0' THEN 
  output_Q <= STD_LOGIC_VECTOR(to_unsigned(0,bits));
 
  ELSIF input_CLK'event AND input_CLK ='1' THEN
   output_Q <= input_D;
  END IF;
END PROCESS process_1;

END ARCHITECTURE rtl; -- konec architecture a begin  
