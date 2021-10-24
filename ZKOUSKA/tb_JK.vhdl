library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_JK is 
end tb_JK;

architecture sim of tb_JK is

component JK is
port(
j : in std_logic := '0';
k : in std_logic := '0';
q : buffer std_logic := '0';
q_n : out std_logic := '0';
clk : in std_logic := '0'
);
end component;

signal s_j : std_logic;
signal s_k : std_logic;
signal s_q : std_logic;
signal s_q_n : std_logic; 
signal s_clk : std_logic; 
signal konec : std_logic; 

begin

r: JK
port map
(
j => s_j,
k => s_k,
q => s_q,
q_n => s_q_n,
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


s_j <= '0';
s_k <= '0';
wait for 400 ns;
s_j <= '0';
s_k <= '1';
wait for 400 ns;
s_j <= '1';
s_k <= '0';
wait for 400 ns;
s_j <= '1';
s_k <= '1';
wait for 400 ns;
konec <='1';
wait;
end process; 
 
end architecture;
