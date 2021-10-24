LIBRARY ieee; -- obrovská knihovna

USE ieee.std_logic_1164.ALL; --  balík z knihovny (singály, logické operátory, vektroy..)
USE ieee.numeric_std.ALL; -- balík z knihovny (pokud potrebujeme po?ítat)
                        
ENTITY tb_vga_gen IS
END tb_vga_gen; 
 
ARCHITECTURE simulace OF tb_vga_gen IS  

COMPONENT vga_gen IS
PORT 
(
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
);
END COMPONENT;

SIGNAL signal_clk : STD_LOGIC;
SIGNAL signal_n_reset : STD_LOGIC;
SIGNAL signal_vga_clk : STD_LOGIC;
SIGNAL signal_vga_vsync : STD_LOGIC;
SIGNAL signal_vga_hsync : STD_LOGIC;
SIGNAL signal_vga_r : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL signal_vga_g : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL signal_vga_b : STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL signal_vga_sync : STD_LOGIC;
SIGNAL signal_vga_blank : STD_LOGIC;
SIGNAL signal_end : BOOLEAN;

BEGIN 

dut: vga_gen
PORT MAP
(
clk => signal_clk,
n_reset => signal_n_reset,
vga_clk => signal_vga_clk,
vga_vsync => signal_vga_vsync,
vga_hsync => signal_vga_hsync,
vga_r  => signal_vga_r,
vga_g  => signal_vga_g,
vga_b => signal_vga_b,
vga_sync => signal_vga_sync,
vga_blank  => signal_vga_blank
);

reset_process: PROCESS 
BEGIN

signal_n_reset <= '0'; 
signal_n_reset <= '1';        
WAIT FOR 1000000000 ns;         
signal_n_reset <= '0';                
WAIT;
END PROCESS reset_process;

clk_process: PROCESS 
BEGIN

signal_clk <= '0';
WAIT FOR 100 ns; 

signal_clk <= '1';
WAIT FOR 100 ns;

  IF signal_n_reset = '0' THEN  
  WAIT; 
  END IF;

END PROCESS clk_process;

END ARCHITECTURE simulace;

