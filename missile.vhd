library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library asteroids;
use asteroids.types.all;

-- missile entity
entity missile is
   Port ( reset  : in std_logic;
		  clk : in std_logic;
		  drawX : in std_logic_vector(9 downto 0);
		  drawY : in std_logic_vector(9 downto 0);
		  shipX : in std_logic_vector(9 downto 0);
		  shipY : in std_logic_vector(9 downto 0);
		  shipHeading : in std_logic_vector(2 downto 0);
		  misCollided : in std_logic_vector(2 downto 0);
		  collide     : in std_logic;
		  missile_ready : in std_logic;
		  missile_on : out std_logic;
		  missileRed : out std_logic_vector(9 downto 0);
		  missileGreen : out std_logic_vector(9 downto 0);
		  missileBlue : out std_logic_vector(9 downto 0);
		  mactive : out misactivetype;
		  missile_clear : out std_logic;
		  mpos0 : out mispossingletype;
		  mpos1 : out mispossingletype;
		  mpos2 : out mispossingletype;
		  mpos3 : out mispossingletype;
		  mpos4 : out mispossingletype;
		  mpos5 : out mispossingletype;
		  mpos6 : out mispossingletype;
		  mpos7 : out mispossingletype    );
end missile;
	
architecture Behavioral of missile is

constant x_center : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(320, 10);  --Center position on the X axis
constant y_center : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(240, 10);  --Center position on the Y axis

constant x_min    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(0, 10);    --Leftmost point on the X axis
constant x_max    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(639, 10);  --Rightmost point on the X axis
constant y_min    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(0, 10);    --Topmost point on the Y axis
constant y_max    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(479, 10);  --Bottommost point on the Y axis
                              
constant x_step   : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(1, 10);    --Step size on the X axis
constant y_step   : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(1, 10);    --Step size on the Y axis

shared variable mispos : mispostype;
shared variable mishead : misheadtype;
shared variable misactive : misactivetype;
shared variable count : integer := 0;
shared variable clk_count : std_logic_vector(17 downto 0);

begin		
	missile_action : process(clk, reset, misCollided, collide)
	variable mp : integer;
	begin
		if(reset = '1') then
			count := 0;
			mp := 0;
			clk_count := "000000000000000000";
			missile_clear <= '0';
			for mis in 0 to 7 loop
				mispos(mis, 0) := "0000000000";
				mispos(mis, 1) := "0000000000";
				mishead(mis)   := "000";
				misactive(mis) := '0';
			end loop;
		elsif(rising_edge(clk)) then
			if(collide = '1') then
				misactive(conv_integer(misCollided)) := '0';
				count := count - 1;
			elsif(missile_ready = '1') then
				if(count <= 7) then
					if(misactive(0) = '0') then
						mp := 0;
					elsif(misactive(1) = '0') then
						mp := 1;
					elsif(misactive(2) = '0') then
						mp := 2;
					elsif(misactive(3) = '0') then
						mp := 3;
					elsif(misactive(4) = '0') then
						mp := 4;
					elsif(misactive(5) = '0') then
						mp := 5;
					elsif(misactive(6) = '0') then
						mp := 6;
					else 
						mp := 7;
					end if;
					case shipHeading is
						when "000" =>
							mispos(mp, 0) := ShipX + 16;  --X
							mispos(mp, 1) := ShipY;       --Y
						when "001" =>
						when "010" =>
							mispos(mp, 0) := ShipX + 32;  --X
							mispos(mp, 1) := ShipY + 16;  --Y
						when "011" =>
						when "100" =>
							mispos(mp, 0) := ShipX + 16;  --X
							mispos(mp, 1) := ShipY + 32;  --Y
						when "101" =>
						when "110" =>
							mispos(mp, 0) := ShipX;       --X
							mispos(mp, 1) := ShipY + 16;  --Y
						when "111" =>
						when others =>
					end case;
					mishead(mp)   := shipHeading;
					misactive(mp) := '1';
					count := count + 1;
					mp := 0;
				end if;
				missile_clear <= '1';
			else
				missile_clear <= '0';
				clk_count := clk_count + "000000000000000001";
				if(clk_count = "111111111111111111") then
					for mis in 0 to 7 loop
						if(misactive(mis) = '1') then
							case mishead(mis) is
								when "000" =>
									mispos(mis, 0) := mispos(mis, 0);
									mispos(mis, 1) := mispos(mis, 1) - y_step;
								when "001" =>
								when "010" =>
									mispos(mis, 0) := mispos(mis, 0) + x_step;
									mispos(mis, 1) := mispos(mis, 1);
								when "011" =>
								when "100" =>
									mispos(mis, 0) := mispos(mis, 0);
									mispos(mis, 1) := mispos(mis, 1) + y_step;
								when "101" =>
								when "110" =>
									mispos(mis, 0) := mispos(mis, 0) - x_step;
									mispos(mis, 1) := mispos(mis, 1);
								when "111" =>
								when others =>
							end case;
							
							if(mispos(mis, 1) + 6 >= y_max) then       -- bottom edge
								misactive(mis) := '0';
								count := count - 1;
							elsif(mispos(mis, 1) <= y_min) then        -- top edge
								misactive(mis) := '0';
								count := count - 1;
							elsif(mispos(mis, 0) + 6 >= x_max) then    -- right edge
								misactive(mis) := '0';
								count := count - 1;
							elsif(mispos(mis, 0) <= x_min) then        -- left edge
								misactive(mis) := '0';  
								count := count - 1;
							end if;
						end if;
					end loop;
					clk_count := "000000000000000000";
				end if;
			end if;
		end if;
		mpos0(0) <= mispos(0,0);
		mpos0(1) <= mispos(0,1);
		mpos1(0) <= mispos(1,0);
		mpos1(1) <= mispos(1,1);		
		mpos2(0) <= mispos(2,0);
		mpos2(1) <= mispos(2,1);		
		mpos3(0) <= mispos(3,0);
		mpos3(1) <= mispos(3,1);		
		mpos4(0) <= mispos(4,0);
		mpos4(1) <= mispos(4,1);		
		mpos5(0) <= mispos(5,0);
		mpos5(1) <= mispos(5,1);		
		mpos6(0) <= mispos(6,0);
		mpos6(1) <= mispos(6,1);		
		mpos7(0) <= mispos(7,0);
		mpos7(1) <= mispos(7,1);
		mactive <= misactive;
	end process;

	draw_missile : process(clk, reset)
	variable used : std_logic;
	begin
		if(reset = '1') then
			missile_on <= '0';
		elsif(rising_edge(clk)) then
			used := '0';
			if(misactive(0) = '1') then    --missile in use
				if(mispos(0, 0) >= drawX and mispos(0, 0) <= drawX+5 and mispos(0, 1) >= drawY and mispos(0, 1) <= drawY+5) then
					missileRed   <= "1111111111";
					missileGreen <= "1111111111";
					missileBlue  <= "1111111111";
					missile_on <= '1';
					used := '1';
				else
					used := '0';
				end if;
			end if;
			
			if(misactive(1) = '1' and used = '0') then    --missile in use
				if(mispos(1, 0) >= drawX and mispos(1, 0) <= drawX+5 and mispos(1, 1) >= drawY and mispos(1, 1) <= drawY+5) then
					missileRed   <= "1111111111";
					missileGreen <= "1111111111";
					missileBlue  <= "1111111111";
					missile_on <= '1';
					used := '1';
				else
					used := '0';
				end if;
			end if;
			
			if(misactive(2) = '1' and used = '0') then    --missile in use
				if(mispos(2, 0) >= drawX and mispos(2, 0) <= drawX+5 and mispos(2, 1) >= drawY and mispos(2, 1) <= drawY+5) then
					missileRed   <= "1111111111";
					missileGreen <= "1111111111";
					missileBlue  <= "1111111111";
					missile_on <= '1';
					used := '1';
				else
					used := '0';
				end if;
			end if;
			
			if(misactive(3) = '1' and used = '0') then    --missile in use
				if(mispos(3, 0) >= drawX and mispos(3, 0) <= drawX+5 and mispos(3, 1) >= drawY and mispos(3, 1) <= drawY+5) then
					missileRed   <= "1111111111";
					missileGreen <= "1111111111";
					missileBlue  <= "1111111111";
					missile_on <= '1';
					used := '1';
				else
					used := '0';
				end if;
			end if;
			
			if(misactive(4) = '1' and used = '0') then    --missile in use
				if(mispos(4, 0) >= drawX and mispos(4, 0) <= drawX+5 and mispos(4, 1) >= drawY and mispos(4, 1) <= drawY+5) then
					missileRed   <= "1111111111";
					missileGreen <= "1111111111";
					missileBlue  <= "1111111111";
					missile_on <= '1';
					used := '1';
				else
					used := '0';
				end if;
			end if;
			
			if(misactive(5) = '1' and used = '0') then    --missile in use
				if(mispos(5, 0) >= drawX and mispos(5, 0) <= drawX+5 and mispos(5, 1) >= drawY and mispos(5, 1) <= drawY+5) then
					missileRed   <= "1111111111";
					missileGreen <= "1111111111";
					missileBlue  <= "1111111111";
					missile_on <= '1';
					used := '1';
				else
					used := '0';
				end if;
			end if;
			
			if(misactive(6) = '1' and used = '0') then    --missile in use
				if(mispos(6, 0) >= drawX and mispos(6, 0) <= drawX+5 and mispos(6, 1) >= drawY and mispos(6, 1) <= drawY+5) then
					missileRed   <= "1111111111";
					missileGreen <= "1111111111";
					missileBlue  <= "1111111111";
					missile_on <= '1';
					used := '1';
				else
					used := '0';
				end if;
			end if;
			
			if(misactive(7) = '1' and used = '0') then    --missile in use
				if(mispos(7, 0) >= drawX and mispos(7, 0) <= drawX+5 and mispos(7, 1) >= drawY and mispos(7, 1) <= drawY+5) then
					missileRed   <= "1111111111";
					missileGreen <= "1111111111";
					missileBlue  <= "1111111111";
					missile_on <= '1';
					used := '1';
				else
					used := '0';
				end if;
			end if;
			
			if(used = '0') then
				missileRed   <= "0000000000";
				missileGreen <= "0000000000";
				missileBlue  <= "0000000000";
				missile_on <= '0';
			end if;
		end if;
	end process;

--	collide_process : process(clk, reset, collide, misCollided)
--	begin
--		if(rising_edge(clk)) then
--			if(collide = '1') then
--				misactive(conv_integer(misCollided)) := '0';
--				count := count - 1;
--			end if;
--		end if;
--	end process;

end Behavioral;