LIBRARY ieee; -- obrovská knihovna

USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;

ENTITY signal_generator IS --

PORT
(
  input_CLK : IN STD_LOGIC;
  input_RESET : IN STD_LOGIC;
  output_X : OUT STD_LOGIC_VECTOR(9 DOWNTO 0); -- (0 až 799)
  output_Y : OUT STD_LOGIC_VECTOR(9 DOWNTO 0); -- (0 až 524)
  output_VERTICAL_SYNC : OUT STD_LOGIC; -- Vertikální synchronizace 
  output_HORIZONTAL_SYNC : OUT STD_LOGIC -- Horizontální synchronizace 
);

END signal_generator; 


ARCHITECTURE rtl OF signal_generator IS  

SIGNAL pomocna_x: STD_LOGIC_VECTOR (9 DOWNTO 0) := STD_LOGIC_VECTOR(to_unsigned(0, 10)); -- "0000000000"
SIGNAL pomocna_y: STD_LOGIC_VECTOR (9 DOWNTO 0) := STD_LOGIC_VECTOR(to_unsigned(0, 10)); -- "0000000000"

BEGIN -- telo architektury, vsechno co je mezi begin a end se deje v jeden okamziku

process_1: PROCESS(input_CLK,input_RESET)
BEGIN
    -- reset
  IF input_RESET ='0' THEN 
 
    output_X <= STD_LOGIC_VECTOR(to_unsigned(0,10));
    output_Y <= STD_LOGIC_VECTOR(to_unsigned(0,10));    
    pomocna_x <= STD_LOGIC_VECTOR(to_unsigned(0,10));
    pomocna_y <= STD_LOGIC_VECTOR(to_unsigned(0,10));
 
 
    -- generátor signálù X,Y (counter v counteru (800 iterací v 525 iteracích)
  ELSIF input_CLK'event AND input_CLK ='1' THEN
    pomocna_x <= STD_LOGIC_VECTOR(unsigned(pomocna_x) + 1);                                                   
    IF (unsigned(pomocna_x) = 799) THEN -- musí tu být 799/524.. pøedchozí inkrementace se zapíše až pøi dokonèení procesu nebo wait!!
       pomocna_x <= STD_LOGIC_VECTOR(to_unsigned(0,10));
       pomocna_y <= STD_LOGIC_VECTOR(unsigned(pomocna_y) + 1);
      IF (unsigned(pomocna_y) = 524) THEN
         pomocna_y <= STD_LOGIC_VECTOR(to_unsigned(0,10));
      END IF;
    END IF;
    output_X <= pomocna_x; 
    output_Y <= pomocna_y;
    
    -- generator signalù synchronizace (èasování)
    IF  (unsigned(pomocna_x) >= 8) AND (unsigned(pomocna_x) <= 103) THEN
      output_HORIZONTAL_SYNC <= '0';
    ELSE
      output_HORIZONTAL_SYNC <= '1';  
    END IF;
    
    IF  (unsigned(pomocna_y) = 2) OR (unsigned(pomocna_y) = 3) THEN
      output_VERTICAL_SYNC <= '0';
    ELSE
      output_VERTICAL_SYNC <= '1';  
    END IF;
    
END IF;

END PROCESS process_1;

END ARCHITECTURE rtl; -- konec architecture a begin   