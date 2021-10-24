library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity JK is 
port(
j : in std_logic := '0';
k : in std_logic := '0';
q : buffer std_logic := '0';
q_n : out std_logic := '0';
clk : in std_logic := '0'
);
end JK;

architecture rtl of JK is
begin

pro_1: process(clk)
begin
if clk'event and clk = '1' then
if k = '1' and j = '0' then
q <= '0';
elsif k = '0' and j = '1' then
q <= '1';
elsif k = '1' and j = '1' then
q <= not q;
end if;
end if;
end process;

q_n <= not q;

end architecture;
