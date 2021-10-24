library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_mealy is 
end tb_mealy;

architecture sim of tb_mealy is

component mealy is
port(
input : in std_logic_vector(1 downto 0);
output : out std_logic_vector(1 downto 0);
reset : inout std_logic;
clk : in std_logic
);
end component;

signal s_input : std_logic_vector(1 downto 0);
signal s_output : std_logic_vector(1 downto 0);
signal s_reset : std_logic;
signal s_clk : std_logic;
signal konec : std_logic; 

begin

m: mealy
port map
(
input => s_input,
output => s_output,
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
s_input <= "01";
wait for 200 ns;
s_input <= "10";
wait for 200 ns;
s_input <= "00";
wait for 200 ns;
s_input <= "10";
wait for 200 ns;
s_input <= "01";
wait for 200 ns;
s_input <= "00";
wait for 200 ns;
s_input <= "00";
wait for 200 ns;
s_input <= "00";
wait for 200 ns;
s_input <= "01";
wait for 200 ns;
s_input <= "00";
wait for 200 ns;
s_input <= "00";
wait for 200 ns;
s_input <= "00";
wait for 200 ns;
s_input <= "10"; 
wait for 200 ns;
konec <= '1';
wait;
end process; 
 
end architecture;