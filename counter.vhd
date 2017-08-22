library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--Counter entity for slowing internal clock
--Looks for 511 clock pulses to output one new pulse
entity counter is
	port( clk, reset  : in std_logic;
		  pulse : out std_logic );
end counter;

architecture behavioral of counter is
	signal count : std_logic_vector(5 downto 0);   --current counter value
	signal int_pulse : std_logic;
	
	begin
	
	process(clk, reset)
	begin
		if(reset = '1') then    --asynchronous reset
			count <= "000000";
		elsif(rising_edge(clk)) then
			if(count = "111111") then    --found 511 pulses
				count <= "000000";
				int_pulse <= int_pulse XOR '1';   --flip clock
			else
				count <= count + "000001";   --normal increment
			end if;
		end if;
	end process;
	pulse <= int_pulse;
		
end behavioral;