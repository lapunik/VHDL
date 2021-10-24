LIBRARY ieee; -- obrovská knihovna

USE ieee.std_logic_1164.ALL; --  balík z knihovny (singály, logické operátory, vektroy..)
USE ieee.numeric_std.ALL; -- balík z knihovny (pokud potrebujeme po?ítat)

ENTITY tb_dds_gen_avl IS 
END tb_dds_gen_avl; 

ARCHITECTURE sim OF tb_dds_gen_avl IS  

COMPONENT dds_gen_avl
PORT
	(
  rsi_reset_n : IN STD_LOGIC;
  csi_clk : IN STD_LOGIC;
  avs_write : IN STD_LOGIC;
  avs_write_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  avs_read : IN STD_LOGIC;
  avs_read_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
  avs_address : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
  ---------------------------------------------------------
  clk : OUT STD_LOGIC;
  r : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  g : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  sync : OUT STD_LOGIC;
  blank : OUT STD_LOGIC
	);
END COMPONENT;


  SIGNAL s_rsi_reset_n : STD_LOGIC;
  SIGNAL s_csi_clk : STD_LOGIC;
  SIGNAL s_avs_write : STD_LOGIC;
  SIGNAL s_avs_write_data : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL s_avs_read : STD_LOGIC;
  SIGNAL s_avs_read_data : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL s_avs_address : STD_LOGIC_VECTOR(1 DOWNTO 0);
  -----------------------------------------------------------------
  SIGNAL s_clk : STD_LOGIC;
  SIGNAL s_r : STD_LOGIC_VECTOR(9 DOWNTO 0);
  SIGNAL s_g : STD_LOGIC_VECTOR(9 DOWNTO 0);
  SIGNAL s_sync : STD_LOGIC;
  SIGNAL s_blank : STD_LOGIC;
  SIGNAL konec : STD_LOGIC;

BEGIN

 dds_gen_1: dds_gen_avl  
 PORT MAP(
  rsi_reset_n => s_rsi_reset_n,
  csi_clk  => s_csi_clk ,
  avs_write => s_avs_write,
  avs_write_data => s_avs_write_data,
  avs_read => s_avs_read,
  avs_read_data => s_avs_read_data,
  avs_address => s_avs_address,
  ---------------------------------------------------------
  clk => s_clk,
  r => s_r,
  g => s_g,
  sync => s_sync,
  blank => s_blank
 );


proces_clk: PROCESS
BEGIN 
s_csi_clk <= '0';
WAIT FOR 100 ns;
s_csi_clk <= '1';
WAIT FOR 100 ns;
IF konec = '1' THEN 
WAIT;
END IF;
END PROCESS;


proces_1: PROCESS
BEGIN 
konec <= '0';
s_rsi_reset_n <= '0';
WAIT UNTIL s_csi_clk = '0';
s_rsi_reset_n <= '1';
s_avs_write <= '0';
s_avs_read <= '0';
s_avs_address <= "00";
s_avs_write_data <= STD_LOGIC_VECTOR(to_unsigned(5000000,32));
WAIT UNTIL s_csi_clk = '0'; -- DDS 1 nebo 2, faze nebo posun
s_avs_write <= '1';
WAIT UNTIL s_csi_clk = '0';
s_avs_write <= '0';
WAIT FOR 1000000 ns;
WAIT UNTIL s_csi_clk = '0';
s_avs_address <= "00"; -- DDS 1 nebo 2, faze nebo posun
s_avs_write_data <= STD_LOGIC_VECTOR(to_unsigned(10000000,32));
WAIT UNTIL s_csi_clk = '0';
s_avs_write <= '1';
WAIT UNTIL s_csi_clk = '0';
s_avs_write <= '0';
WAIT FOR 1000000 ns;

konec <= '1';
WAIT;
END PROCESS; 

END ARCHITECTURE sim; -- konec architecture a begin  

