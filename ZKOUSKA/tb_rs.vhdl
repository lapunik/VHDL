
                                        library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_rs is 
end tb_rs;

architecture sim of tb_rs is

component rs is
port(
r : in std_logic := '0';
s : in std_logic := '0';
q : buffer std_logic := '0';
q_n : out std_logic := '0'
);
end component;

signal s_r : std_logic;
signal s_s : std_logic;
signal s_q : std_logic;
signal s_q_n : std_logic; 

begin

r: rs
port map
(
r => s_r,
s => s_s,
q => s_q,
q_n => s_q_n
);


procces_input: process
begin

s_s <= '0';
s_r <= '0';
wait for 100 ns;
s_s <= '0';
s_r <= '1';
wait for 100 ns;
s_s <= '1';
s_r <= '0';
wait for 100 ns;
s_s <= '1';
s_r <= '1';
wait for 200 ns;
wait;
end process; 
 
end architecture;
