LIBRARY ieee; -- obrovsk� knihovna

USE ieee.std_logic_1164.ALL; 
USE ieee.numeric_std.ALL;

ENTITY picture_generator IS --

PORT
(
  input_CLK : IN STD_LOGIC;
  input_RESET : IN STD_LOGIC;
  input_X : IN STD_LOGIC_VECTOR(9 DOWNTO 0); -- (0 a� 799)
  input_Y : IN STD_LOGIC_VECTOR(9 DOWNTO 0); -- (0 a� 524)
  output_COLOR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)  
   
);

END picture_generator; 


ARCHITECTURE rtl OF picture_generator IS  

COMPONENT rom IS 
PORT
	(
		address		: IN STD_LOGIC_VECTOR (16 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT D_async IS
GENERIC (bits : integer := 10); 
PORT
(
  input_D : IN STD_LOGIC_VECTOR((bits-1) DOWNTO 0); 
  input_CLK : IN STD_LOGIC;
  input_RESET : IN STD_LOGIC;
  output_Q : OUT STD_LOGIC_VECTOR((bits-1) DOWNTO 0)
);

END COMPONENT;

SIGNAL signal_rom_out_q : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL signal_adress : STD_LOGIC_VECTOR(16 DOWNTO 0) := STD_LOGIC_VECTOR(to_unsigned(0, 17)); --"00 0000 0000 0000"
SIGNAL signal_x1 : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL signal_x2 : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL signal_y1 : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL signal_y2 : STD_LOGIC_VECTOR(9 DOWNTO 0);

BEGIN -- telo architektury, vsechno co je mezi begin a end se deje v jeden okamziku
   
port_map_rom: rom PORT MAP
(
  clock => input_CLK,
  address => signal_adress,
  q => signal_rom_out_q
);

dx1: D_async 
GENERIC MAP (bits => 10)
PORT MAP
(
  input_D => input_X,
  input_CLK => input_CLK,
  input_RESET => input_RESET,
  output_Q => signal_x1
);

dx2: D_async
GENERIC MAP (bits => 10)
PORT MAP
(
  input_D => signal_x1,
  input_CLK => input_CLK,
  input_RESET => input_RESET,
  output_Q => signal_x2
);
dy1: D_async
GENERIC MAP (bits => 10)
PORT MAP
(
  input_D => input_Y,
  input_CLK => input_CLK,
  input_RESET => input_RESET,
  output_Q => signal_y1
);

dy2: D_async
GENERIC MAP (bits => 10)
PORT MAP
(
  input_D => signal_y1,
  input_CLK => input_CLK,
  input_RESET => input_RESET,
  output_Q => signal_y2
);

process_1: PROCESS(input_CLK,input_RESET)
BEGIN

  IF input_RESET ='0' THEN 
 
    output_COLOR <= STD_LOGIC_VECTOR(to_unsigned(0,4));
    signal_adress <= STD_LOGIC_VECTOR(to_unsigned(0,17));
    
 
  ELSIF input_CLK'event AND input_CLK ='1' THEN
  
  output_COLOR <=  signal_rom_out_q;
   
  IF ((unsigned(input_X) < 118) OR (unsigned(input_X) > 761) OR (unsigned(input_Y) < 27) OR (unsigned(input_Y) > 506)) THEN
    -- 152 791 37 516
    output_COLOR <= STD_LOGIC_VECTOR(to_unsigned(0,4));  -- stin�tko + okraje
      
  ELSIF ((unsigned(input_X) < 282) OR (unsigned(input_X) > 601) OR (unsigned(input_Y) < 147) OR (unsigned(input_Y) > 385)) THEN
 -- 312 632 157 396
      output_COLOR <= signal_x2(7 DOWNTO 4); -- pruhy vertik�ln� (X)
    --report "number from strips";
      IF ((unsigned(input_X) = 630) AND (unsigned(input_Y) = 394)) THEN
		
		signal_adress <= STD_LOGIC_VECTOR(to_unsigned(0,17));
		
		END IF;  
  ELSE
    -- obrazek z ROM
    output_COLOR <=  signal_rom_out_q;
    -- nastaveni rom do pozice 
        
		  IF ((unsigned(input_X) = 282) OR (unsigned(input_X) = 283)) THEN 
		  output_COLOR <= signal_x2(7 DOWNTO 4);
		  END IF;
		  
    IF (unsigned(signal_adress) = 76799) THEN 
    
    signal_adress <= STD_LOGIC_VECTOR(to_unsigned(0,17)); -- obrazek dokoncen, najed zase na prvni pozici
                    
    ELSE
    
     signal_adress <= STD_LOGIC_VECTOR(unsigned(signal_adress) + 1); -- posun na dal�� 4 bity obrazku (4 bity davaj� dohromady jeden barevn� pixel)
    
    END IF;  
    
  END IF;

  END IF;

END PROCESS process_1;

END ARCHITECTURE rtl; -- konec architecture a begin   
