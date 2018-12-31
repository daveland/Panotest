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
signal clk100mhz: std_logic;
signal clk200mhz: std_logic;
signal SYSRST:std_logic;

component pll2
port
 (-- Clock in ports
  CLK_IN1           : in     std_logic;
  -- Clock out ports
  CLK_OUT1          : out    std_logic;
  CLK_OUT2          : out    std_logic;
  -- Status and control signals
  RESET             : in     std_logic;
  LOCKED            : out    std_logic
 );
end component;


begin

clockpll : pll2
  port map
   (-- Clock in ports
    CLK_IN1 => osc_clk,
    -- Clock out ports
    CLK_OUT1 => clk100mhz,
    CLK_OUT2 => Clk200mhz,
    -- Status and control signals
    RESET  => '0',
    LOCKED => locked);



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
			
led_red <= counter_output(25);
led_blue <=  counter_output(24);
led_green <= counter_output(26);

--RESET_OUT_N <='1';


-- clock in SYSRST_N and create SYSRST
-- wait for pll to lock 
process(clk100mhz, SYSRST_N,locked)
    begin
	if SYSRST_N = '0' then
 	    SYSRST <= '1' ;
		 RESET_OUT_N <= '0';
	elsif clk100mhz'event and clk100mhz = '1' and locked ='1' then
		SYSRST <='0';
		 RESET_OUT_N <= '1';
	end if;
 end process;	

end Behavioral;

