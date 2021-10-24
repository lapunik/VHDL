LIBRARY ieee; -- obrovská knihovna

USE ieee.std_logic_1164.ALL; --  balík z knihovny (singály, logické operátory, vektroy..)
USE ieee.numeric_std.ALL; -- balík z knihovny (pokud potrebujeme po?ítat)


ENTITY top_registr_sedmi_segment IS --
PORT
(
  input_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
  input_CLK : IN STD_LOGIC;
  input_RESTART : IN STD_LOGIC;
  output_SEGMENT_0_3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
  output_SEGMENT_4_7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
);

END top_registr_sedmi_segment; 


ARCHITECTURE rtl OF top_registr_sedmi_segment IS  

COMPONENT registr_8bit_async IS -- neco trida v C# (nekde je napsaná t?ída a já jí tady chci pou?ít, tak ud?lám instanci), instanci delam v t?lu architektury (begin)  
                        -- jméno "first_test" asi musi byt stejne jako je v .vhd, nebo spí? ne
PORT
(
  input_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
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

COMPONENT nasobicka_async IS -- neco trida v C# (nekde je napsaná t?ída a já jí tady chci pou?ít, tak ud?lám instanci), instanci delam v t?lu architektury (begin)  
                        -- jméno "first_test" asi musi byt stejne jako je v .vhd, nebo spí? ne
PORT
(
  input_A : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
  input_B : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
  output_RESULT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);

END COMPONENT;

SIGNAL output_OUT_SOUCIN : STD_LOGIC_VECTOR(7 DOWNTO 0); -- VYSTUP Z CITACKY 
SIGNAL output_OUT_REG : STD_LOGIC_VECTOR(7 DOWNTO 0); -- VYSTUP Z REGSTRU PRO SCITACKU

SIGNAL negace_SEGMENT_0_3 : STD_LOGIC_VECTOR(6 DOWNTO 0);  -- negace vystupu protoze sedmisegment je akntivni na nulu
SIGNAL negace_SEGMENT_4_7 : STD_LOGIC_VECTOR(6 DOWNTO 0);


BEGIN -- telo architektury, vsechno co je mezi begin a end se deje v jeden okamziku

i_reg: registr_8bit_async PORT MAP
(
  input_IN => input_IN,
  input_CLK => input_CLK,
  input_RESTART => input_RESTART,
  output_Q => output_OUT_REG
);

i_segment_0_3: sedmi_segment_async PORT MAP
(
  input_IN => output_OUT_SOUCIN(3 DOWNTO 0),
  output_SEGMENT =>  negace_SEGMENT_0_3 
);

i_segment_4_7: sedmi_segment_async PORT MAP
(
  input_IN => output_OUT_SOUCIN(7 DOWNTO 4),
  output_SEGMENT =>  negace_SEGMENT_4_7
);

soucin: nasobicka_async PORT MAP
(
     input_A => output_OUT_REG(3 DOWNTO 0),
     input_B => output_OUT_REG(7 DOWNTO 4),       
     output_RESULT => output_OUT_SOUCIN     
     
);

    output_SEGMENT_4_7 <= NOT negace_SEGMENT_4_7;
    output_SEGMENT_0_3 <= NOT negace_SEGMENT_0_3;


END ARCHITECTURE rtl; -- konec architecture a begin   