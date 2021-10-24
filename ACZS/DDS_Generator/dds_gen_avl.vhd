LIBRARY ieee; -- obrovská knihovna

USE ieee.std_logic_1164.ALL; --  balík z knihovny (singály, logické operátory, vektroy..)
USE ieee.numeric_std.ALL; -- balík z knihovny (pokud potrebujeme po?ítat)

ENTITY dds_gen_avl IS 
PORT
(
  rsi_reset_n : IN STD_LOGIC;
  csi_clk : IN STD_LOGIC;
  avs_write : IN STD_LOGIC;
  avs_write_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  avs_read : IN STD_LOGIC;
  avs_read_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
  avs_address : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
  ---------------------------
  clk : OUT STD_LOGIC;
  r : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  g : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  sync : OUT STD_LOGIC;
  blank : OUT STD_LOGIC

);

END dds_gen_avl; 

ARCHITECTURE rtl OF dds_gen_avl IS  

COMPONENT sig_rom
PORT
	(
		aclr		: IN STD_LOGIC  := '0';
		address		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dds_logic
GENERIC(
akumulator_sirka : POSITIVE := 32;
rozliseni_sirka : POSITIVE := 12;
faze_sirka : POSITIVE := 12
);
PORT
(
  clk : IN STD_LOGIC;
  reset_n : IN STD_LOGIC := '1';
  clk_enable : IN STD_LOGIC;
  faze_inkrement : IN UNSIGNED(akumulator_sirka-1 DOWNTO 0);
  faze_mod : IN UNSIGNED(faze_sirka-1 DOWNTO 0);
  rom_adresa : OUT STD_LOGIC_VECTOR(rozliseni_sirka-1 DOWNTO 0)
);
END COMPONENT;

  SIGNAL s_reset : STD_LOGIC;
  SIGNAL s_faze1_inkrement : UNSIGNED(31 DOWNTO 0);
  SIGNAL s_faze2_inkrement : UNSIGNED(31 DOWNTO 0);
  SIGNAL s_faze1_posun : UNSIGNED(11 DOWNTO 0);
  SIGNAL s_faze2_posun : UNSIGNED(11 DOWNTO 0);
  SIGNAL s_adresa_dds1: STD_LOGIC_VECTOR(11 DOWNTO 0);
  SIGNAL s_adresa_dds2: STD_LOGIC_VECTOR(11 DOWNTO 0);
  SIGNAL s_data_dds1 : STD_LOGIC_VECTOR(9 DOWNTO 0); 
  SIGNAL s_data_dds2 : STD_LOGIC_VECTOR(9 DOWNTO 0);

BEGIN

 rom_1: sig_rom 
 PORT MAP(
 aclr => NOT s_reset,
 address => s_adresa_dds1,
 clock => csi_clk,
 q => s_data_dds1
 );

 rom_2: sig_rom 
 PORT MAP(
 aclr => NOT s_reset,
 address => s_adresa_dds2,
 clock => csi_clk,
 q => s_data_dds2
 );
 
 dds_1: dds_logic
 GENERIC MAP(
akumulator_sirka => 32,
rozliseni_sirka => 12,
faze_sirka => 12
)
 PORT MAP(
  clk => csi_clk,
  reset_n => s_reset, 
  clk_enable => '1',
  faze_inkrement => s_faze1_inkrement, 
  faze_mod => s_faze1_posun, 
  rom_adresa => s_adresa_dds1
 );
 
 
 dds_2: dds_logic
  GENERIC MAP(
akumulator_sirka => 32,
rozliseni_sirka => 12,
faze_sirka => 12
)
 PORT MAP(
  clk => csi_clk,
  reset_n => s_reset, 
  clk_enable => '1',
  faze_inkrement => s_faze2_inkrement, 
  faze_mod => s_faze2_posun, 
  rom_adresa => s_adresa_dds2
 );

 s_reset <= rsi_reset_n;

PROCESS (csi_clk, s_reset)
  BEGIN
    IF s_reset = '0' THEN
      s_faze1_inkrement <= (OTHERS => '0');
      s_faze1_posun <= (OTHERS => '0');
      s_faze2_inkrement <= (OTHERS => '0');
      s_faze2_posun <= (OTHERS => '0');
    ELSIF (rising_edge(csi_clk))THEN
      IF (avs_write = '1') THEN
      IF (avs_address = "00") THEN
      s_faze1_inkrement <= unsigned(avs_write_data(31 DOWNTO 0));
      ELSIF (avs_address = "01") THEN
      s_faze1_posun <= unsigned(avs_write_data(11 DOWNTO 0));      
      ELSIF (avs_address = "10") THEN
      s_faze2_inkrement <= unsigned(avs_write_data(31 DOWNTO 0));      
      ELSIF (avs_address = "11") THEN
      s_faze2_posun <= unsigned(avs_write_data(11 DOWNTO 0));      
      END IF;
      END IF;
    END IF;
  END PROCESS;

  -- avalon bus read
  PROCESS (csi_clk, s_reset)
  BEGIN
    IF s_reset = '0' THEN
      avs_read_data <= (OTHERS => '0');
    ELSIF (rising_edge(csi_clk))THEN
      IF (avs_read = '1')THEN
      IF (avs_address = "00") THEN
      avs_read_data <= STD_LOGIC_VECTOR(s_faze1_inkrement);
      ELSIF (avs_address = "01") THEN
      avs_read_data <= X"00000" & STD_LOGIC_VECTOR(s_faze1_posun);
      ELSIF (avs_address = "10") THEN 
      avs_read_data <= STD_LOGIC_VECTOR(s_faze2_inkrement);
      ELSIF (avs_address = "11") THEN 
      avs_read_data <= X"00000" & STD_LOGIC_VECTOR(s_faze2_posun);
      END IF;
      END IF;
    END IF;
  END PROCESS;
  
  g <= s_data_dds1(9 DOWNTO 0);
  r <= s_data_dds2(9 DOWNTO 0);
  clk <= csi_clk;
  sync <= '0';
  blank <= '1';
     
END ARCHITECTURE rtl; -- konec architecture a begin  
