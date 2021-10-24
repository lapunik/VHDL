library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_pravdivostni_tabulka is 
end tb_pravdivostni_tabulka;

architecture sim of tb_pravdivostni_tabulka is

component pravdivostni_tabulka is
port(
a : in std_logic;
b : in std_logic;
c : in std_logic;
y : out std_logic;
reset : in std_logic;
clk : in std_logic
);
end component;

signal s_a : std_logic;
signal s_b : std_logic;
signal s_c : std_logic;
signal s_y : std_logic; 
signal s_reset : std_logic;
signal s_clk : std_logic;
signal s_test : std_logic_vector(2 downto 0) := "000"; 
signal konec : std_logic; 

begin

m: pravdivostni_tabulka
port map
(
a => s_a,
b => s_b,
c => s_c,
y => s_y,
reset => s_reset,
clk => s_clk
);

procces_clk: process
begin
s_clk <= '0';
wait for 100 ns;
s_clk <= '1';
wait for 100 ns;
if konec = '1' then
wait;
end if;
end process; 


procces_input: process
begin
konec <= '0';
s_reset <= '1';

for i in 0 to 8 loop
s_test <= std_logic_vector(to_unsigned(i,3));
s_c <= s_test(0);
s_b <= s_test(1);
s_a <= s_test(2);
wait for 200 ns;
end loop;

konec <= '1';
wait;
end process; 
 
end architecture;
