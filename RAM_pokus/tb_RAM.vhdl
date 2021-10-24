LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_RAM IS
END tb_RAM;

ARCHITECTURE sim OF tb_RAM IS

SIGNAL s_wr_clk : STD_LOGIC;
SIGNAL s_wr_addr : STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL s_wr_en : STD_LOGIC := '1';
SIGNAL s_rd_clk : STD_LOGIC;
SIGNAL s_rd_addr : STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL s_rd_en : STD_LOGIC := '1';
SIGNAL s_din : STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL s_dout : STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL e : STD_LOGIC;

COMPONENT RAM IS
PORT 
(
wr_clk : IN STD_LOGIC;
wr_addr : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
wr_en : IN STD_LOGIC;
rd_clk : IN STD_LOGIC;
rd_addr : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
rd_en : IN STD_LOGIC;
din : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
dout : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);

END COMPONENT; 

BEGIN

r: RAM
PORT MAP
(

wr_clk => s_wr_clk, 
wr_addr => s_wr_addr,
wr_en => s_wr_en,
rd_clk => s_rd_clk,
rd_addr => s_rd_addr,
rd_en => s_rd_en,
din => s_din,
dout => s_dout
);

proces_clk_wr: PROCESS
BEGIN 
s_wr_clk <= '0';
WAIT FOR 100 ns;
s_wr_clk <= '1';
WAIT FOR 100 ns;
IF e = '1' THEN 
WAIT;
END IF;
END PROCESS;

proces_clk_rd: PROCESS
BEGIN 
s_rd_clk <= '0';
WAIT FOR 100 ns;
s_rd_clk <= '1';
WAIT FOR 100 ns;
IF e = '1' THEN 
WAIT;
END IF;
END PROCESS;


proces_1: PROCESS
BEGIN 
e <= '0';
s_wr_addr <= STD_LOGIC_VECTOR(to_unsigned(0,8));
s_rd_addr <= STD_LOGIC_VECTOR(to_unsigned(0,8));
s_din <= STD_LOGIC_VECTOR(to_unsigned(0,8));
WAIT FOR 200 ns;

FOR i IN 0 TO 255 LOOP
s_wr_addr <= STD_LOGIC_VECTOR(to_unsigned(i,8));
s_din <= STD_LOGIC_VECTOR(to_unsigned(i,8));
WAIT FOR 200 ns;
END LOOP;

FOR i IN 0 TO 255 LOOP
s_rd_addr <= STD_LOGIC_VECTOR(to_unsigned(i,8));
WAIT FOR 200 ns;
END LOOP;

e <= '1';
WAIT;
END PROCESS; 

END ARCHITECTURE sim; 

