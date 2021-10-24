library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pravdivostni_tabulka is
port(
a : in std_logic;
b : in std_logic;
c : in std_logic;
y : out std_logic;
reset : in std_logic;
clk : in std_logic
);
end pravdivostni_tabulka;

architecture rtl of pravdivostni_tabulka is
begin
pro: process (clk)
begin
if reset = '0' then 
y <= '0';
elsif clk'event and clk = '1' then

if (a = '0' and (b = '0' or c = '1'))or(a = '1' and b = '1' and c = '0')  then
y<='1';
else
y<='0'; 
end if; 

end if;
end process;
end architecture;