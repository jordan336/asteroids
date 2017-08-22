library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library asteroids;
use asteroids.types.all;

-- astsile entity
entity ship_draw is
   Port ( reset  : in std_logic;
		  clk    : in std_logic;
		  drawX  : in std_logic_vector(9 downto 0);
		  drawY  : in std_logic_vector(9 downto 0);
		  shipX  : in std_logic_vector(9 downto 0);
		  shipY  : in std_logic_vector(9 downto 0);
		  shipHeading : in std_logic_vector(2 downto 0);
		  spriteData  : in std_logic_vector(31 downto 0);
		  spriteAddrs : out std_logic_vector(7 downto 0);
		  shipOn      : out std_logic;
		  shipRed     : out std_logic_vector(9 downto 0);
		  shipGreen   : out std_logic_vector(9 downto 0);
		  shipBlue    : out std_logic_vector(9 downto 0)  );
end ship_draw;
	
architecture Behavioral of ship_draw is

begin

	draw : process(clk, reset)
		variable data : std_logic;
		variable sub  : std_logic_vector(9 downto 0);
	begin
		if(reset = '1') then
			shipOn <= '0';
			shipRed   <= "0000000000";
			shipGreen <= "0000000000";
			shipBlue  <= "0000000000";
			spriteAddrs <= "00000000";
		elsif(rising_edge(clk)) then
			if(drawX = shipX-1 and drawY >= shipY and drawY <= shipY + 31) then
				spriteAddrs <= shipHeading & conv_std_logic_vector(conv_integer(drawY - shipY), 5); 
			elsif(drawX >= shipX and drawX <= shipX + 31 and drawY >= shipY and drawY <= shipY + 31) then   --shipX >= drawX and shipX <= drawX+31 and shipY >= drawY and shipY <= drawY+31) then
				sub  := drawX - shipX;
				data := spriteData(conv_integer(sub));
				if(data = '1') then
					shipRed   <= "1111111111";
					shipGreen <= "1111111111";
					shipBlue  <= "1111111111";
				else
					shipRed   <= "0000000000";
					shipGreen <= "0000000000";
					shipBlue  <= "0000000000";
				end if;
				shipOn <= '1';
			else
				spriteAddrs <= "00000000";
				shipOn <= '0';
			end if;
		end if;
	end process;
	
end Behavioral;
