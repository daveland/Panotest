-------------------------------------------------------------------------------
-- cpu1_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity cpu1_stub is
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
end cpu1_stub;

architecture STRUCTURE of cpu1_stub is

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

  attribute BUFFER_TYPE : STRING;
 attribute BOX_TYPE : STRING;
  attribute BUFFER_TYPE of Generic_EMAC_TX_CLK : signal is "IBUF";
  attribute BUFFER_TYPE of Generic_EMAC_RX_CLK : signal is "IBUF";
 attribute BOX_TYPE of cpu1 : component is "user_black_box";

begin

  cpu1_i : cpu1
    port map (
      RS232_Uart_1_sout => RS232_Uart_1_sout,
      RS232_Uart_1_sin => RS232_Uart_1_sin,
      RESET => RESET,
      Generic_GPIO_TRI_IO => Generic_GPIO_TRI_IO,
      Generic_EMAC_TX_ER => Generic_EMAC_TX_ER,
      Generic_EMAC_TX_EN => Generic_EMAC_TX_EN,
      Generic_EMAC_TX_CLK => Generic_EMAC_TX_CLK,
      Generic_EMAC_TXD => Generic_EMAC_TXD,
      Generic_EMAC_RX_ER => Generic_EMAC_RX_ER,
      Generic_EMAC_RX_DV => Generic_EMAC_RX_DV,
      Generic_EMAC_RX_CLK => Generic_EMAC_RX_CLK,
      Generic_EMAC_RXD => Generic_EMAC_RXD,
      Generic_EMAC_PHY_RST_N => Generic_EMAC_PHY_RST_N,
      Generic_EMAC_MDIO => Generic_EMAC_MDIO,
      Generic_EMAC_MDC => Generic_EMAC_MDC,
      Generic_EMAC_CRS => Generic_EMAC_CRS,
      Generic_EMAC_COL => Generic_EMAC_COL,
      CLK_P => CLK_P,
      CLK_N => CLK_N
    );

end architecture STRUCTURE;

