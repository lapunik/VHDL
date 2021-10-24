LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
       
ENTITY RAM IS
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
END RAM; 

ARCHITECTURE rtl OF RAM IS                        
SIGNAL data : STD_LOGIC_VECTOR ((256*8)-1 DOWNTO 0);
BEGIN                         

proces_wr: process(wr_clk)
begin                                                
if wr_clk'event and wr_clk = '1' and wr_en = '1' then
data(((to_integer(unsigned(wr_addr)))*8+7) downto ((to_integer(unsigned(wr_addr)))*8)) <= din; 
end if;
end process;

proces_rd: process(rd_clk)
begin                                                
if rd_clk'event and rd_clk = '1' and rd_en = '1' then
dout <= data(((to_integer(unsigned(rd_addr)))*8+7) downto ((to_integer(unsigned(rd_addr)))*8)); 
end if;
end process;

END ARCHITECTURE rtl;