-- dss_gen.vhd

-- Generated using ACDS version 13.0sp1 232 at 2020.03.09.15:05:41

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dss_gen is
	port (
		clk_clk       : in  std_logic                    := '0'; --   clk.clk
		reset_reset_n : in  std_logic                    := '0'; -- reset.reset_n
		dds_clk       : out std_logic;                           --   dds.clk
		dds_r         : out std_logic_vector(9 downto 0);        --      .r
		dds_g         : out std_logic_vector(9 downto 0);        --      .g
		dds_sync      : out std_logic;                           --      .sync
		dds_blank     : out std_logic                            --      .blank
	);
end entity dss_gen;

architecture rtl of dss_gen is
	component dss_gen_master_0 is
		generic (
			USE_PLI     : integer := 0;
			PLI_PORT    : integer := 50000;
			FIFO_DEPTHS : integer := 2
		);
		port (
			clk_clk              : in  std_logic                     := 'X';             -- clk
			clk_reset_reset      : in  std_logic                     := 'X';             -- reset
			master_address       : out std_logic_vector(31 downto 0);                    -- address
			master_readdata      : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			master_read          : out std_logic;                                        -- read
			master_write         : out std_logic;                                        -- write
			master_writedata     : out std_logic_vector(31 downto 0);                    -- writedata
			master_waitrequest   : in  std_logic                     := 'X';             -- waitrequest
			master_readdatavalid : in  std_logic                     := 'X';             -- readdatavalid
			master_byteenable    : out std_logic_vector(3 downto 0);                     -- byteenable
			master_reset_reset   : out std_logic                                         -- reset
		);
	end component dss_gen_master_0;

	component dds_gen_avl is
		port (
			rsi_reset_n    : in  std_logic                     := 'X';             -- reset_n
			csi_clk        : in  std_logic                     := 'X';             -- clk
			avs_write      : in  std_logic                     := 'X';             -- write
			avs_write_data : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			avs_read       : in  std_logic                     := 'X';             -- read
			avs_read_data  : out std_logic_vector(31 downto 0);                    -- readdata
			avs_address    : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- address
			clk            : out std_logic;                                        -- export
			r              : out std_logic_vector(9 downto 0);                     -- export
			g              : out std_logic_vector(9 downto 0);                     -- export
			sync           : out std_logic;                                        -- export
			blank          : out std_logic                                         -- export
		);
	end component dds_gen_avl;

	component altera_merlin_master_translator is
		generic (
			AV_ADDRESS_W                : integer := 32;
			AV_DATA_W                   : integer := 32;
			AV_BURSTCOUNT_W             : integer := 4;
			AV_BYTEENABLE_W             : integer := 4;
			UAV_ADDRESS_W               : integer := 38;
			UAV_BURSTCOUNT_W            : integer := 10;
			USE_READ                    : integer := 1;
			USE_WRITE                   : integer := 1;
			USE_BEGINBURSTTRANSFER      : integer := 0;
			USE_BEGINTRANSFER           : integer := 0;
			USE_CHIPSELECT              : integer := 0;
			USE_BURSTCOUNT              : integer := 1;
			USE_READDATAVALID           : integer := 1;
			USE_WAITREQUEST             : integer := 1;
			USE_READRESPONSE            : integer := 0;
			USE_WRITERESPONSE           : integer := 0;
			AV_SYMBOLS_PER_WORD         : integer := 4;
			AV_ADDRESS_SYMBOLS          : integer := 0;
			AV_BURSTCOUNT_SYMBOLS       : integer := 0;
			AV_CONSTANT_BURST_BEHAVIOR  : integer := 0;
			UAV_CONSTANT_BURST_BEHAVIOR : integer := 0;
			AV_LINEWRAPBURSTS           : integer := 0;
			AV_REGISTERINCOMINGSIGNALS  : integer := 0
		);
		port (
			clk                      : in  std_logic                     := 'X';             -- clk
			reset                    : in  std_logic                     := 'X';             -- reset
			uav_address              : out std_logic_vector(31 downto 0);                    -- address
			uav_burstcount           : out std_logic_vector(2 downto 0);                     -- burstcount
			uav_read                 : out std_logic;                                        -- read
			uav_write                : out std_logic;                                        -- write
			uav_waitrequest          : in  std_logic                     := 'X';             -- waitrequest
			uav_readdatavalid        : in  std_logic                     := 'X';             -- readdatavalid
			uav_byteenable           : out std_logic_vector(3 downto 0);                     -- byteenable
			uav_readdata             : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			uav_writedata            : out std_logic_vector(31 downto 0);                    -- writedata
			uav_lock                 : out std_logic;                                        -- lock
			uav_debugaccess          : out std_logic;                                        -- debugaccess
			av_address               : in  std_logic_vector(31 downto 0) := (others => 'X'); -- address
			av_waitrequest           : out std_logic;                                        -- waitrequest
			av_byteenable            : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			av_read                  : in  std_logic                     := 'X';             -- read
			av_readdata              : out std_logic_vector(31 downto 0);                    -- readdata
			av_readdatavalid         : out std_logic;                                        -- readdatavalid
			av_write                 : in  std_logic                     := 'X';             -- write
			av_writedata             : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			av_burstcount            : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- burstcount
			av_beginbursttransfer    : in  std_logic                     := 'X';             -- beginbursttransfer
			av_begintransfer         : in  std_logic                     := 'X';             -- begintransfer
			av_chipselect            : in  std_logic                     := 'X';             -- chipselect
			av_lock                  : in  std_logic                     := 'X';             -- lock
			av_debugaccess           : in  std_logic                     := 'X';             -- debugaccess
			uav_clken                : out std_logic;                                        -- clken
			av_clken                 : in  std_logic                     := 'X';             -- clken
			uav_response             : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- response
			av_response              : out std_logic_vector(1 downto 0);                     -- response
			uav_writeresponserequest : out std_logic;                                        -- writeresponserequest
			uav_writeresponsevalid   : in  std_logic                     := 'X';             -- writeresponsevalid
			av_writeresponserequest  : in  std_logic                     := 'X';             -- writeresponserequest
			av_writeresponsevalid    : out std_logic                                         -- writeresponsevalid
		);
	end component altera_merlin_master_translator;

	component altera_merlin_slave_translator is
		generic (
			AV_ADDRESS_W                   : integer := 30;
			AV_DATA_W                      : integer := 32;
			UAV_DATA_W                     : integer := 32;
			AV_BURSTCOUNT_W                : integer := 4;
			AV_BYTEENABLE_W                : integer := 4;
			UAV_BYTEENABLE_W               : integer := 4;
			UAV_ADDRESS_W                  : integer := 32;
			UAV_BURSTCOUNT_W               : integer := 4;
			AV_READLATENCY                 : integer := 0;
			USE_READDATAVALID              : integer := 1;
			USE_WAITREQUEST                : integer := 1;
			USE_UAV_CLKEN                  : integer := 0;
			USE_READRESPONSE               : integer := 0;
			USE_WRITERESPONSE              : integer := 0;
			AV_SYMBOLS_PER_WORD            : integer := 4;
			AV_ADDRESS_SYMBOLS             : integer := 0;
			AV_BURSTCOUNT_SYMBOLS          : integer := 0;
			AV_CONSTANT_BURST_BEHAVIOR     : integer := 0;
			UAV_CONSTANT_BURST_BEHAVIOR    : integer := 0;
			AV_REQUIRE_UNALIGNED_ADDRESSES : integer := 0;
			CHIPSELECT_THROUGH_READLATENCY : integer := 0;
			AV_READ_WAIT_CYCLES            : integer := 0;
			AV_WRITE_WAIT_CYCLES           : integer := 0;
			AV_SETUP_WAIT_CYCLES           : integer := 0;
			AV_DATA_HOLD_CYCLES            : integer := 0
		);
		port (
			clk                      : in  std_logic                     := 'X';             -- clk
			reset                    : in  std_logic                     := 'X';             -- reset
			uav_address              : in  std_logic_vector(31 downto 0) := (others => 'X'); -- address
			uav_burstcount           : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- burstcount
			uav_read                 : in  std_logic                     := 'X';             -- read
			uav_write                : in  std_logic                     := 'X';             -- write
			uav_waitrequest          : out std_logic;                                        -- waitrequest
			uav_readdatavalid        : out std_logic;                                        -- readdatavalid
			uav_byteenable           : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			uav_readdata             : out std_logic_vector(31 downto 0);                    -- readdata
			uav_writedata            : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			uav_lock                 : in  std_logic                     := 'X';             -- lock
			uav_debugaccess          : in  std_logic                     := 'X';             -- debugaccess
			av_address               : out std_logic_vector(1 downto 0);                     -- address
			av_write                 : out std_logic;                                        -- write
			av_read                  : out std_logic;                                        -- read
			av_readdata              : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			av_writedata             : out std_logic_vector(31 downto 0);                    -- writedata
			av_begintransfer         : out std_logic;                                        -- begintransfer
			av_beginbursttransfer    : out std_logic;                                        -- beginbursttransfer
			av_burstcount            : out std_logic_vector(0 downto 0);                     -- burstcount
			av_byteenable            : out std_logic_vector(3 downto 0);                     -- byteenable
			av_readdatavalid         : in  std_logic                     := 'X';             -- readdatavalid
			av_waitrequest           : in  std_logic                     := 'X';             -- waitrequest
			av_writebyteenable       : out std_logic_vector(3 downto 0);                     -- writebyteenable
			av_lock                  : out std_logic;                                        -- lock
			av_chipselect            : out std_logic;                                        -- chipselect
			av_clken                 : out std_logic;                                        -- clken
			uav_clken                : in  std_logic                     := 'X';             -- clken
			av_debugaccess           : out std_logic;                                        -- debugaccess
			av_outputenable          : out std_logic;                                        -- outputenable
			uav_response             : out std_logic_vector(1 downto 0);                     -- response
			av_response              : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- response
			uav_writeresponserequest : in  std_logic                     := 'X';             -- writeresponserequest
			uav_writeresponsevalid   : out std_logic;                                        -- writeresponsevalid
			av_writeresponserequest  : out std_logic;                                        -- writeresponserequest
			av_writeresponsevalid    : in  std_logic                     := 'X'              -- writeresponsevalid
		);
	end component altera_merlin_slave_translator;

	signal master_0_master_waitrequest                                        : std_logic;                     -- master_0_master_translator:av_waitrequest -> master_0:master_waitrequest
	signal master_0_master_writedata                                          : std_logic_vector(31 downto 0); -- master_0:master_writedata -> master_0_master_translator:av_writedata
	signal master_0_master_address                                            : std_logic_vector(31 downto 0); -- master_0:master_address -> master_0_master_translator:av_address
	signal master_0_master_write                                              : std_logic;                     -- master_0:master_write -> master_0_master_translator:av_write
	signal master_0_master_read                                               : std_logic;                     -- master_0:master_read -> master_0_master_translator:av_read
	signal master_0_master_readdata                                           : std_logic_vector(31 downto 0); -- master_0_master_translator:av_readdata -> master_0:master_readdata
	signal master_0_master_byteenable                                         : std_logic_vector(3 downto 0);  -- master_0:master_byteenable -> master_0_master_translator:av_byteenable
	signal master_0_master_readdatavalid                                      : std_logic;                     -- master_0_master_translator:av_readdatavalid -> master_0:master_readdatavalid
	signal master_0_master_translator_avalon_universal_master_0_waitrequest   : std_logic;                     -- dds_gen_0_avalon_slave_0_translator:uav_waitrequest -> master_0_master_translator:uav_waitrequest
	signal master_0_master_translator_avalon_universal_master_0_burstcount    : std_logic_vector(2 downto 0);  -- master_0_master_translator:uav_burstcount -> dds_gen_0_avalon_slave_0_translator:uav_burstcount
	signal master_0_master_translator_avalon_universal_master_0_writedata     : std_logic_vector(31 downto 0); -- master_0_master_translator:uav_writedata -> dds_gen_0_avalon_slave_0_translator:uav_writedata
	signal master_0_master_translator_avalon_universal_master_0_address       : std_logic_vector(31 downto 0); -- master_0_master_translator:uav_address -> dds_gen_0_avalon_slave_0_translator:uav_address
	signal master_0_master_translator_avalon_universal_master_0_lock          : std_logic;                     -- master_0_master_translator:uav_lock -> dds_gen_0_avalon_slave_0_translator:uav_lock
	signal master_0_master_translator_avalon_universal_master_0_write         : std_logic;                     -- master_0_master_translator:uav_write -> dds_gen_0_avalon_slave_0_translator:uav_write
	signal master_0_master_translator_avalon_universal_master_0_read          : std_logic;                     -- master_0_master_translator:uav_read -> dds_gen_0_avalon_slave_0_translator:uav_read
	signal master_0_master_translator_avalon_universal_master_0_readdata      : std_logic_vector(31 downto 0); -- dds_gen_0_avalon_slave_0_translator:uav_readdata -> master_0_master_translator:uav_readdata
	signal master_0_master_translator_avalon_universal_master_0_debugaccess   : std_logic;                     -- master_0_master_translator:uav_debugaccess -> dds_gen_0_avalon_slave_0_translator:uav_debugaccess
	signal master_0_master_translator_avalon_universal_master_0_byteenable    : std_logic_vector(3 downto 0);  -- master_0_master_translator:uav_byteenable -> dds_gen_0_avalon_slave_0_translator:uav_byteenable
	signal master_0_master_translator_avalon_universal_master_0_readdatavalid : std_logic;                     -- dds_gen_0_avalon_slave_0_translator:uav_readdatavalid -> master_0_master_translator:uav_readdatavalid
	signal dds_gen_0_avalon_slave_0_translator_avalon_anti_slave_0_writedata  : std_logic_vector(31 downto 0); -- dds_gen_0_avalon_slave_0_translator:av_writedata -> dds_gen_0:avs_write_data
	signal dds_gen_0_avalon_slave_0_translator_avalon_anti_slave_0_address    : std_logic_vector(1 downto 0);  -- dds_gen_0_avalon_slave_0_translator:av_address -> dds_gen_0:avs_address
	signal dds_gen_0_avalon_slave_0_translator_avalon_anti_slave_0_write      : std_logic;                     -- dds_gen_0_avalon_slave_0_translator:av_write -> dds_gen_0:avs_write
	signal dds_gen_0_avalon_slave_0_translator_avalon_anti_slave_0_read       : std_logic;                     -- dds_gen_0_avalon_slave_0_translator:av_read -> dds_gen_0:avs_read
	signal dds_gen_0_avalon_slave_0_translator_avalon_anti_slave_0_readdata   : std_logic_vector(31 downto 0); -- dds_gen_0:avs_read_data -> dds_gen_0_avalon_slave_0_translator:av_readdata
	signal reset_reset_n_ports_inv                                            : std_logic;                     -- reset_reset_n:inv -> [dds_gen_0_avalon_slave_0_translator:reset, master_0:clk_reset_reset, master_0_master_translator:reset]

begin

	master_0 : component dss_gen_master_0
		generic map (
			USE_PLI     => 0,
			PLI_PORT    => 50000,
			FIFO_DEPTHS => 2
		)
		port map (
			clk_clk              => clk_clk,                       --          clk.clk
			clk_reset_reset      => reset_reset_n_ports_inv,       --    clk_reset.reset
			master_address       => master_0_master_address,       --       master.address
			master_readdata      => master_0_master_readdata,      --             .readdata
			master_read          => master_0_master_read,          --             .read
			master_write         => master_0_master_write,         --             .write
			master_writedata     => master_0_master_writedata,     --             .writedata
			master_waitrequest   => master_0_master_waitrequest,   --             .waitrequest
			master_readdatavalid => master_0_master_readdatavalid, --             .readdatavalid
			master_byteenable    => master_0_master_byteenable,    --             .byteenable
			master_reset_reset   => open                           -- master_reset.reset
		);

	dds_gen_0 : component dds_gen_avl
		port map (
			rsi_reset_n    => reset_reset_n,                                                     --          reset.reset_n
			csi_clk        => clk_clk,                                                           --          clock.clk
			avs_write      => dds_gen_0_avalon_slave_0_translator_avalon_anti_slave_0_write,     -- avalon_slave_0.write
			avs_write_data => dds_gen_0_avalon_slave_0_translator_avalon_anti_slave_0_writedata, --               .writedata
			avs_read       => dds_gen_0_avalon_slave_0_translator_avalon_anti_slave_0_read,      --               .read
			avs_read_data  => dds_gen_0_avalon_slave_0_translator_avalon_anti_slave_0_readdata,  --               .readdata
			avs_address    => dds_gen_0_avalon_slave_0_translator_avalon_anti_slave_0_address,   --               .address
			clk            => dds_clk,                                                           --    conduit_end.export
			r              => dds_r,                                                             --               .export
			g              => dds_g,                                                             --               .export
			sync           => dds_sync,                                                          --               .export
			blank          => dds_blank                                                          --               .export
		);

	master_0_master_translator : component altera_merlin_master_translator
		generic map (
			AV_ADDRESS_W                => 32,
			AV_DATA_W                   => 32,
			AV_BURSTCOUNT_W             => 1,
			AV_BYTEENABLE_W             => 4,
			UAV_ADDRESS_W               => 32,
			UAV_BURSTCOUNT_W            => 3,
			USE_READ                    => 1,
			USE_WRITE                   => 1,
			USE_BEGINBURSTTRANSFER      => 0,
			USE_BEGINTRANSFER           => 0,
			USE_CHIPSELECT              => 0,
			USE_BURSTCOUNT              => 0,
			USE_READDATAVALID           => 1,
			USE_WAITREQUEST             => 1,
			USE_READRESPONSE            => 0,
			USE_WRITERESPONSE           => 0,
			AV_SYMBOLS_PER_WORD         => 4,
			AV_ADDRESS_SYMBOLS          => 1,
			AV_BURSTCOUNT_SYMBOLS       => 0,
			AV_CONSTANT_BURST_BEHAVIOR  => 0,
			UAV_CONSTANT_BURST_BEHAVIOR => 0,
			AV_LINEWRAPBURSTS           => 0,
			AV_REGISTERINCOMINGSIGNALS  => 0
		)
		port map (
			clk                      => clk_clk,                                                            --                       clk.clk
			reset                    => reset_reset_n_ports_inv,                                            --                     reset.reset
			uav_address              => master_0_master_translator_avalon_universal_master_0_address,       -- avalon_universal_master_0.address
			uav_burstcount           => master_0_master_translator_avalon_universal_master_0_burstcount,    --                          .burstcount
			uav_read                 => master_0_master_translator_avalon_universal_master_0_read,          --                          .read
			uav_write                => master_0_master_translator_avalon_universal_master_0_write,         --                          .write
			uav_waitrequest          => master_0_master_translator_avalon_universal_master_0_waitrequest,   --                          .waitrequest
			uav_readdatavalid        => master_0_master_translator_avalon_universal_master_0_readdatavalid, --                          .readdatavalid
			uav_byteenable           => master_0_master_translator_avalon_universal_master_0_byteenable,    --                          .byteenable
			uav_readdata             => master_0_master_translator_avalon_universal_master_0_readdata,      --                          .readdata
			uav_writedata            => master_0_master_translator_avalon_universal_master_0_writedata,     --                          .writedata
			uav_lock                 => master_0_master_translator_avalon_universal_master_0_lock,          --                          .lock
			uav_debugaccess          => master_0_master_translator_avalon_universal_master_0_debugaccess,   --                          .debugaccess
			av_address               => master_0_master_address,                                            --      avalon_anti_master_0.address
			av_waitrequest           => master_0_master_waitrequest,                                        --                          .waitrequest
			av_byteenable            => master_0_master_byteenable,                                         --                          .byteenable
			av_read                  => master_0_master_read,                                               --                          .read
			av_readdata              => master_0_master_readdata,                                           --                          .readdata
			av_readdatavalid         => master_0_master_readdatavalid,                                      --                          .readdatavalid
			av_write                 => master_0_master_write,                                              --                          .write
			av_writedata             => master_0_master_writedata,                                          --                          .writedata
			av_burstcount            => "1",                                                                --               (terminated)
			av_beginbursttransfer    => '0',                                                                --               (terminated)
			av_begintransfer         => '0',                                                                --               (terminated)
			av_chipselect            => '0',                                                                --               (terminated)
			av_lock                  => '0',                                                                --               (terminated)
			av_debugaccess           => '0',                                                                --               (terminated)
			uav_clken                => open,                                                               --               (terminated)
			av_clken                 => '1',                                                                --               (terminated)
			uav_response             => "00",                                                               --               (terminated)
			av_response              => open,                                                               --               (terminated)
			uav_writeresponserequest => open,                                                               --               (terminated)
			uav_writeresponsevalid   => '0',                                                                --               (terminated)
			av_writeresponserequest  => '0',                                                                --               (terminated)
			av_writeresponsevalid    => open                                                                --               (terminated)
		);

	dds_gen_0_avalon_slave_0_translator : component altera_merlin_slave_translator
		generic map (
			AV_ADDRESS_W                   => 2,
			AV_DATA_W                      => 32,
			UAV_DATA_W                     => 32,
			AV_BURSTCOUNT_W                => 1,
			AV_BYTEENABLE_W                => 4,
			UAV_BYTEENABLE_W               => 4,
			UAV_ADDRESS_W                  => 32,
			UAV_BURSTCOUNT_W               => 3,
			AV_READLATENCY                 => 0,
			USE_READDATAVALID              => 0,
			USE_WAITREQUEST                => 0,
			USE_UAV_CLKEN                  => 0,
			USE_READRESPONSE               => 0,
			USE_WRITERESPONSE              => 0,
			AV_SYMBOLS_PER_WORD            => 4,
			AV_ADDRESS_SYMBOLS             => 0,
			AV_BURSTCOUNT_SYMBOLS          => 0,
			AV_CONSTANT_BURST_BEHAVIOR     => 0,
			UAV_CONSTANT_BURST_BEHAVIOR    => 0,
			AV_REQUIRE_UNALIGNED_ADDRESSES => 0,
			CHIPSELECT_THROUGH_READLATENCY => 0,
			AV_READ_WAIT_CYCLES            => 1,
			AV_WRITE_WAIT_CYCLES           => 0,
			AV_SETUP_WAIT_CYCLES           => 0,
			AV_DATA_HOLD_CYCLES            => 0
		)
		port map (
			clk                      => clk_clk,                                                            --                      clk.clk
			reset                    => reset_reset_n_ports_inv,                                            --                    reset.reset
			uav_address              => master_0_master_translator_avalon_universal_master_0_address,       -- avalon_universal_slave_0.address
			uav_burstcount           => master_0_master_translator_avalon_universal_master_0_burstcount,    --                         .burstcount
			uav_read                 => master_0_master_translator_avalon_universal_master_0_read,          --                         .read
			uav_write                => master_0_master_translator_avalon_universal_master_0_write,         --                         .write
			uav_waitrequest          => master_0_master_translator_avalon_universal_master_0_waitrequest,   --                         .waitrequest
			uav_readdatavalid        => master_0_master_translator_avalon_universal_master_0_readdatavalid, --                         .readdatavalid
			uav_byteenable           => master_0_master_translator_avalon_universal_master_0_byteenable,    --                         .byteenable
			uav_readdata             => master_0_master_translator_avalon_universal_master_0_readdata,      --                         .readdata
			uav_writedata            => master_0_master_translator_avalon_universal_master_0_writedata,     --                         .writedata
			uav_lock                 => master_0_master_translator_avalon_universal_master_0_lock,          --                         .lock
			uav_debugaccess          => master_0_master_translator_avalon_universal_master_0_debugaccess,   --                         .debugaccess
			av_address               => dds_gen_0_avalon_slave_0_translator_avalon_anti_slave_0_address,    --      avalon_anti_slave_0.address
			av_write                 => dds_gen_0_avalon_slave_0_translator_avalon_anti_slave_0_write,      --                         .write
			av_read                  => dds_gen_0_avalon_slave_0_translator_avalon_anti_slave_0_read,       --                         .read
			av_readdata              => dds_gen_0_avalon_slave_0_translator_avalon_anti_slave_0_readdata,   --                         .readdata
			av_writedata             => dds_gen_0_avalon_slave_0_translator_avalon_anti_slave_0_writedata,  --                         .writedata
			av_begintransfer         => open,                                                               --              (terminated)
			av_beginbursttransfer    => open,                                                               --              (terminated)
			av_burstcount            => open,                                                               --              (terminated)
			av_byteenable            => open,                                                               --              (terminated)
			av_readdatavalid         => '0',                                                                --              (terminated)
			av_waitrequest           => '0',                                                                --              (terminated)
			av_writebyteenable       => open,                                                               --              (terminated)
			av_lock                  => open,                                                               --              (terminated)
			av_chipselect            => open,                                                               --              (terminated)
			av_clken                 => open,                                                               --              (terminated)
			uav_clken                => '0',                                                                --              (terminated)
			av_debugaccess           => open,                                                               --              (terminated)
			av_outputenable          => open,                                                               --              (terminated)
			uav_response             => open,                                                               --              (terminated)
			av_response              => "00",                                                               --              (terminated)
			uav_writeresponserequest => '0',                                                                --              (terminated)
			uav_writeresponsevalid   => open,                                                               --              (terminated)
			av_writeresponserequest  => open,                                                               --              (terminated)
			av_writeresponsevalid    => '0'                                                                 --              (terminated)
		);

	reset_reset_n_ports_inv <= not reset_reset_n;

end architecture rtl; -- of dss_gen