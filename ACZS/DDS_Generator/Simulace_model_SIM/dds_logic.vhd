LIBRARY ieee; -- obrovská knihovna

USE ieee.std_logic_1164.ALL; --  balík z knihovny (singály, logické operátory, vektroy..)
USE ieee.numeric_std.ALL; -- balík z knihovny (pokud potrebujeme po?ítat)

ENTITY dds_logic IS 
GENERIC(
akumulator_sirka : POSITIVE := 32;
rozliseni_sirka : POSITIVE := 12;
faze_sirka : POSITIVE := 12
);
PORT
(
  clk : IN STD_LOGIC;
  reset_n : IN STD_LOGIC;
  clk_enable : IN STD_LOGIC;
  faze_inkrement : IN UNSIGNED(akumulator_sirka-1 DOWNTO 0);
  faze_mod : IN UNSIGNED(faze_sirka-1 DOWNTO 0);
  rom_adresa : OUT STD_LOGIC_VECTOR(rozliseni_sirka-1 DOWNTO 0)
);

END dds_logic; 

ARCHITECTURE rtl OF dds_logic IS  

 SIGNAL s_faze : UNSIGNED(akumulator_sirka-1 downto 0) := (OTHERS => '0');
 SIGNAL s_acumulator : UNSIGNED(akumulator_sirka-1 downto 0) := (OTHERS => '0');
 ALIAS s_rom_adresa_out : UNSIGNED(rozliseni_sirka - 1 DOWNTO 0) IS s_faze (akumulator_sirka-1 DOWNTO akumulator_sirka-rozliseni_sirka);
 CONSTANT zero : UNSIGNED(akumulator_sirka-rozliseni_sirka -1 DOWNTO 0) := (OTHERS => '0');

 BEGIN

 rom_adresa <= STD_LOGIC_VECTOR(s_rom_adresa_out);

 pr_gen: PROCESS (clk,reset_n)
 BEGIN
 IF reset_n = '0' THEN
 s_acumulator <= (OTHERS => '0');
 s_faze <= faze_mod & zero;
 ELSIF RISING_EDGE(clk) THEN
 IF clk_enable = '1' THEN
 s_acumulator <= s_acumulator + faze_inkrement;
 s_faze <= s_acumulator + (faze_mod & zero);
 END IF;
 END IF;
 END PROCESS;

END ARCHITECTURE rtl; -- konec architecture a begin  