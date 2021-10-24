LIBRARY ieee; -- obrovská knihovna

USE ieee.std_logic_1164.ALL; --  balík z knihovny (singály, logické operátory, vektroy..)
USE ieee.numeric_std.ALL; -- balík z knihovny (pokud potrebujeme po?ítat)
                        
ENTITY vga_gen IS
PORT (
clk : IN STD_LOGIC; -- vstup hodinoveho kmitoctu 50.0 MHz
n_reset : IN STD_LOGIC; -- vstup asynchronniho resetu (aktivni v nule)
vga_clk : OUT STD_LOGIC; -- hodinovy vystup pro D/A VGA prevodnik (vzestupnou hr.)
vga_vsync : OUT STD_LOGIC; -- vertikalni synchronizace VGA
vga_hsync : OUT STD_LOGIC; -- horizontalni synchronizace VGA
vga_r : OUT STD_LOGIC_VECTOR(9 DOWNTO 0); -- R, data pro D/A VGA
vga_g : OUT STD_LOGIC_VECTOR(9 DOWNTO 0); -- G data pro D/A VGA
vga_b : OUT STD_LOGIC_VECTOR(9 DOWNTO 0); -- B data pro D/A VGA
vga_sync : OUT STD_LOGIC;-- log. 0 = synchronizace na zelene barve vypnuta
vga_blank : OUT STD_LOGIC -- log. 1 = RGB vystupy povoleny
-- pripadne dalsi vstupy/vystupy umistete az za tento komentar
);
END vga_gen; 
 
ARCHITECTURE rtl OF vga_gen IS  

COMPONENT D_async IS
GENERIC (bits : INTEGER := 10);
PORT
(
  input_D : IN STD_LOGIC_VECTOR((bits-1) DOWNTO 0); 
  input_CLK : IN STD_LOGIC;
  input_RESET : IN STD_LOGIC;
  output_Q : OUT STD_LOGIC_VECTOR((bits-1) DOWNTO 0)
);
END COMPONENT;

COMPONENT signal_generator IS

PORT
(
  input_CLK : IN STD_LOGIC;
  input_RESET : IN STD_LOGIC;
  output_X : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  output_Y : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  output_VERTICAL_SYNC : OUT STD_LOGIC;
  output_HORIZONTAL_SYNC : OUT STD_LOGIC
);

END COMPONENT;

COMPONENT picture_generator IS 
PORT
(
  input_CLK : IN STD_LOGIC;
  input_RESET : IN STD_LOGIC;
  input_X : IN STD_LOGIC_VECTOR(9 DOWNTO 0); 
  input_Y : IN STD_LOGIC_VECTOR(9 DOWNTO 0); 
  output_COLOR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)  
   
);

END COMPONENT;

COMPONENT color_coding IS

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

END COMPONENT;

COMPONENT T_async IS 

PORT
(
  input_T : IN STD_LOGIC; 
  input_RESET : IN STD_LOGIC;
  output_Q : OUT STD_LOGIC;
  output_Q_non : OUT STD_LOGIC
);

END COMPONENT;

SIGNAL clk_pll : STD_LOGIC;
SIGNAL signal_vertical_sync1 : STD_LOGIC_VECTOR(0 DOWNTO 0);
SIGNAL signal_vertical_sync2 : STD_LOGIC_VECTOR(0 DOWNTO 0);
SIGNAL signal_vertical_sync3 : STD_LOGIC_VECTOR(0 DOWNTO 0);
SIGNAL signal_horizontal_sync1 : STD_LOGIC_VECTOR(0 DOWNTO 0);
SIGNAL signal_horizontal_sync2 : STD_LOGIC_VECTOR(0 DOWNTO 0);
SIGNAL signal_horizontal_sync3 : STD_LOGIC_VECTOR(0 DOWNTO 0);
SIGNAL signal_color : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL signal_x : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL signal_y : STD_LOGIC_VECTOR(9 DOWNTO 0);



BEGIN -- telo architektury, vsechno co je mezi begin a end se deje v jeden okamziku
   
dvs1: D_async 
GENERIC MAP (bits => 1)
PORT MAP
(
  input_D => signal_vertical_sync1,
  input_CLK => clk_pll,
  input_RESET => n_reset,
  output_Q => signal_vertical_sync2
);

dhs1: D_async
GENERIC MAP (bits => 1)
PORT MAP
(
  input_D => signal_horizontal_sync1,
  input_CLK => clk_pll,
  input_RESET => n_reset,
  output_Q => signal_horizontal_sync2
);

dvs2: D_async 
GENERIC MAP (bits => 1)
PORT MAP
(
  input_D => signal_vertical_sync2,
  input_CLK => clk_pll,
  input_RESET => n_reset,
  output_Q => signal_vertical_sync3
);

dhs2: D_async
GENERIC MAP (bits => 1)
PORT MAP
(
  input_D => signal_horizontal_sync2,
  input_CLK => clk_pll,
  input_RESET => n_reset,
  output_Q => signal_horizontal_sync3
);

dvs3: D_async 
GENERIC MAP (bits => 1)
PORT MAP
(
  input_D => signal_vertical_sync3,
  input_CLK => clk_pll,
  input_RESET => n_reset,
  output_Q(0) => vga_vsync
);

dhs3: D_async
GENERIC MAP (bits => 1)
PORT MAP
(
  input_D => signal_horizontal_sync3,
  input_CLK => clk_pll,
  input_RESET => n_reset,
  output_Q(0) => vga_hsync
);

signal_generator1: signal_generator
PORT MAP
(
  input_CLK => clk_pll,
  input_RESET => n_reset,
  output_X => signal_x,
  output_Y => signal_y,
  output_VERTICAL_SYNC => signal_vertical_sync1(0), 
  output_HORIZONTAL_SYNC => signal_horizontal_sync1(0)
);

picture_generator1: picture_generator
PORT MAP
(
  input_CLK => clk_pll,
  input_RESET => n_reset,
  input_X  => signal_x,
  input_Y => signal_y,
  output_COLOR => signal_color 
   
);

color_coding1: color_coding
PORT MAP
(
  input_IN =>signal_color, 
  input_CLK => clk_pll,
  input_RESET => n_reset,
  output_SYNC =>vga_sync,
  output_BLANK =>vga_blank,
  output_RED => vga_r,
  output_GREEN => vga_g,
  output_BLUE  => vga_b
    
);

T_async1: T_async  

PORT MAP
( 
  input_T => clk,
  input_RESET => n_reset, 
  output_Q => clk_pll
);

vga_clk <= clk_pll;

END ARCHITECTURE rtl; -- konec architecture a begin   
