LIBRARY ieee; -- obrovská knihovna

USE ieee.std_logic_1164.ALL; --  balík z knihovny (singály, logické operátory, vektroy..)
USE ieee.numeric_std.ALL; -- balík z knihovny (pokud potrebujeme po?ítat)

ENTITY color_coding IS --
PORT
(
  input_IN : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  input_CLK : IN STD_LOGIC;
  input_RESET : IN STD_LOGIC; 
  output_SYNC : OUT STD_LOGIC;
  output_BLANK : OUT STD_LOGIC;
  output_RED : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  output_GREEN : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  output_BLUE : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
);

END color_coding; 
                      
ARCHITECTURE rtl OF color_coding IS  

BEGIN -- telo architektury, vsechno co je mezi begin a end se deje v jeden okamziku

output_SYNC <= '0';

process_1: PROCESS(input_CLK,input_RESET)
BEGIN

   IF input_RESET = '0' THEN 
 
    output_RED <= STD_LOGIC_VECTOR(to_unsigned(0,10));
    output_GREEN <= STD_LOGIC_VECTOR(to_unsigned(0,10));    
    output_BLUE <= STD_LOGIC_VECTOR(to_unsigned(0,10));
    output_BLANK <= '0';
    
 
  ELSIF input_CLK'event AND input_CLK ='1' THEN
 
  output_BLANK <= '1';
 
  segment: CASE input_IN IS
              WHEN "0000" =>         -- Black
        output_RED   <= "0000000000"; 
        output_GREEN <= "0000000000";
        output_BLUE  <= "0000000000";
              WHEN "1111" =>         -- White
        output_RED   <= "1111111111"; 
        output_GREEN <= "1111111111";
        output_BLUE  <= "1111111111";
              WHEN "1100" =>         -- Red
        output_RED   <= "1111111111"; 
        output_GREEN <= "0000000000";
        output_BLUE  <= "0000000000";
              WHEN "1010" =>         -- Lime
        output_RED   <= "0000000000"; 
        output_GREEN <= "1111111111";
        output_BLUE  <= "0000000000";
              WHEN "1001" =>         -- Blue
        output_RED   <= "0000000000"; 
        output_GREEN <= "0000000000";
        output_BLUE  <= "1111111111";
              WHEN "1110" =>         -- Yellow
        output_RED   <= "1111111111"; 
        output_GREEN <= "1111111111";
        output_BLUE  <= "0000000000";
              WHEN "1011" =>         -- Cyan
        output_RED   <= "0000000000"; 
        output_GREEN <= "1111111111";
        output_BLUE  <= "1111111111";
              WHEN "1101" =>         -- Magenta
        output_RED   <= "1111111111"; 
        output_GREEN <= "0000000000";
        output_BLUE  <= "1111111111";
              WHEN "1000" =>         -- Silver
        output_RED   <= "1100000000"; 
        output_GREEN <= "1100000000";
        output_BLUE  <= "1100000000";
              WHEN "0111" =>         -- Gray
        output_RED   <= "1000000000"; 
        output_GREEN <= "1000000000";
        output_BLUE  <= "1000000000";           
              WHEN "0100" =>         -- Maroon
        output_RED   <= "1000000000"; 
        output_GREEN <= "0000000000";
        output_BLUE  <= "0000000000"; 
              WHEN "0110" =>         -- Olive
        output_RED   <= "1000000000"; 
        output_GREEN <= "1000000000";
        output_BLUE  <= "0000000000";
              WHEN "0010" =>         -- Green
        output_RED   <= "0000000000"; 
        output_GREEN <= "1000000000";
        output_BLUE  <= "0000000000";
              WHEN "0101" =>         -- Purple
        output_RED   <= "1000000000"; 
        output_GREEN <= "0000000000";
        output_BLUE  <= "1000000000";
              WHEN "0011" =>         -- Teal
        output_RED   <= "0000000000"; 
        output_GREEN <= "1000000000";
        output_BLUE  <= "1000000000";
              WHEN "0001" =>         -- Navy
        output_RED   <= "0000000000"; 
        output_GREEN <= "0000000000";
        output_BLUE  <= "1000000000";
               WHEN others =>         
        output_RED   <= "0000000000"; 
        output_GREEN <= "0000000000";
        output_BLUE  <= "0000000000";
              
    END CASE;
  END IF;  
END PROCESS process_1;

END ARCHITECTURE rtl; -- konec architecture a begin  



