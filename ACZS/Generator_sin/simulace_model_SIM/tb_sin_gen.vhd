LIBRARY ieee; -- obrovská knihovna

USE ieee.std_logic_1164.ALL; --  balík z knihovny (singály, logické operátory, vektroy..)
USE ieee.numeric_std.ALL; -- balík z knihovny (pokud potrebujeme po?ítat)

ENTITY tb_sin_gen IS 
END tb_sin_gen; 

ARCHITECTURE sim OF tb_sin_gen IS  

COMPONENT sin_gen
PORT
	(
  clk : IN STD_LOGIC;
  reset_n : IN STD_LOGIC;
  vga_clk : OUT STD_LOGIC;
  vga_r : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
--  vga_g : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
--  vga_b : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  vga_sync : OUT STD_LOGIC;
  vga_blank : OUT STD_LOGIC 
	);
END COMPONENT;

 SIGNAL sig_clk : STD_LOGIC;
 SIGNAL sig_reset_n : STD_LOGIC;
 SIGNAL sig_vga_clk : STD_LOGIC;
 SIGNAL sig_vga_r : STD_LOGIC_VECTOR(9 DOWNTO 0);
 --SIGNAL sig_vga_g : STD_LOGIC_VECTOR(9 DOWNTO 0);
 --SIGNAL sig_vga_b : STD_LOGIC_VECTOR(9 DOWNTO 0);
 SIGNAL sig_vga_sync : STD_LOGIC;
 SIGNAL sig_vga_blank : STD_LOGIC;
 SIGNAL sig_end : STD_LOGIC := '0';
 
 BEGIN 
 
 i_rom: sin_gen 
 PORT MAP(
  clk => sig_clk,
  reset_n => sig_reset_n,
  vga_clk => sig_vga_clk,
  vga_r => sig_vga_r,
--  vga_g => sig_vga_g,
--  vga_b => sig_vga_b,
  vga_sync => sig_vga_sync,
  vga_blank => sig_vga_blank 
 );

r_process: PROCESS 
BEGIN

sig_reset_n <= '0';
WAIT FOR 1000 ns;  
sig_reset_n <= '1';        
WAIT FOR 3000000 ns;       
sig_reset_n <= '0';
sig_end <= '1';                 
WAIT;
END PROCESS r_process;


clk_process: PROCESS 
BEGIN

sig_clk <= '0';
WAIT FOR 100 ns; 
sig_clk <= '1';
WAIT FOR 100 ns;

IF sig_end = '1' THEN
WAIT;
END IF;
END PROCESS clk_process;

END ARCHITECTURE sim;