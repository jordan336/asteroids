library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity to store 11 bits of data sent from keyboard
entity scan_register is
	port(din, edge, clk, reset_scancode, reset : in std_logic;
		 contents : out std_logic_vector(10 downto 0) );
end scan_register;

architecture behavioral of scan_register is 
	shared variable reg_value : std_logic_vector(10 downto 0);
	
	begin

	reg_process : process(clk, reset, reset_scancode)
	begin
		if(reset = '1') then
			reg_value := "00000000000";
		elsif(reset_scancode = '1') then     --reset contents after scancode processed
			reg_value := "00000000000";
		elsif(rising_edge(clk)) then
			--if(reset_scancode = '1') then     --reset contents after scancode processed
				--reg_value := "00000000000";
			if(edge = '1') then 
				reg_value := din & reg_value(10 downto 1);  --shift in new data bit
			else 
				reg_value := reg_value;   --no action
			end if;
		end if;
	end process;
	contents <= reg_value;   --output current register contents

end behavioral;