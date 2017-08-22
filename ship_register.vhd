library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity ship_register is
   Port ( clk, reset, inside_draw, data_ready : in std_logic;
          shipXin, shipYin : in std_logic_vector(9 downto 0);
          shipX, shipY : out std_logic_vector(9 downto 0) );
end ship_register;

architecture Behavioral of ship_register is

	shared variable varx : std_logic_vector(9 downto 0); -- := CONV_STD_LOGIC_VECTOR(320, 10); 
	shared variable vary : std_logic_vector(9 downto 0); --:= CONV_STD_LOGIC_VECTOR(240, 10);

	shared variable curx : std_logic_vector(9 downto 0); --:= CONV_STD_LOGIC_VECTOR(320, 10);
	shared variable cury : std_logic_vector(9 downto 0); --:= CONV_STD_LOGIC_VECTOR(240, 10);

	begin
	
	reg_process : process(clk, reset, inside_draw)
	begin
		if(reset = '1') then
			varx := CONV_STD_LOGIC_VECTOR(320, 10); 
			vary := CONV_STD_LOGIC_VECTOR(240, 10);
			curx := CONV_STD_LOGIC_VECTOR(320, 10); 
			cury := CONV_STD_LOGIC_VECTOR(240, 10);
			shipX <= varx;
			shipY <= vary;
		elsif(rising_edge(clk)) then
			if(data_ready = '1') then
				varx := shipXin;
				vary := shipYin;
				curx := curx;
				cury := cury;
			else
				varx := varx;
				vary := vary;
				curx := curx;
				cury := cury;
			end if;
			
			if(inside_draw = '0') then    --not currently drawing ship, can change position
				shipX <= varx;
				shipY <= vary;
				curx := varx;
				cury := vary;
			else
				curx := curx;
				cury := cury;
				shipX <= curx;
				shipY <= cury;
			end if;
		
		else
			varx := varx;
			vary := vary;
			curx := curx;
			cury := cury;
		end if;
		
	end process;
	
end Behavioral;