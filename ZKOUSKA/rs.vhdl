library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rs is 
port(
r : in std_logic := '0';
s : in std_logic := '0';
q : buffer std_logic := '0';
q_n : out std_logic := '0'
);
end rs;

architecture rtl of rs is
begin

pro_1: process(r,s)
begin

if r = '1' and s = '0' then
q <= '0';
elsif r = '0' and s = '1' then
q <= '1';
end if;

end process;

q_n <= not q;

end architecture;