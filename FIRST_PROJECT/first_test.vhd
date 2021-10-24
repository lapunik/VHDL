-- pak to bude first_test.vhd , otevr�t z ModelSim (edit.new.file.vhd) 
-- asi by to chtelo se podivat jak PSPad s VHLD, jestli dostahnout nebo jak..

-- CTRL + F9 = KOMPILACE norm�ln� podle modelsimu 

library ieee; -- obrovsk� knihovna

use ieee.std_logic_1164.all; --  bal�k z knihovny (sing�ly, logick� oper�tory, vektroy..)
use ieee.numeric_std.all; -- bal�k z knihovny (pokud potrebujeme po?�tat)

entity first_test is -- zvyk je ?e se jmenuje entita stejn? jako projekt, kl�?ov� slova entity, is, v?dy kon?� end !

port
(
  input_a : in std_logic; -- "input_a" je pouze n�zev, sm?r sign�lu (in, out, intout), typ "std_logic"
  input_b : in std_logic;
  output_y : out std_logic
);

end first_test; -- jmeno "first_test" tam byt nemusi

-- ted jsme nadefinovali bedinku se vstupy a vystupy, nic vic


architecture rtl of first_test is -- kl�?ov� slova of, architecture, is... "rtl" je n�zev, ide�l simulace/rtl nebo tak

-- tady se daji deklarovat taky nejaky kl�?ov�m slovem signal 

begin -- telo architektury, vsechno co je mezi begin a end se deje v jeden okamzik

output_y <= input_a and input_b; -- zapsani do portu nebo signalu <=, and, not, nor, xor atd.., ZAVORKOVAT!! divny veci s prioritama

end architecture rtl; -- konec architecture a begin  

-- ulozime, vratime se do modelsimu, pravy tla?�tko, compile, compile all
-- vysledek compile pouze v konzoli