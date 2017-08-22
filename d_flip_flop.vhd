library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--Entity for D flip flop
--Transmits D input to Q on rising clock edge
entity d_flip_flop is
	port( D, clk : in std_logic;
		  Q : out std_logic );
end d_flip_flop;

architecture behavioral of d_flip_flop is
	begin
	process(clk)
	begin
		if(rising_edge(clk)) then   --propagate D to Q on rising edge
			Q <= D;
		end if;
	end process;
end behavioral;