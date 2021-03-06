----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:07:45 04/15/2014 
-- Design Name: 
-- Module Name:    address_gen - Behavioral 
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity address_gen is
    Port ( clk : in  STD_LOGIC;
           start : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           address : out  STD_LOGIC_VECTOR (11 downto 0);
           full_flag : out  STD_LOGIC);
end address_gen;

architecture Behavioral of address_gen is
signal addr : std_logic_vector (11 downto 0) := "000000000000";
begin
		
	address_gen : process (clk,start,rst)
	begin
		if rst = '1' then
			addr <= "000000000000";
			full_flag <= '0';
		else
		if rising_edge(clk) then
			case start is
				--when '0' => addr <= "000000000000";
				when '1' => case we is
									when '1' => if addr < "111111111111" then
														addr <= addr + 1;
														full_flag <= '0';
													else
														addr <= "000000000000";
														full_flag <= '1';
													end if;
									when '0' => if addr < "111111111111" then
														addr <= addr + 1;
														full_flag <= '1';
													else
														addr <= "000000000000";
														full_flag <= '0';
													end if;
									when others => full_flag <= '0';
								end case;
				when others => null;
			end case;
			
			end if;
			
			--case rst is
			--	when '1' => addr <= "000000000000";
			--					full_flag <= '0';
			--	when '0' => null;
			--	when others => null;
			--end case;
			
			address <= addr;
		end if;
	end process;

end Behavioral;

