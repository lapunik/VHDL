library ieee;

use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity testbench is -- "testbench" je název
end testbench; 

architecture simulace of testbench is -- klasika jako ve first_test

-- Components

component first_test is -- neco trida v C# (nekde je napsaná t?ída a já jí tady chci pou?ít, tak ud?lám instanci), instanci delam v t?lu architektury (begin)  
                        -- jméno "first_test" asi musi byt stejne jako je v .vhd, nebo spí? ne
port
(
  input_a : in std_logic; -- "input_a" je pouze název, sm?r signálu (in, out, intout), typ "std_logic"
  input_b : in std_logic;
  output_y : out std_logic
);

end component;

-- Signals

signal a : std_logic;
signal b : std_logic;
signal y : std_logic;

begin

dut: first_test -- tohle je ta "instance" [dut = design under test]
-- klí?ová slova port, map
-- port map (a,b,c); -- napojeni signalu, první component a se napojí na první signál, je to rychlý ale ne?ikovný p?i více port?
                 
-- pro víc port?:
port map (
input_a => a, -- (co vkládám => na jaký zdroj) 
input_b => b,
output_y => y
);

-- kdyz ptrebuju aby se neco delalo sekvence, nekonecne se opakujici kod.. pokud mu nereknu jinak (wait) 
process -- kdyz nema jmeno, tak je urceny JEN pro simulaci
begin

a <= '0';
b <= '0';
wait for 100 ns; -- není syntetizovatelný, jen pro simulace!!! --00

a <= '1';
wait for 100 ns; -- 01

b <= '1';
wait for 100 ns; -- 11

a <= '0';
-- wait for 100 ns; -- 10

wait; -- stuj navzdycky (aby nám nezahltil PC)
      -- pokud v testbench nebude zadny proces ktery nebude spat, MODELSIM sám ukon?í process

end process;
end architecture simulace;

-- v simulaci simulate, view window object, oznacit add wawe, dvojata sipka(start all), v okne wawe dám f  jako full scale a jedu
