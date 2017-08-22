library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library asteroids;
use asteroids.types.all;

-- HUD entity
entity HUD is
   Port ( reset  : in std_logic;
		  clk : in std_logic;
		  drawX : in std_logic_vector(9 downto 0);
		  drawY : in std_logic_vector(9 downto 0);
		  state : in std_logic_vector(1 downto 0);
		  spriteData : in std_logic_vector(7 downto 0);
		  scoreones, scoretens : in std_logic_vector(4 downto 0);
		  spriteAddrs: out std_logic_vector(8 downto 0);
		  hudOn : out std_logic;
		  hudRed   : out std_logic_vector(9 downto 0);
		  hudGreen : out std_logic_vector(9 downto 0);
		  hudBlue  : out std_logic_vector(9 downto 0)  );
end HUD;
	
architecture Behavioral of HUD is
	begin

	drawHUD : process(clk, reset) 
	variable hudvar, data : std_logic;
	variable spriteAd : std_logic_vector(8 downto 0);
	variable sub : std_logic_vector(9 downto 0);
	variable add : std_logic_vector(4 downto 0);
	begin
		if(reset = '1') then
			hudvar := '0';
		elsif(rising_edge(clk)) then
			case state is
				when "00" =>     --start state
					--hudvar := '1';
					if(drawY >= 190 and drawY <=205) then    --draw "Game Over"
						hudvar := '1';
						if(drawX = 290) then    --G
							spriteAd := "00011" & conv_std_logic_vector(conv_integer(drawY - 190), 4);
						elsif(drawX = 300) then --A
							spriteAd := "00001" & conv_std_logic_vector(conv_integer(drawY - 190), 4);
						elsif(drawX = 310) then --M
							spriteAd := "00100" & conv_std_logic_vector(conv_integer(drawY - 190), 4);
						elsif(drawX = 320) then --E
							spriteAd := "00010" & conv_std_logic_vector(conv_integer(drawY - 190), 4);
						elsif(drawX = 340) then --O
							spriteAd := "00101" & conv_std_logic_vector(conv_integer(drawY - 190), 4);
						elsif(drawX = 350) then --V
							spriteAd := "00111" & conv_std_logic_vector(conv_integer(drawY - 190), 4);
						elsif(drawX = 360) then --E
							spriteAd := "00010" & conv_std_logic_vector(conv_integer(drawY - 190), 4);
						elsif(drawX = 370) then --R
							spriteAd := "00110" & conv_std_logic_vector(conv_integer(drawY - 190), 4);
						elsif(drawX >= 292 and drawX < 300) then     --G
							sub  := "0100011011" - drawX;  --283
							data := spriteData(conv_integer(sub));
							if(data = '1') then
								hudRed   <= "1111111111";
								hudGreen <= "1111111111";
								hudBlue  <= "1111111111";
							else
								hudRed   <= "0000000000";
								hudGreen <= "0000000000";
								hudBlue  <= "0000000000";
							end if;					
						elsif(drawX >= 302 and drawX < 310) then  --A
							sub  := "0100100101" - drawX;  --293
							data := spriteData(conv_integer(sub));
							if(data = '1') then
								hudRed   <= "1111111111";
								hudGreen <= "1111111111";
								hudBlue  <= "1111111111";
							else
								hudRed   <= "0000000000";
								hudGreen <= "0000000000";
								hudBlue  <= "0000000000";
							end if;	
						elsif(drawX >= 312 and drawX < 320) then  --M
							sub  := "0100101111" - drawX;  --303
							data := spriteData(conv_integer(sub));
							if(data = '1') then
								hudRed   <= "1111111111";
								hudGreen <= "1111111111";
								hudBlue  <= "1111111111";
							else
								hudRed   <= "0000000000";
								hudGreen <= "0000000000";
								hudBlue  <= "0000000000";
							end if;	
						elsif(drawX >= 322 and drawX < 330) then  --E
							sub  := "0100111001" - drawX;  --313
							data := spriteData(conv_integer(sub));
							if(data = '1') then
								hudRed   <= "1111111111";
								hudGreen <= "1111111111";
								hudBlue  <= "1111111111";
							else
								hudRed   <= "0000000000";
								hudGreen <= "0000000000";
								hudBlue  <= "0000000000";
							end if;	
						elsif(drawX >= 342 and drawX < 350) then  --O
							sub  := "0101001101" - drawX;  --333
							data := spriteData(conv_integer(sub));
							if(data = '1') then
								hudRed   <= "1111111111";
								hudGreen <= "1111111111";
								hudBlue  <= "1111111111";
							else
								hudRed   <= "0000000000";
								hudGreen <= "0000000000";
								hudBlue  <= "0000000000";
							end if;	
						elsif(drawX >= 352 and drawX < 360) then  --V
							sub  := "0101010111" - drawX;  --343
							data := spriteData(conv_integer(sub));
							if(data = '1') then
								hudRed   <= "1111111111";
								hudGreen <= "1111111111";
								hudBlue  <= "1111111111";
							else
								hudRed   <= "0000000000";
								hudGreen <= "0000000000";
								hudBlue  <= "0000000000";
							end if;	
						elsif(drawX >= 362 and drawX < 370) then  --E
							sub  := "0101100001" - drawX;  --353
							data := spriteData(conv_integer(sub));
							if(data = '1') then
								hudRed   <= "1111111111";
								hudGreen <= "1111111111";
								hudBlue  <= "1111111111";
							else
								hudRed   <= "0000000000";
								hudGreen <= "0000000000";
								hudBlue  <= "0000000000";
							end if;	
						elsif(drawX >= 372 and drawX < 380) then  --R
							sub  := "0101101011" - drawX;  --363
							data := spriteData(conv_integer(sub));
							if(data = '1') then
								hudRed   <= "1111111111";
								hudGreen <= "1111111111";
								hudBlue  <= "1111111111";
							else
								hudRed   <= "0000000000";
								hudGreen <= "0000000000";
								hudBlue  <= "0000000000";
							end if;	
						else
							hudvar := '0';
							hudRed   <= "0000000000";
							hudGreen <= "0000000000";
							hudBlue  <= "0000000000";
						end if;
					else  --start state background
						hudvar := '0';
						hudRed   <= "0000000000";
						hudGreen <= "0000000000";
						hudBlue  <= "0000000000";
					end if;
				when others =>   --normal states
					if(drawY <= 20 and drawY >= 5) then
						hudvar := '1';
						if(drawX = 598) then    --draw tens digit
							add  := "01000" + scoretens;  --600
							spriteAd := add & conv_std_logic_vector(conv_integer(drawY - 5), 4);
						elsif(drawX = 609) then --draw ones digit
							add  := "01000" + scoreones;  --600
							spriteAd := add & conv_std_logic_vector(conv_integer(drawY - 5), 4);
						elsif(drawX = 8) then
							spriteAd := "00000" & conv_std_logic_vector(conv_integer(drawY - 5), 4);
						elsif(drawX = 25) then
							spriteAd := "00000" & conv_std_logic_vector(conv_integer(drawY - 5), 4);
						elsif(drawX >= 10 and drawX <= 17 and (state="11" or state="10")) then  --draw 1st ship
							sub  := drawX - "0000001010";  --10
							data := spriteData(conv_integer(sub));
							if(data = '1') then
								hudRed   <= "1111111111";
								hudGreen <= "1111111111";
								hudBlue  <= "1111111111";
							else
								hudRed   <= "0000000000";
								hudGreen <= "0000000000";
								hudBlue  <= "0000000000";
							end if;
						elsif(drawX >= 27 and drawX <= 34 and state="11") then   --draw 2nd ship
							sub  := drawX - "0000011011";  --27
							data := spriteData(conv_integer(sub));
							if(data = '1') then
								hudRed   <= "1111111111";
								hudGreen <= "1111111111";
								hudBlue  <= "1111111111";
							else
								hudRed   <= "0000000000";
								hudGreen <= "0000000000";
								hudBlue  <= "0000000000";
							end if;
						elsif(drawX >= 600 and drawX <= 607) then  --draw tens digit
							sub  := "1001011111" - drawX; --607 
							data := spriteData(conv_integer(sub));
							if(data = '1') then
								hudRed   <= "1111111111";
								hudGreen <= "1111111111";
								hudBlue  <= "1111111111";
							else
								hudRed   <= "0000000000";
								hudGreen <= "0000000000";
								hudBlue  <= "0000000000";
							end if;
						elsif(drawX >= 611 and drawX <= 618) then  --draw ones digit
							sub  := "1001101010" - drawX; --618
							data := spriteData(conv_integer(sub));
							if(data = '1') then
								hudRed   <= "1111111111";
								hudGreen <= "1111111111";
								hudBlue  <= "1111111111";
							else
								hudRed   <= "0000000000";
								hudGreen <= "0000000000";
								hudBlue  <= "0000000000";
							end if;	
						else
							hudRed   <= "0000000000";
							hudGreen <= "0000000000";
							hudBlue  <= "0000000000";
						end if;
					else
						hudvar := '0';
						hudRed   <= "1111111111";  --doesnt matter 
						hudGreen <= "1111111111";
						hudBlue  <= "1111111111";
					end if;
			end case;
			hudOn <= hudvar;
			spriteAddrs <= spriteAd;
		end if;
	end process;

end Behavioral;