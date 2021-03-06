LIBRARY ieee; -- obrovsk? knihovna

USE ieee.std_logic_1164.ALL; --  bal?k z knihovny (sing?ly, logick? oper?tory, vektroy..)
USE ieee.numeric_std.ALL; -- bal?k z knihovny (pokud potrebujeme po??tat)

ENTITY sin_gen IS 
PORT
(
  clk : IN STD_LOGIC;
  reset_n : IN STD_LOGIC;
  vga_clk : OUT STD_LOGIC;
  vga_r : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
--  vga_g : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
--  vga_b : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  vga_sync : OUT STD_LOGIC;
  vga_blank : OUT STD_LOGIC 
);

END sin_gen; 

ARCHITECTURE rtl OF sin_gen IS  

COMPONENT sig_rom
PORT
	(
		aclr		: IN STD_LOGIC  := '0';
		address		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
	);
END COMPONENT;

component sondy
	PORT
	(
		probe		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		source		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;


 SIGNAL aclr : STD_LOGIC := '0';
 SIGNAL address : STD_LOGIC_VECTOR(11 DOWNTO 0);
 SIGNAL data : STD_LOGIC_VECTOR(9 DOWNTO 0);
 SIGNAL phase : UNSIGNED(31 downto 0); -- faze inkrement
 SIGNAL phase_mod : UNSIGNED(11 downto 0);  -- faze mod
 ALIAS rom_addr : UNSIGNED(11 DOWNTO 0) IS phase (31 DOWNTO 20); -- rom adresa
 SIGNAL acumulator : UNSIGNED(31 DOWNTO 0);
 SIGNAL inkrement : UNSIGNED(23 DOWNTO 0);
 CONSTANT zero : UNSIGNED(19 DOWNTO 0) := (OTHERS => '0');
 SIGNAL nastaveni : STD_LOGIC_VECTOR(31 DOWNTO 0);
 SIGNAL sledovani : STD_LOGIC_VECTOR(31 DOWNTO 0);

 BEGIN
 
 vga_clk <= clk;
 vga_r <= data;
-- vga_g <= (OTHERS => '0');
-- vga_b <= (OTHERS => '0');
 vga_sync <= '0';
 vga_blank <= '1';
 address <= STD_LOGIC_VECTOR(acumulator (31 DOWNTO 20));
 
 i_rom: sig_rom 
 PORT MAP(
 aclr => NOT reset_n,
 address => address,
 clock => clk,
 q => data
 );

 i_sondy: sondy
 PORT MAP(
 source => nastaveni,
 probe => sledovani
 );
 sledovani <= STD_LOGIC_VECTOR(acumulator);
 inkrement <= UNSIGNED(nastaveni(23 DOWNTO 0));

 pr_gen: PROCESS (clk,reset_n)
 BEGIN
 IF reset_n = '0' THEN
 acumulator <= (OTHERS => '0');
 phase <= phase_mod & zero;
 -- inkrement <= TO_UNSIGNED(500000,24);
 ELSIF RISING_EDGE(clk) THEN
 acumulator <= acumulator + inkrement;
 phase <= acumulator + (phase_mod & zero);
 END IF;
 END PROCESS;

END ARCHITECTURE rtl; -- konec architecture a begin  