library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library asteroids;
use asteroids.types.all;

-- asteroid entity
entity asteroid is
   Port ( reset  : in std_logic;
		  clk : in std_logic;
		  drawX : in std_logic_vector(9 downto 0);
		  drawY : in std_logic_vector(9 downto 0);
		  shipX : in std_logic_vector(9 downto 0);
		  shipY : in std_logic_vector(9 downto 0);
		  spriteData  : in std_logic_vector(63 downto 0);
		  astCollided : in std_logic_vector(2 downto 0);
		  collide     : in std_logic;
		  spriteAddrs: out std_logic_vector(7 downto 0);
		  asteroidOn : out std_logic;
		  shipCollision : out std_logic;
		  asteroidRed : out std_logic_vector(9 downto 0);
		  asteroidGreen : out std_logic_vector(9 downto 0);
		  asteroidBlue : out std_logic_vector(9 downto 0);
		  aactive : out astactivetype;
		  apos0    : out astpossingletype;
		  apos1    : out astpossingletype;
		  apos2    : out astpossingletype;
		  apos3    : out astpossingletype;
		  apos4    : out astpossingletype;
		  apos5    : out astpossingletype    );
end asteroid;
	
architecture Behavioral of asteroid is

constant x_center : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(320, 10);  --Center position on the X axis
constant y_center : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(240, 10);  --Center position on the Y axis

constant x_min    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(0, 10);    --Leftmost point on the X axis
constant x_max    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(639, 10);  --Rightmost point on the X axis
constant y_min    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(0, 10);    --Topmost point on the Y axis
constant y_max    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(479, 10);  --Bottommost point on the Y axis
                              
constant x_step   : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(1, 10);    --Step size on the X axis
constant y_step   : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(1, 10);    --Step size on the Y axis

shared variable astpos    : astpostype;
shared variable asthead   : astheadtype;
shared variable astactive : astactivetype;
shared variable astlife   : astlifetype;
shared variable count     : integer := 0;
shared variable head_count: integer := 0;
shared variable gen_count : integer := 0;
shared variable clk_count : std_logic_vector(18 downto 0);
shared variable ast_ready : std_logic := '0';
shared variable ast_clear : std_logic := '0';

begin

	asteroid_gen : process(clk, reset)
	begin
		if(reset = '1') then	
			gen_count  := 0;
			ast_ready  := '0';
		elsif(ast_clear = '1') then
			ast_ready := '0';
		elsif(rising_edge(clk)) then
			gen_count  := gen_count + 1;
			if(gen_count = 25000000) then
				gen_count := 0;
				ast_ready := '1';
			end if;
		end if;
	end process;
	
	asteroid_action : process(clk, reset, astCollided, collide)
	variable mp : integer := 0;
	begin
		if(reset = '1') then
			count := 0;
			mp := 0;
			head_count := 0;
			ast_clear  := '0';
			clk_count := "0000000000000000000";
			for ast in 0 to 5 loop
				astpos(ast, 0) := "0000000000";
				astpos(ast, 1) := "0000000000";
				asthead(ast)   := "000";
				astactive(ast) := '0';
				astlife(ast)   := 0;
			end loop;
		elsif(rising_edge(clk)) then
			if(collide = '1') then
				astactive(conv_integer(astCollided)) := '0';
				count := count - 1;
			elsif(ast_ready = '1') then    --create new asteroid
				if(count <= 5) then
					if(astactive(0) = '0') then
						mp := 0;
					elsif(astactive(1) = '0') then
						mp := 1;
					elsif(astactive(2) = '0') then
						mp := 2;
					elsif(astactive(3) = '0') then
						mp := 3;
					elsif(astactive(4) = '0') then
						mp := 4;
					else 
						mp := 5;
					end if;
					
					if(head_count = 0) then
						astpos(mp, 0) := "0100101100";  --X = 300
						astpos(mp, 1) := "0110111001";  --Y = 441
					elsif(head_count = 1) then
						astpos(mp, 0) := "0000100001";  --X = 33
						astpos(mp, 1) := "0110111001";  --Y = 441
					elsif(head_count = 2) then
						astpos(mp, 0) := "0000100001";  --X = 33
						astpos(mp, 1) := "0100010011";  --Y = 275
					elsif(head_count = 3) then
						astpos(mp, 0) := "0000100001";  --X = 33
						astpos(mp, 1) := "0001001011";  --Y = 75
					elsif(head_count = 4) then
						astpos(mp, 0) := "0111110100";  --X = 500
						astpos(mp, 1) := "0000100001";  --Y = 33
					elsif(head_count = 5) then
						astpos(mp, 0) := "1001011000";  --X = 600
						astpos(mp, 1) := "0001001011";  --Y = 33
					elsif(head_count = 6) then
						astpos(mp, 0) := "1001011011";  --X = 606
						astpos(mp, 1) := "0101000000";  --Y = 320
					else
						astpos(mp, 0) := "1000111010";  --X = 570
						astpos(mp, 1) := "0110111001";  --Y = 441
					end if;
					asthead(mp)   := conv_std_logic_vector(head_count, 3);
					astlife(mp)   := 3;
					head_count := head_count + 1;
					if(head_count > 7) then
						head_count := 0;
					end if;
					astactive(mp) := '1';
					count := count + 1;
					mp := 0;
				end if;
				ast_clear := '1';
			else                          --move asteroids
				ast_clear := '0';
				clk_count := clk_count + "0000000000000000001";
				if(clk_count = "1001111111111111111") then
					for ast in 0 to 5 loop
						if(astactive(ast) = '1') then
							case asthead(ast) is
								when "000" =>
									astpos(ast, 0) := astpos(ast, 0);
									astpos(ast, 1) := astpos(ast, 1) - y_step;
								when "001" =>
									astpos(ast, 0) := astpos(ast, 0) + x_step;
									astpos(ast, 1) := astpos(ast, 1) - y_step;
								when "010" =>
									astpos(ast, 0) := astpos(ast, 0) + x_step;
									astpos(ast, 1) := astpos(ast, 1);
								when "011" =>
									astpos(ast, 0) := astpos(ast, 0) + x_step;
									astpos(ast, 1) := astpos(ast, 1) + y_step;
								when "100" =>
									astpos(ast, 0) := astpos(ast, 0);
									astpos(ast, 1) := astpos(ast, 1) + y_step;
								when "101" =>
									astpos(ast, 0) := astpos(ast, 0) - x_step;
									astpos(ast, 1) := astpos(ast, 1) + y_step;
								when "110" =>
									astpos(ast, 0) := astpos(ast, 0) - x_step;
									astpos(ast, 1) := astpos(ast, 1);
								when "111" =>
									astpos(ast, 0) := astpos(ast, 0) - x_step;
									astpos(ast, 1) := astpos(ast, 1) - y_step;
								when others =>
							end case;
							
						  if(astpos(ast, 1) + 63 >= y_max) then    -- bottom edge
							astpos(ast, 1) := y_min + 63;
							astpos(ast, 1) := astpos(ast, 1) + "0000000001";
							astpos(ast, 0) := astpos(ast, 0);
							astlife(ast) := astlife(ast) - 1;
						  elsif(astpos(ast, 1) <= y_min) then      -- top edge
							astpos(ast, 1) := y_max - 63;
							astpos(ast, 1) := astpos(ast, 1) - "0000000001";
							astpos(ast, 0) := astpos(ast, 0);  
							astlife(ast) := astlife(ast) - 1;
						  end if;

						  if(astpos(ast, 0) + 63 >= x_max) then     -- right edge
							astpos(ast, 1) := astpos(ast, 1);
							astpos(ast, 0) := x_min + 63;
							astpos(ast, 0) := astpos(ast, 0) + "0000000001";
							astlife(ast) := astlife(ast) - 1;
						  elsif(astpos(ast, 0) <= x_min) then      -- left edge
							astpos(ast, 1) := astpos(ast, 1);
							astpos(ast, 0) := x_max - 63;
							astpos(ast, 0) := astpos(ast, 0) - "0000000001";   
						    astlife(ast) := astlife(ast) - 1;
						  end if;
						  
						  if(astlife(ast) < 0) then    --check life of asteroid
							  astactive(ast) := '0';
							  count := count - 1;
						  end if;
							  
						end if;
					end loop;
					clk_count := "0000000000000000000";
				end if;
			end if;
		end if;
		aactive <= astactive;
		apos0(0) <= astpos(0,0);
		apos0(1) <= astpos(0,1);
		apos1(0) <= astpos(1,0);
		apos1(1) <= astpos(1,1);
		apos2(0) <= astpos(2,0);
		apos2(1) <= astpos(2,1);
		apos3(0) <= astpos(3,0);
		apos3(1) <= astpos(3,1);
		apos4(0) <= astpos(4,0);
		apos4(1) <= astpos(4,1);
		apos5(0) <= astpos(5,0);
		apos5(1) <= astpos(5,1);
	end process;

	asteroid_draw : process(clk, reset)
		variable used : std_logic;
		variable data : std_logic;
		variable sub  : std_logic_vector(9 downto 0);
		variable spriteAd : std_logic_vector(7 downto 0);
	begin
		if(reset = '1') then
			asteroidOn <= '0';
		elsif(rising_edge(clk)) then
			used := '0';
			spriteAd := spriteAd;
			
			if(astactive(0) = '1') then    --asteroid in use
				if(drawX = astpos(0, 0)-1 and drawY >=astpos(0, 1) and drawY <= astpos(0, 1)+63) then
					spriteAd := "00" & conv_std_logic_vector(conv_integer(drawY - astpos(0, 1)), 6);
					used := '1';
				elsif(drawX >= astpos(0, 0) and drawX <= astpos(0, 0)+63 and drawY >= astpos(0, 1) and drawY <= astpos(0, 1)+63) then
					sub  := drawX - astpos(0, 0);
					data := spriteData(conv_integer(sub));
					if(data = '1') then
						asteroidRed   <= "1111111111";
						asteroidGreen <= "1111111111";
						asteroidBlue  <= "1111111111";
					else
						asteroidRed   <= "0000000000";
						asteroidGreen <= "0000000000";
						asteroidBlue  <= "0000000000";
					end if;
					asteroidOn <= '1';
					used := '1';
				else
					used := '0';
				end if;
			end if;
			
			if(astactive(1) = '1' and used = '0') then
				if(drawX = astpos(1, 0)-1 and drawY >=astpos(1, 1) and drawY <= astpos(1, 1)+63) then
					spriteAd := "01" & conv_std_logic_vector(conv_integer(drawY - astpos(1, 1)), 6);
					used := '1';
				elsif(drawX >= astpos(1, 0) and drawX <= astpos(1, 0)+63 and drawY >= astpos(1, 1) and drawY <= astpos(1, 1)+63) then
					sub  := drawX - astpos(1, 0);
					data := spriteData(conv_integer(sub));
					if(data = '1') then
						asteroidRed   <= "1111111111";
						asteroidGreen <= "1111111111";
						asteroidBlue  <= "1111111111";
					else
						asteroidRed   <= "0000000000";
						asteroidGreen <= "0000000000";
						asteroidBlue  <= "0000000000";
					end if;
					asteroidOn <= '1';
					used := '1';
				else
					used := '0';
				end if;
			end if;
			
			if(astactive(2) = '1' and used = '0') then
				if(drawX = astpos(2, 0)-1 and drawY >=astpos(2, 1) and drawY <= astpos(2, 1)+63) then
					spriteAd := "00" & conv_std_logic_vector(conv_integer(drawY - astpos(2, 1)), 6);
					used := '1';
				elsif(drawX >= astpos(2, 0) and drawX <= astpos(2, 0)+63 and drawY >= astpos(2, 1) and drawY <= astpos(2, 1)+63) then
					sub  := drawX - astpos(2, 0);
					data := spriteData(conv_integer(sub));
					if(data = '1') then
						asteroidRed   <= "1111111111";
						asteroidGreen <= "1111111111";
						asteroidBlue  <= "1111111111";
					else
						asteroidRed   <= "0000000000";
						asteroidGreen <= "0000000000";
						asteroidBlue  <= "0000000000";
					end if;
					asteroidOn <= '1';
					used := '1';
				else
					used := '0';
				end if;
			end if;
			
			if(astactive(3) = '1' and used = '0') then 
				if(drawX = astpos(3, 0)-1 and drawY >=astpos(3, 1) and drawY <= astpos(3, 1)+63) then
					spriteAd := "01" & conv_std_logic_vector(conv_integer(drawY - astpos(3, 1)), 6);
					used := '1';
				elsif(drawX >= astpos(3, 0) and drawX <= astpos(3, 0)+63 and drawY >= astpos(3, 1) and drawY <= astpos(3, 1)+63) then
					sub  := drawX - astpos(3, 0);
					data := spriteData(conv_integer(sub));
					if(data = '1') then
						asteroidRed   <= "1111111111";
						asteroidGreen <= "1111111111";
						asteroidBlue  <= "1111111111";
					else
						asteroidRed   <= "0000000000";
						asteroidGreen <= "0000000000";
						asteroidBlue  <= "0000000000";
					end if;
					asteroidOn <= '1';
					used := '1';
				else
					used := '0';
				end if;
			end if;
			
			if(astactive(4) = '1' and used = '0') then
				if(drawX = astpos(4, 0)-1 and drawY >=astpos(4, 1) and drawY <= astpos(4, 1)+63) then
					spriteAd := "00" & conv_std_logic_vector(conv_integer(drawY - astpos(4, 1)), 6);
					used := '1';
				elsif(drawX >= astpos(4, 0) and drawX <= astpos(4, 0)+63 and drawY >= astpos(4, 1) and drawY <= astpos(4, 1)+63) then
					sub  := drawX - astpos(4, 0);
					data := spriteData(conv_integer(sub));
					if(data = '1') then
						asteroidRed   <= "1111111111";
						asteroidGreen <= "1111111111";
						asteroidBlue  <= "1111111111";
					else
						asteroidRed   <= "0000000000";
						asteroidGreen <= "0000000000";
						asteroidBlue  <= "0000000000";
					end if;
					asteroidOn <= '1';
					used := '1';
				else
					used := '0';
				end if;
			end if;
			
			if(astactive(5) = '1' and used = '0') then 
				if(drawX = astpos(5, 0)-1 and drawY >=astpos(5, 1) and drawY <= astpos(5, 1)+63) then
					spriteAd := "01" & conv_std_logic_vector(conv_integer(drawY - astpos(5, 1)), 6);
					used := '1';
				elsif(drawX >= astpos(5, 0) and drawX <= astpos(5, 0)+63 and drawY >= astpos(5, 1) and drawY <= astpos(5, 1)+63) then
					sub  := drawX - astpos(5, 0);
					data := spriteData(conv_integer(sub));
					if(data = '1') then
						asteroidRed   <= "1111111111";
						asteroidGreen <= "1111111111";
						asteroidBlue  <= "1111111111";
					else
						asteroidRed   <= "0000000000";
						asteroidGreen <= "0000000000";
						asteroidBlue  <= "0000000000";
					end if;
					asteroidOn <= '1';
					used := '1';
				else
					used := '0';
				end if;
			end if;
			
			if(used = '0') then
				asteroidRed   <= "0000000000";
				asteroidGreen <= "0000000000";
				asteroidBlue  <= "0000000000";
				asteroidOn <= '0';
			end if;
			spriteAddrs <= spriteAd;
		end if;
	end process;
	
	
	asteroid_collide : process(clk, reset)
		variable collis : std_logic;
	begin
		if(reset = '1') then
			collis := '0';
		elsif(rising_edge(clk)) then			
			collis := '0';
			if(astactive(0) = '1') then    --asteroid in use
				if(((shipX+31 >= astpos(0, 0) and shipX+31 <= astpos(0, 0)+63) and ((shipY+31 <= astpos(0, 1)+63 and shipY+31 >= astpos(0, 1)) or (shipY >= astpos(0, 1) and shipY <= astpos(0, 1)+63))) or 
				   (((shipX   >= astpos(0, 0) and shipX    <= astpos(0, 0)+63) and ((shipY+31 <= astpos(0, 1)+63 and shipY+31 >= astpos(0, 1)) or (shipY >= astpos(0, 1) and shipY <= astpos(0, 1)+63))))) then
					collis := '1';
					--astactive(0) := '0';
					--count := count - 1;
				end if;
			end if;
			
			if(astactive(1) = '1') then    --asteroid in use
				if(((shipX+31 >= astpos(1,0) and shipX+31 <= astpos(1,0)+63) and ((shipY+31 <= astpos(1,1)+63 and shipY+31 >= astpos(1,1)) or (shipY >= astpos(1,1) and shipY <= astpos(1,1)+63))) or 
				   (((shipX   >= astpos(1,0) and shipX    <= astpos(1,0)+63) and ((shipY+31 <= astpos(1,1)+63 and shipY+31 >= astpos(1,1)) or (shipY >= astpos(1,1) and shipY <= astpos(1,1)+63))))) then
					collis := '1';
					--astactive(1) := '0';
					--count := count - 1;
				end if;
			end if;
			
			if(astactive(2) = '1') then    --asteroid in use
				if(((shipX+31 >= astpos(2,0) and shipX+31 <= astpos(2,0)+63) and ((shipY+31 <= astpos(2,1)+63 and shipY+31 >= astpos(2,1)) or (shipY >= astpos(2,1) and shipY <= astpos(2,1)+63))) or 
				   (((shipX   >= astpos(2,0) and shipX    <= astpos(2,0)+63) and ((shipY+31 <= astpos(2,1)+63 and shipY+31 >= astpos(2,1)) or (shipY >= astpos(2,1) and shipY <= astpos(2,1)+63))))) then
					collis := '1';
					--astactive(2) := '0';
					--count := count - 1;
				end if;
			end if;
			
			if(astactive(3) = '1') then    --asteroid in use
				if(((shipX+31 >= astpos(3,0) and shipX+31 <= astpos(3,0)+63) and ((shipY+31 <= astpos(3,1)+63 and shipY+31 >= astpos(3,1)) or (shipY >= astpos(3,1) and shipY <= astpos(3,1)+63))) or 
				   (((shipX   >= astpos(3,0) and shipX    <= astpos(3,0)+63) and ((shipY+31 <= astpos(3,1)+63 and shipY+31 >= astpos(3,1)) or (shipY >= astpos(3,1) and shipY <= astpos(3,1)+63))))) then
					collis := '1';
					--astactive(3) := '0';
					--count := count - 1;
				end if;
			end if;
			
			if(astactive(4) = '1') then    --asteroid in use
				if(((shipX+31 >= astpos(4,0) and shipX+31 <= astpos(4,0)+63) and ((shipY+31 <= astpos(4,1)+63 and shipY+31 >= astpos(4,1)) or (shipY >= astpos(4,1) and shipY <= astpos(4,1)+63))) or 
				   (((shipX   >= astpos(4,0) and shipX    <= astpos(4,0)+63) and ((shipY+31 <= astpos(4,1)+63 and shipY+31 >= astpos(4,1)) or (shipY >= astpos(4,1) and shipY <= astpos(4,1)+63))))) then
					collis := '1';
					--astactive(4) := '0';
					--count := count - 1;
				end if;
			end if;
			
			if(astactive(5) = '1') then    --asteroid in use
				if(((shipX+31 >= astpos(5,0) and shipX+31 <= astpos(5,0)+63) and ((shipY+31 <= astpos(5,1)+63 and shipY+31 >= astpos(5,1)) or (shipY >= astpos(5,1) and shipY <= astpos(5,1)+63))) or 
				   (((shipX   >= astpos(5,0) and shipX    <= astpos(5,0)+63) and ((shipY+31 <= astpos(5,1)+63 and shipY+31 >= astpos(5,1)) or (shipY >= astpos(5,1) and shipY <= astpos(5,1)+63))))) then
					collis := '1';
					--astactive(5) := '0';
					--count := count - 1;
				end if;
			end if;
			
		end if;
		shipCollision <= collis;
	end process;
	
--	missile_collide_process : process(clk, reset, collide, astCollided)
--	begin
--		if(reset='1') then
--		elsif(rising_edge(clk)) then
--			if(collide = '1') then
--				astactive(conv_integer(astCollided)) := '0';
--				count := count - 1;
--			end if;
--		end if;
--	end process;

end Behavioral;