library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity heading_register is
   Port ( clk, reset, inside_draw : in std_logic;
          heading_in: in std_logic_vector(2 downto 0);
          heading_out : out std_logic_vector(2 downto 0) );
end heading_register;

architecture Behavioral of heading_register is

	shared variable heading : std_logic_vector(2 downto 0); 

	begin
	
	reg_process : process(clk, reset, inside_draw)
	begin
		if(reset = '1') then
			heading := "000";
		elsif(rising_edge(clk)) then
			heading := heading_in;
			if(inside_draw = '0') then    --not currently drawing ship, can change heading
				heading_out <= heading;
			end if;
		else
			heading := heading;
		end if;
	end process;
	
end Behavioral;