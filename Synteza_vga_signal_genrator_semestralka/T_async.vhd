LIBRARY ieee; -- obrovská knihovna

USE ieee.std_logic_1164.ALL; --  balík z knihovny (singály, logické operátory, vektroy..)
USE ieee.numeric_std.ALL; -- balík z knihovny (pokud potrebujeme po?ítat)

ENTITY T_async IS --

PORT
( 
  input_T : IN STD_LOGIC;
  input_RESET : IN STD_LOGIC; 
  output_Q : OUT STD_LOGIC;
  output_Q_non : OUT STD_LOGIC
);

END T_async; 


ARCHITECTURE rtl OF T_async IS  

SIGNAL signal_Q : STD_LOGIC := '0';
SIGNAL signal_Q_non : STD_LOGIC := '1';

BEGIN -- telo architektury, vsechno co je mezi begin a end se deje v jeden okamzik


process_1: PROCESS(input_T,input_RESET)
BEGIN
  IF input_RESET ='0' THEN 
 
  ELSIF input_T'event AND input_T ='1' THEN
   
   output_Q <= signal_Q_non;
   output_Q_non <= signal_Q;
   signal_Q <= signal_Q_non;
   signal_Q_non <= signal_Q;
  
  END IF;
END PROCESS process_1;

END ARCHITECTURE rtl; -- konec architecture a begin  

