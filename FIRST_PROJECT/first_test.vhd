-- pak to bude first_test.vhd , otevrít z ModelSim (edit.new.file.vhd) 
-- asi by to chtelo se podivat jak PSPad s VHLD, jestli dostahnout nebo jak..

-- CTRL + F9 = KOMPILACE normálnì podle modelsimu 

library ieee; -- obrovská knihovna

use ieee.std_logic_1164.all; --  balík z knihovny (singály, logické operátory, vektroy..)
use ieee.numeric_std.all; -- balík z knihovny (pokud potrebujeme po?ítat)

entity first_test is -- zvyk je ?e se jmenuje entita stejn? jako projekt, klí?ová slova entity, is, v?dy kon?í end !

port
(
  input_a : in std_logic; -- "input_a" je pouze název, sm?r signálu (in, out, intout), typ "std_logic"
  input_b : in std_logic;
  output_y : out std_logic
);

end first_test; -- jmeno "first_test" tam byt nemusi

-- ted jsme nadefinovali bedinku se vstupy a vystupy, nic vic


architecture rtl of first_test is -- klí?ové slova of, architecture, is... "rtl" je název, ideál simulace/rtl nebo tak

-- tady se daji deklarovat taky nejaky klí?ovým slovem signal 

begin -- telo architektury, vsechno co je mezi begin a end se deje v jeden okamzik

output_y <= input_a and input_b; -- zapsani do portu nebo signalu <=, and, not, nor, xor atd.., ZAVORKOVAT!! divny veci s prioritama

end architecture rtl; -- konec architecture a begin  

-- ulozime, vratime se do modelsimu, pravy tla?ítko, compile, compile all
-- vysledek compile pouze v konzoli