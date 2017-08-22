library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity keyboard_filter is
   Port ( clk, reset, scancode_ready : in std_logic;
          scancode_in : in std_logic_vector(7 downto 0);
          scancode_out : out std_logic_vector(7 downto 0);
          pass_out : out std_logic );
end keyboard_filter;

architecture Behavioral of keyboard_filter is

	shared variable pass : std_logic;

	begin
	
	filter_process : process(clk)
	begin
		if(reset = '1') then
			pass := '1';
		elsif(rising_edge(clk)) then
			if(scancode_ready = '1') then
				if(scancode_in = "11110000") then  --F0
					pass := '0';
					scancode_out <= "00000000";
				else
					if(pass = '1') then
						scancode_out <= scancode_in;
						pass := '1';
					else
						scancode_out <= "00000000";
						pass := '1';
					end if;
				end if;
			end if;
		end if;
		pass_out <= pass;
	end process;
	
end Behavioral;