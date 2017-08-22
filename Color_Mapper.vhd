library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity Color_Mapper is
   Port ( hudR, hudG, hudB : in std_logic_vector(9 downto 0);
          hudOn : in std_logic;
          clk, reset : in std_logic;
          MissileR, MissileG, MissileB     : in std_logic_vector(9 downto 0);
          ShipR, ShipG, ShipB              : in std_logic_vector(9 downto 0);
          AsteroidR, AsteroidG, AsteroidB  : in std_logic_vector(9 downto 0);
          missile_on, asteroid_on, ship_on : in std_logic;
          Red   : out std_logic_vector(9 downto 0);
          Green : out std_logic_vector(9 downto 0);
          Blue  : out std_logic_vector(9 downto 0) );
end Color_Mapper;

architecture Behavioral of Color_Mapper is

begin

  RGB_Display : process(ship_on, missile_on, asteroid_on, MissileR, MissileG, MissileB, AsteroidR, AsteroidG, AsteroidB, ShipR, ShipG, ShipB, hudR, hudG, hudB, hudOn)
  begin
		if(hudOn = '1') then
		  Red   <= hudR;
		  Green <= hudG;
		  Blue  <= hudB; 
		elsif(ship_on = '1') then          --ship
		  Red   <= ShipR;
		  Green <= ShipG;
		  Blue  <= ShipB; 
		elsif(missile_on = '1') then     --missile
		  Red   <= MissileR;
		  Green <= MissileG;
		  Blue  <= MissileB; 
		 elsif(asteroid_on = '1') then   --asteroid
		  Red   <= AsteroidR;
		  Green <= AsteroidG;
		  Blue  <= AsteroidB; 
		else                             --background
		  Red   <= "0000000000";
		  Green <= "0000000000";
		  Blue  <= "0000000000";
		end if;
  end process RGB_Display;

end Behavioral;
