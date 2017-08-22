library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- spaceship entity
entity spaceship is
   Port ( Reset, data_ready : in std_logic;
        frame_clk, system_clk : in std_logic;
        scan_code : in std_logic_vector(7 downto 0);
        missile_clear : in std_logic;
        ShipX : out std_logic_vector(9 downto 0);
        ShipY : out std_logic_vector(9 downto 0);
        reset_out, action_out : out std_logic;
        missile_out : out std_logic;
        heading_out : out std_logic_vector(2 downto 0) );
end spaceship;

architecture Behavioral of spaceship is

shared variable x_pos, y_pos : std_logic_vector(9 downto 0);
shared variable heading : std_logic_vector(2 downto 0);
shared variable x_motion, y_motion : std_logic_vector(9 downto 0);
shared variable scancode : std_logic_vector(7 downto 0);
shared variable reset_ready : std_logic;
shared variable action_ready : std_logic;
shared variable key_ready, switch_ready : std_logic;
shared variable clk_count, clk_target : std_logic_vector(18 downto 0);
shared variable up, lft, rght, down : std_logic;
shared variable upow, lpow, rpow, dpow : integer;
--signal frame_clk_div : std_logic_vector(5 downto 0);

constant x_center : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(320, 10);  --Center position on the X axis
constant y_center : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(240, 10);  --Center position on the Y axis

constant x_min    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(0, 10);    --Leftmost point on the X axis
constant x_max    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(639, 10);  --Rightmost point on the X axis
constant y_min    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(0, 10);    --Topmost point on the Y axis
constant y_max    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(479, 10);  --Bottommost point on the Y axis
                              
constant x_step   : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(1, 10);    --Step size on the X axis
constant y_step   : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(1, 10);    --Step size on the Y axis

constant clk_target_initial : std_logic_vector(18 downto 0) := "1001111111111111111";
constant clk_step    : std_logic_vector(18 downto 0) := "0000000001000000000";

begin

-------------------------------------------------

	--process to determine if button is pressed
	normal_move : process(frame_clk, reset)
	begin
		if(reset = '1') then
		    y_motion := "0000000000";  --start stationary
		    x_motion := "0000000000"; 
		    y_pos := y_center;
		    x_pos := x_center;
		    ShipX <= x_pos;
			ShipY <= y_pos;
		    clk_count := "0000000000000000000";
		    clk_target := clk_target_initial;
		    upow := 0;
		    dpow := 0;
		    lpow := 0;
		    rpow := 0;
		elsif(rising_edge(frame_clk)) then
			clk_count := clk_count + "0000000000000000001";
			if(clk_count = clk_target) then
				clk_count := "0000000000000000000";
				y_motion := y_motion;
				x_motion := x_motion;
				
				----------- button handling -------------------------------------------------------------------
				if(up = '1') then              --move up
					upow := upow + 1;
					dpow := dpow - 1;
					rpow := 0;
					lpow := 0;
					if(upow > dpow) then                           --more power in direction of press
						y_motion := not(y_step) + '1';                --move in direction of press
						x_motion := "0000000000";
						clk_target := clk_target - clk_step;          --speed up
					elsif(upow >= dpow-4 and upow <= dpow+4) then  --equal power
						x_motion := "0000000000";                     --stop
						y_motion := "0000000000";
						upow := 0;
						dpow := 0;
						clk_target := clk_target_initial;             --start at normal speed
					else                                           --more power in opposite direction
						clk_target := clk_target + clk_step;          --slow down
					end if;
				elsif(down = '1') then         --move down
					dpow := dpow + 1; 
					upow := upow - 1;
					rpow := 0;
					lpow := 0;    
					if(dpow > upow) then
						y_motion := y_step; 
						x_motion := "0000000000";
						clk_target := clk_target - clk_step;
					elsif(dpow >= upow-4 and dpow <= upow+4) then   
						x_motion := "0000000000";
						y_motion := "0000000000";
						upow := 0;
						dpow := 0;
						clk_target := clk_target_initial;
					else 
						clk_target := clk_target + clk_step;
					end if;    
				elsif(rght = '1') then         --move right
					rpow := rpow + 1;
					lpow := lpow - 1;  
					dpow := 0;
					upow := 0; 
					if(rpow > lpow) then
						x_motion := x_step; 
						y_motion := "0000000000";
						clk_target := clk_target - clk_step;
					elsif(rpow >= lpow-4 and rpow <= lpow+4) then   
						x_motion := "0000000000";
						y_motion := "0000000000";
						lpow := 0;
						rpow := 0;
						clk_target := clk_target_initial;
					else 
						clk_target := clk_target + clk_step;
					end if;
				elsif(lft = '1') then          --move left
					lpow := lpow + 1;
					rpow := rpow - 1;
					dpow := 0;
					upow := 0; 
					if(lpow > rpow) then
						x_motion := not(x_step) + '1';
						y_motion := "0000000000";
						clk_target := clk_target - clk_step;
					elsif(lpow >= rpow-4 and lpow <= rpow+4) then   
						x_motion := "0000000000";
						y_motion := "0000000000";
						lpow := 0;
						rpow := 0;
						clk_target := clk_target_initial;
					else 
						clk_target := clk_target + clk_step;
					end if;
				else
					x_motion := x_motion; -- no press
					y_motion := y_motion;
				end if;

				y_pos := y_pos + y_motion; 
				x_pos := x_pos + x_motion;
				
				---------- edge handling ----------------------------------------------------------------------
				if(y_pos + 15 >= y_max) then    -- bottom edge
					y_pos := y_min + 15;
					y_pos := y_pos + "0000000001";
					x_pos := x_pos;
				elsif(y_pos <= y_min) then      -- top edge
					y_pos := y_max - 15;
					y_pos := y_pos - "0000000001";
					x_pos := x_pos;        
				end if;
				if(x_pos + 7 >= x_max) then     -- right edge
					y_pos := y_pos;
					x_pos := x_min + 7;
					x_pos := x_pos + "0000000001";
				elsif(x_pos <= x_min) then      -- left edge
					y_pos := y_pos;
					x_pos := x_max - 7;
					x_pos := x_pos - "0000000001";    
				end if;
			end if;
		end if;
		ShipX <= x_pos;
		ShipY <= y_pos;
	end process;
	
	get_keys : process(system_clk, reset, missile_clear, data_ready)
	begin
		if(Reset = '1') then   --Asynchronous Reset
		    action_ready := '1';
		    reset_ready := '0';
		    key_ready := '1';
		    switch_ready := '0';
		    heading := "000";
		elsif(missile_clear = '1') then
			missile_out <= '0';
		elsif(rising_edge(system_clk) and (reset_ready='1')) then   --see if reset needed
			reset_ready := '0';
			action_ready := '1';
		elsif(rising_edge(system_clk) and (data_ready='1') and (action_ready='1')) then  --no reset, instead button pressed
			scancode := scan_code;
			action_ready := '0';
			case scancode is
				when "00011100" =>    --A    turn counterclockwise
					if(key_ready = '1') then
						case heading is
							when "000" =>
								heading := "110";
							when "001" =>
							when "010" =>
								heading := "000";
							when "011" =>
							when "100" =>
								heading := "010";
							when "101" =>
							when "110" =>
								heading := "100";
							when "111" =>
							when others =>
						end case;
						reset_ready := '1';
						key_ready := '1';
						switch_ready := '0';
					elsif(switch_ready = '1') then
						key_ready := '1';
						switch_ready := '0';
						reset_ready := '1';
					end if;
				when "00011011" =>    --S					
					if(key_ready = '1') then
						case heading is
							when "000" =>
								down := '1';
								up   := '0';
								lft  := '0';
								rght := '0';
							when "001" =>
							when "010" =>
								down := '0';
								up   := '0';
								lft  := '1';
								rght := '0';
							when "011" =>
							when "100" =>
								down := '0';
								up   := '1';
								lft  := '0';
								rght := '0';
							when "101" =>
							when "110" =>
								down := '0';
								up   := '0';
								lft  := '0';
								rght := '1';
							when "111" =>
							when others =>
						end case;
						reset_ready := '1';
						key_ready := '1';
						switch_ready := '0';
					elsif(switch_ready = '1') then
						key_ready := '1';
						switch_ready := '0';
						reset_ready := '1';
					end if;
				when "00100011" =>    --D   turn clockwise
					if(key_ready = '1') then	
						case heading is
							when "000" =>
								heading := "010";
							when "001" =>
							when "010" =>
								heading := "100";
							when "011" =>
							when "100" =>
								heading := "110";
							when "101" =>
							when "110" =>
								heading := "000";
							when "111" =>
							when others =>
						end case;
						reset_ready := '1';
						key_ready := '1';
						switch_ready := '0';
					elsif(switch_ready = '1') then
						key_ready := '1';
						switch_ready := '0';
						reset_ready := '1';
					end if;
				when "00011101" =>    --W
					if(key_ready = '1') then
						case heading is
							when "000" =>
								down := '0';
								up   := '1';
								lft  := '0';
								rght := '0';
							when "001" =>
							when "010" =>
								down := '0';
								up   := '0';
								lft  := '0';
								rght := '1';
							when "011" =>
							when "100" =>
								down := '1';
								up   := '0';
								lft  := '0';
								rght := '0';
							when "101" =>
							when "110" =>
								down := '0';
								up   := '0';
								lft  := '1';
								rght := '0';
							when "111" =>
							when others =>
						end case;
						reset_ready := '1';
						key_ready := '1';
						switch_ready := '0';
					elsif(switch_ready = '1') then
						key_ready := '1';
						switch_ready := '0';
						reset_ready := '1';
					end if;
				when "00101001" =>    --spacebar
					if(key_ready = '1') then
						reset_ready := '1';
						key_ready := '1';
						switch_ready := '0';
						missile_out <= '1';
					elsif(switch_ready = '1') then
						key_ready := '1';
						switch_ready := '0';
						reset_ready := '1';
						missile_out <= '0';
					end if;
				when "11110000" =>    --F0
					reset_ready := '1';
					key_ready := '0';
					switch_ready := '1';
					missile_out <= '0';
					down := '0';
					up   := '0';
					lft  := '0';
					rght := '0';
				when others =>        --not recognized
					reset_ready := '1';
			end case;
		end if;
		reset_out <= reset_ready;   --send signal to rest of circuit indicating need to reset scan code
		action_out <= action_ready;
		heading_out <= heading;
	end process;
 
end Behavioral;  