----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:59:27 12/09/2018 
-- Design Name: 
-- Module Name:    toplevel - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use work.utils_pack.all;

entity toplevel is
    Port (  osc_clk : in STD_LOGIC ;
				led_red : out  STD_LOGIC;
           led_blue : out  STD_LOGIC;
			  led_green : out STD_LOGIC;
           pano_button : in  STD_LOGIC;
			  SYSRST_N : in STD_LOGIC;
			  RESET_OUT_N : OUT STD_LOGIC);
end toplevel;




architecture Behavioral of toplevel is

signal  counter_output : std_logic_vector(47 downto 0);
signal  locked : std_logic;
signal clk100mhzP: std_logic;
signal clk100mhzN: std_logic;
signal clk100mhz: std_logic;
signal clkfb : std_logic;
signal SYSRST:std_logic;


signal RS232_Uart_1_sout : std_logic;
signal RS232_Uart_1_sin : std_logic;
signal cpugpio : std_logic_vector(3 downto 0);

signal Generic_EMAC_TX_ER :std_logic;
signal Generic_EMAC_TX_EN:std_logic;
signal Generic_EMAC_TX_CLK:std_logic;
signal Generic_EMAC_TXD:std_logic_vector(3 downto 0);
signal Generic_EMAC_RX_ER:std_logic;
signal Generic_EMAC_RX_DV:std_logic;
signal Generic_EMAC_RX_CLK:std_logic;
signal Generic_EMAC_RXD:std_logic_vector (3 downto 0);
signal Generic_EMAC_PHY_RST_N:std_logic;
signal Generic_EMAC_MDIO:std_logic;
signal Generic_EMAC_MDC:std_logic;
signal Generic_EMAC_CRS:std_logic;
signal Generic_EMAC_COL:std_logic;

component pll2
port
 (-- Clock in ports
  CLK_IN1           : in     std_logic;
  CLKFB_IN          : in     std_logic;
  -- Clock out ports
  CLK_OUT1          : out    std_logic;
  CLK_OUT2          : out    std_logic;
  CLK_OUT3          : out    std_logic;
  CLKFB_OUT         : out    std_logic;
  -- Status and control signals
  RESET             : in     std_logic;
  LOCKED            : out    std_logic
 );
end component;

 component cpu1 is
    port (
      RS232_Uart_1_sout : out std_logic;
      RS232_Uart_1_sin : in std_logic;
      RESET : in std_logic;
      Generic_GPIO_TRI_IO : inout std_logic_vector(0 to 3);
      Generic_EMAC_TX_ER : out std_logic;
      Generic_EMAC_TX_EN : out std_logic;
      Generic_EMAC_TX_CLK : in std_logic;
      Generic_EMAC_TXD : out std_logic_vector(3 downto 0);
      Generic_EMAC_RX_ER : in std_logic;
      Generic_EMAC_RX_DV : in std_logic;
      Generic_EMAC_RX_CLK : in std_logic;
      Generic_EMAC_RXD : in std_logic_vector(3 downto 0);
      Generic_EMAC_PHY_RST_N : out std_logic;
      Generic_EMAC_MDIO : inout std_logic;
      Generic_EMAC_MDC : out std_logic;
      Generic_EMAC_CRS : in std_logic;
      Generic_EMAC_COL : in std_logic;
      CLK_P : in std_logic;
      CLK_N : in std_logic
    );
  end component;

begin

clockpll : pll2
  port map
   (-- Clock in ports
    CLK_IN1 => osc_clk,
	  CLKFB_IN => clkfb,
    -- Clock out ports
    CLK_OUT1 => clk100mhzP,
    CLK_OUT2 => Clk100mhzN,
	 CLK_OUT3 => clk100mhz,
	  CLKFB_OUT => clkfb,
    -- Status and control signals
    RESET  => '0',
    LOCKED => locked);



-- cpu : cpu1
--    port map (
--      RS232_Uart_1_sout => RS232_Uart_1_sout,
--      RS232_Uart_1_sin => RS232_Uart_1_sin,
--      RESET => '0',
--      Generic_GPIO_TRI_IO => cpugpio,
--      Generic_EMAC_TX_ER => Generic_EMAC_TX_ER,
--      Generic_EMAC_TX_EN => Generic_EMAC_TX_EN,
--      Generic_EMAC_TX_CLK => Generic_EMAC_TX_CLK,
--      Generic_EMAC_TXD => Generic_EMAC_TXD,
--      Generic_EMAC_RX_ER => Generic_EMAC_RX_ER,
--      Generic_EMAC_RX_DV => Generic_EMAC_RX_DV,
--      Generic_EMAC_RX_CLK => Generic_EMAC_RX_CLK,
--      Generic_EMAC_RXD => Generic_EMAC_RXD,
--      Generic_EMAC_PHY_RST_N => Generic_EMAC_PHY_RST_N,
--      Generic_EMAC_MDIO => Generic_EMAC_MDIO,
--      Generic_EMAC_MDC => Generic_EMAC_MDC,
--      Generic_EMAC_CRS => Generic_EMAC_CRS,
--      Generic_EMAC_COL => Generic_EMAC_COL,
--      CLK_P => clk100mhzP,
--      CLK_N => clk100mhzN
--    );


divider : simple_counter
	generic map(NBIT =>48)
	port map(
			clk => clk100mhz,
			resetn => '1',
			sraz => '0',
			en => '1',
			load => '0',
			E => "000000000000000000000000000000000000000000000000" ,
			Q => counter_output
			);
			
led_red <= counter_output(26);
led_blue <=  counter_output(25);
led_green <= counter_output(27);

RESET_OUT_N <='1';


---- clock in SYSRST_N and create SYSRST
--process(clk100mhzP, SYSRST_N)
--    begin
--	if SYSRST_N = '0' then
-- 	    SYSRST <= '1' ;
--		 RESET_OUT_N <= '0';
--	elsif clk100mhzP'event and clk100mhzP = '1' then
--		SYSRST <='0';
--		 RESET_OUT_N <= '1';
--	end if;
-- end process;	

end Behavioral;

