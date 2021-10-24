LIBRARY ieee; -- obrovská knihovna

USE ieee.std_logic_1164.ALL; --  balík z knihovny (singály, logické operátory, vektroy..)
USE ieee.numeric_std.ALL; -- balík z knihovny (pokud potrebujeme po?ítat)

                        
ENTITY top_registr_sedmi_segment IS --
PORT
(
  input_CLK : IN STD_LOGIC;
  input_RESTART : IN STD_LOGIC;
  output_SEGMENT_0_3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
  output_SEGMENT_4_7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
);

END top_registr_sedmi_segment; 


ARCHITECTURE rtl OF top_registr_sedmi_segment IS  

COMPONENT counter IS -- neco trida v C# (nekde je napsaná t?ída a já jí tady chci pou?ít, tak ud?lám instanci), instanci delam v t?lu architektury (begin)  
                        -- jméno "first_test" asi musi byt stejne jako je v .vhd, nebo spí? ne
PORT
(
  input_CLK : IN STD_LOGIC;
  input_RESTART : IN STD_LOGIC;
  output_Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);

END COMPONENT;

COMPONENT sedmi_segment_async IS -- neco trida v C# (nekde je napsaná t?ída a já jí tady chci pou?ít, tak ud?lám instanci), instanci delam v t?lu architektury (begin)  
                        -- jméno "first_test" asi musi byt stejne jako je v .vhd, nebo spí? ne
PORT
(
  input_IN : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
  output_SEGMENT : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
);

END COMPONENT;

SIGNAL output_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0);

SIGNAL negace_SEGMENT_0_3 : STD_LOGIC_VECTOR(6 DOWNTO 0);  -- negace vystupu protoze sedmisegment je akntivni na nulu
SIGNAL negace_SEGMENT_4_7 : STD_LOGIC_VECTOR(6 DOWNTO 0);


BEGIN -- telo architektury, vsechno co je mezi begin a end se deje v jeden okamziku

i_counter: counter PORT MAP
(
  input_CLK => input_CLK,
  input_RESTART => input_RESTART,
  output_Q => output_OUT
);

i_segment_0_3: sedmi_segment_async PORT MAP
(
  input_IN => output_OUT(3 DOWNTO 0), 
  output_SEGMENT => negace_SEGMENT_0_3 
);

i_segment_4_7: sedmi_segment_async PORT MAP
(
  input_IN => output_OUT(7 DOWNTO 4), 
  output_SEGMENT => negace_SEGMENT_4_7 
);
    output_SEGMENT_4_7 <= NOT negace_SEGMENT_4_7;
    output_SEGMENT_0_3 <= NOT negace_SEGMENT_0_3;
    
END ARCHITECTURE rtl; -- konec architecture a begin   