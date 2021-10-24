library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mealy is 
port(
input : in std_logic_vector(1 downto 0) := "00";
output : out std_logic_vector(1 downto 0) := "00";
reset : inout std_logic := '1';
clk : in std_logic
);

end mealy;

architecture rtl of mealy is 

signal state : std_logic_vector(1 downto 0) := "00";

begin 

pr_1: process(clk)
begin

if reset = '0' then
state <= "00";
output <= "00";
elsif clk'event and clk = '1' then

if input = "00" then
if state = "00" then
state <= "01";
output <= "00";
elsif state = "01" then
state <= "10";
output <= "10";
elsif state = "10" then
state <= "10";
output <= "10";
else
reset <= '0';
end if;

elsif input = "01" then
if state = "00" then
state <= "00";
output <= "01";
elsif state = "01" then
state <= "00";
output <= "10";
elsif state = "10" then
state <= "00";
output <= "00";
else
reset <= '0';
end if;


elsif input = "10" then
if state = "00" then
state <= "00";
output <= "01";
elsif state = "01" then
state <= "01";
output <= "00";
elsif state = "10" then
state <= "00";
output <= "00";
else
reset <= '0';
end if;


else
reset <= '0';
end if; 

end if;  
end process;
end architecture;