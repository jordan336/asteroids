library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library asteroids;
use asteroids.types.all;

-- astsile entity
entity collision is
   Port ( reset,clk  : in std_logic;
		  astactive  : in astactivetype;
		  misactive  : in misactivetype;
		  astpos0    : in astpossingletype;
		  astpos1    : in astpossingletype;
		  astpos2    : in astpossingletype;
		  astpos3    : in astpossingletype;
		  astpos4    : in astpossingletype;
		  astpos5    : in astpossingletype;
		  mispos0    : in mispossingletype;
		  mispos1    : in mispossingletype;
		  mispos2    : in mispossingletype;
		  mispos3    : in mispossingletype;
		  mispos4    : in mispossingletype;
		  mispos5    : in mispossingletype;
		  mispos6    : in mispossingletype;
		  mispos7    : in mispossingletype;
		  collide    : out std_logic;
		  astcollide : out std_logic_vector(2 downto 0);
		  miscollide : out std_logic_vector(2 downto 0);
		  scoreones      : out std_logic_vector(4 downto 0);
		  scoretens      : out std_logic_vector(4 downto 0)  );  
end collision;

	
architecture Behavioral of collision is

	shared variable astpos : astpostype;
	shared variable mispos : mispostype;
	shared variable scorevar, tensvar, onesvar : std_logic_vector(4 downto 0);
	
begin

	collide_process : process(clk, reset)
		variable collis : std_logic;
	begin
		if(reset = '1') then
			collis := '0';
			scorevar := "00000";
			tensvar  := "00000";
			onesvar  := "00000";
		elsif(rising_edge(clk)) then
			tensvar := tensvar;
			
			astpos(0,0) := astpos0(0);
			astpos(0,1) := astpos0(1);
			astpos(1,0) := astpos1(0);
			astpos(1,1) := astpos1(1);
			astpos(2,0) := astpos2(0);
			astpos(2,1) := astpos2(1);
			astpos(3,0) := astpos3(0);
			astpos(3,1) := astpos3(1);
			astpos(4,0) := astpos4(0);
			astpos(4,1) := astpos4(1);
			astpos(5,0) := astpos5(0);
			astpos(5,1) := astpos5(1);
			
			mispos(0,0) := mispos0(0);
			mispos(0,1) := mispos0(1);
			mispos(1,0) := mispos1(0);
			mispos(1,1) := mispos1(1);
			mispos(2,0) := mispos2(0);
			mispos(2,1) := mispos2(1);
			mispos(3,0) := mispos3(0);
			mispos(3,1) := mispos3(1);
			mispos(4,0) := mispos4(0);
			mispos(4,1) := mispos4(1);
			mispos(5,0) := mispos5(0);
			mispos(5,1) := mispos5(1);
			mispos(6,0) := mispos6(0);
			mispos(6,1) := mispos6(1);
			mispos(7,0) := mispos7(0);
			mispos(7,1) := mispos7(1);
			
			collis := '0';
						
			if(misactive(0) = '1') then
				if(astactive(0) = '1') then    --asteroid in use
					if(((mispos(0, 0)+5 >= astpos(0, 0) and mispos(0, 0)+5 <= astpos(0, 0)+63) and ((mispos(0, 1)+5 <= astpos(0, 1)+63 and mispos(0, 1)+5 >= astpos(0, 1)) or (mispos(0, 1) >= astpos(0, 1) and mispos(0, 1) <= astpos(0, 1)+63))) or 
					   (((mispos(0, 0)   >= astpos(0, 0) and mispos(0, 0)    <= astpos(0, 0)+63) and ((mispos(0, 1)+5 <= astpos(0, 1)+63 and mispos(0, 1)+5 >= astpos(0, 1)) or (mispos(0, 1) >= astpos(0, 1) and mispos(0, 1) <= astpos(0, 1)+63))))) then
						collis := '1';
						astcollide <= "000";
						miscollide <= "000";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(1) = '1') then    --asteroid in use
					if(((mispos(0, 0)+5 >= astpos(1,0) and mispos(0, 0)+5 <= astpos(1,0)+63) and ((mispos(0, 1)+5 <= astpos(1,1)+63 and mispos(0, 1)+5 >= astpos(1,1)) or (mispos(0, 1) >= astpos(1,1) and mispos(0, 1) <= astpos(1,1)+63))) or 
					   (((mispos(0, 0)   >= astpos(1,0) and mispos(0, 0)    <= astpos(1,0)+63) and ((mispos(0, 1)+5 <= astpos(1,1)+63 and mispos(0, 1)+5 >= astpos(1,1)) or (mispos(0, 1) >= astpos(1,1) and mispos(0, 1) <= astpos(1,1)+63))))) then
						collis := '1';
						astcollide <= "001";
						miscollide <= "000";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(2) = '1') then    --asteroid in use
					if(((mispos(0, 0)+5 >= astpos(2,0) and mispos(0, 0)+5 <= astpos(2,0)+63) and ((mispos(0, 1)+5 <= astpos(2,1)+63 and mispos(0, 1)+5 >= astpos(2,1)) or (mispos(0, 1) >= astpos(2,1) and mispos(0, 1) <= astpos(2,1)+63))) or 
					   (((mispos(0, 0)   >= astpos(2,0) and mispos(0, 0)    <= astpos(2,0)+63) and ((mispos(0, 1)+5 <= astpos(2,1)+63 and mispos(0, 1)+5 >= astpos(2,1)) or (mispos(0, 1) >= astpos(2,1) and mispos(0, 1) <= astpos(2,1)+63))))) then
						collis := '1';
						astcollide <= "010";
						miscollide <= "000";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(3) = '1') then    --asteroid in use
					if(((mispos(0, 0)+5 >= astpos(3,0) and mispos(0, 0)+5 <= astpos(3,0)+63) and ((mispos(0, 1)+5 <= astpos(3,1)+63 and mispos(0, 1)+5 >= astpos(3,1)) or (mispos(0, 1) >= astpos(3,1) and mispos(0, 1) <= astpos(3,1)+63))) or 
					   (((mispos(0, 0)   >= astpos(3,0) and mispos(0, 0)    <= astpos(3,0)+63) and ((mispos(0, 1)+5 <= astpos(3,1)+63 and mispos(0, 1)+5 >= astpos(3,1)) or (mispos(0, 1) >= astpos(3,1) and mispos(0, 1) <= astpos(3,1)+63))))) then
						collis := '1';
						astcollide <= "011";
						miscollide <= "000";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(4) = '1') then    --asteroid in use
					if(((mispos(0, 0)+5 >= astpos(4,0) and mispos(0, 0)+5 <= astpos(4,0)+63) and ((mispos(0, 1)+5 <= astpos(4,1)+63 and mispos(0, 1)+5 >= astpos(4,1)) or (mispos(0, 1) >= astpos(4,1) and mispos(0, 1) <= astpos(4,1)+63))) or 
					   (((mispos(0, 0)   >= astpos(4,0) and mispos(0, 0)    <= astpos(4,0)+63) and ((mispos(0, 1)+5 <= astpos(4,1)+63 and mispos(0, 1)+5 >= astpos(4,1)) or (mispos(0, 1) >= astpos(4,1) and mispos(0, 1) <= astpos(4,1)+63))))) then
						collis := '1';
						astcollide <= "100";
						miscollide <= "000";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(5) = '1') then    --asteroid in use
					if(((mispos(0, 0)+5 >= astpos(5,0) and mispos(0, 0)+5 <= astpos(5,0)+63) and ((mispos(0, 1)+5 <= astpos(5,1)+63 and mispos(0, 1)+5 >= astpos(5,1)) or (mispos(0, 1) >= astpos(5,1) and mispos(0, 1) <= astpos(5,1)+63))) or 
					   (((mispos(0, 0)   >= astpos(5,0) and mispos(0, 0)    <= astpos(5,0)+63) and ((mispos(0, 1)+5 <= astpos(5,1)+63 and mispos(0, 1)+5 >= astpos(5,1)) or (mispos(0, 1) >= astpos(5,1) and mispos(0, 1) <= astpos(5,1)+63))))) then
						collis := '1';
						astcollide <= "101";
						miscollide <= "000";
						--scorevar := scorevar + "00001";
					end if;
				end if;
			end if;
			
			if(misactive(1) = '1') then
				if(astactive(0) = '1') then    --asteroid in use
					if(((mispos(1, 0)+5 >= astpos(0, 0) and mispos(1, 0)+5 <= astpos(0, 0)+63) and ((mispos(1, 1)+5 <= astpos(0, 1)+63 and mispos(1, 1)+5 >= astpos(0, 1)) or (mispos(1, 1) >= astpos(0, 1) and mispos(1, 1) <= astpos(0, 1)+63))) or 
					   (((mispos(1, 0)   >= astpos(0, 0) and mispos(1, 0)    <= astpos(0, 0)+63) and ((mispos(1, 1)+5 <= astpos(0, 1)+63 and mispos(1, 1)+5 >= astpos(0, 1)) or (mispos(1, 1) >= astpos(0, 1) and mispos(1, 1) <= astpos(0, 1)+63))))) then
						collis := '1';
						astcollide <= "000";
						miscollide <= "001";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(1) = '1') then    --asteroid in use
					if(((mispos(1, 0)+5 >= astpos(1,0) and mispos(1, 0)+5 <= astpos(1,0)+63) and ((mispos(1, 1)+5 <= astpos(1,1)+63 and mispos(1, 1)+5 >= astpos(1,1)) or (mispos(1, 1) >= astpos(1,1) and mispos(1, 1) <= astpos(1,1)+63))) or 
					   (((mispos(1, 0)   >= astpos(1,0) and mispos(1, 0)    <= astpos(1,0)+63) and ((mispos(1, 1)+5 <= astpos(1,1)+63 and mispos(1, 1)+5 >= astpos(1,1)) or (mispos(1, 1) >= astpos(1,1) and mispos(1, 1) <= astpos(1,1)+63))))) then
						collis := '1';
						astcollide <= "001";
						miscollide <= "001";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(2) = '1') then    --asteroid in use
					if(((mispos(1, 0)+5 >= astpos(2,0) and mispos(1, 0)+5 <= astpos(2,0)+63) and ((mispos(1, 1)+5 <= astpos(2,1)+63 and mispos(1, 1)+5 >= astpos(2,1)) or (mispos(1, 1) >= astpos(2,1) and mispos(1, 1) <= astpos(2,1)+63))) or 
					   (((mispos(1, 0)   >= astpos(2,0) and mispos(1, 0)    <= astpos(2,0)+63) and ((mispos(1, 1)+5 <= astpos(2,1)+63 and mispos(1, 1)+5 >= astpos(2,1)) or (mispos(1, 1) >= astpos(2,1) and mispos(1, 1) <= astpos(2,1)+63))))) then
						collis := '1';
						astcollide <= "010";
						miscollide <= "001";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(3) = '1') then    --asteroid in use
					if(((mispos(1, 0)+5 >= astpos(3,0) and mispos(1, 0)+5 <= astpos(3,0)+63) and ((mispos(1, 1)+5 <= astpos(3,1)+63 and mispos(1, 1)+5 >= astpos(3,1)) or (mispos(1, 1) >= astpos(3,1) and mispos(1, 1) <= astpos(3,1)+63))) or 
					   (((mispos(1, 0)   >= astpos(3,0) and mispos(1, 0)    <= astpos(3,0)+63) and ((mispos(1, 1)+5 <= astpos(3,1)+63 and mispos(1, 1)+5 >= astpos(3,1)) or (mispos(1, 1) >= astpos(3,1) and mispos(1, 1) <= astpos(3,1)+63))))) then
						collis := '1';
						astcollide <= "011";
						miscollide <= "001";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(4) = '1') then    --asteroid in use
					if(((mispos(1, 0)+5 >= astpos(4,0) and mispos(1, 0)+5 <= astpos(4,0)+63) and ((mispos(1, 1)+5 <= astpos(4,1)+63 and mispos(1, 1)+5 >= astpos(4,1)) or (mispos(1, 1) >= astpos(4,1) and mispos(1, 1) <= astpos(4,1)+63))) or 
					   (((mispos(1, 0)   >= astpos(4,0) and mispos(1, 0)    <= astpos(4,0)+63) and ((mispos(1, 1)+5 <= astpos(4,1)+63 and mispos(1, 1)+5 >= astpos(4,1)) or (mispos(1, 1) >= astpos(4,1) and mispos(1, 1) <= astpos(4,1)+63))))) then
						collis := '1';
						astcollide <= "100";
						miscollide <= "001";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(5) = '1') then    --asteroid in use
					if(((mispos(1, 0)+5 >= astpos(5,0) and mispos(1, 0)+5 <= astpos(5,0)+63) and ((mispos(1, 1)+5 <= astpos(5,1)+63 and mispos(1, 1)+5 >= astpos(5,1)) or (mispos(1, 1) >= astpos(5,1) and mispos(1, 1) <= astpos(5,1)+63))) or 
					   (((mispos(1, 0)   >= astpos(5,0) and mispos(1, 0)    <= astpos(5,0)+63) and ((mispos(1, 1)+5 <= astpos(5,1)+63 and mispos(1, 1)+5 >= astpos(5,1)) or (mispos(1, 1) >= astpos(5,1) and mispos(1, 1) <= astpos(5,1)+63))))) then
						collis := '1';
						astcollide <= "101";
						miscollide <= "001";
						--scorevar := scorevar + "00001";
					end if;
				end if;
			end if;
			
			if(misactive(2) = '1') then
				if(astactive(0) = '1') then    --asteroid in use
					if(((mispos(2, 0)+5 >= astpos(0, 0) and mispos(2, 0)+5 <= astpos(0, 0)+63) and ((mispos(2, 1)+5 <= astpos(0, 1)+63 and mispos(2, 1)+5 >= astpos(0, 1)) or (mispos(2, 1) >= astpos(0, 1) and mispos(2, 1) <= astpos(0, 1)+63))) or 
					   (((mispos(2, 0)   >= astpos(0, 0) and mispos(2, 0)    <= astpos(0, 0)+63) and ((mispos(2, 1)+5 <= astpos(0, 1)+63 and mispos(2, 1)+5 >= astpos(0, 1)) or (mispos(2, 1) >= astpos(0, 1) and mispos(2, 1) <= astpos(0, 1)+63))))) then
						collis := '1';
						astcollide <= "000";
						miscollide <= "010";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(1) = '1') then    --asteroid in use
					if(((mispos(2, 0)+5 >= astpos(1,0) and mispos(2, 0)+5 <= astpos(1,0)+63) and ((mispos(2, 1)+5 <= astpos(1,1)+63 and mispos(2, 1)+5 >= astpos(1,1)) or (mispos(2, 1) >= astpos(1,1) and mispos(2, 1) <= astpos(1,1)+63))) or 
					   (((mispos(2, 0)   >= astpos(1,0) and mispos(2, 0)    <= astpos(1,0)+63) and ((mispos(2, 1)+5 <= astpos(1,1)+63 and mispos(2, 1)+5 >= astpos(1,1)) or (mispos(2, 1) >= astpos(1,1) and mispos(2, 1) <= astpos(1,1)+63))))) then
						collis := '1';
						astcollide <= "001";
						miscollide <= "010";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(2) = '1') then    --asteroid in use
					if(((mispos(2, 0)+5 >= astpos(2,0) and mispos(2, 0)+5 <= astpos(2,0)+63) and ((mispos(2, 1)+5 <= astpos(2,1)+63 and mispos(2, 1)+5 >= astpos(2,1)) or (mispos(2, 1) >= astpos(2,1) and mispos(2, 1) <= astpos(2,1)+63))) or 
					   (((mispos(2, 0)   >= astpos(2,0) and mispos(2, 0)    <= astpos(2,0)+63) and ((mispos(2, 1)+5 <= astpos(2,1)+63 and mispos(2, 1)+5 >= astpos(2,1)) or (mispos(2, 1) >= astpos(2,1) and mispos(2, 1) <= astpos(2,1)+63))))) then
						collis := '1';
						astcollide <= "010";
						miscollide <= "010";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(3) = '1') then    --asteroid in use
					if(((mispos(2, 0)+5 >= astpos(3,0) and mispos(2, 0)+5 <= astpos(3,0)+63) and ((mispos(2, 1)+5 <= astpos(3,1)+63 and mispos(2, 1)+5 >= astpos(3,1)) or (mispos(2, 1) >= astpos(3,1) and mispos(2, 1) <= astpos(3,1)+63))) or 
					   (((mispos(2, 0)   >= astpos(3,0) and mispos(2, 0)    <= astpos(3,0)+63) and ((mispos(2, 1)+5 <= astpos(3,1)+63 and mispos(2, 1)+5 >= astpos(3,1)) or (mispos(2, 1) >= astpos(3,1) and mispos(2, 1) <= astpos(3,1)+63))))) then
						collis := '1';
						astcollide <= "011";
						miscollide <= "010";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(4) = '1') then    --asteroid in use
					if(((mispos(2, 0)+5 >= astpos(4,0) and mispos(2, 0)+5 <= astpos(4,0)+63) and ((mispos(2, 1)+5 <= astpos(4,1)+63 and mispos(2, 1)+5 >= astpos(4,1)) or (mispos(2, 1) >= astpos(4,1) and mispos(2, 1) <= astpos(4,1)+63))) or 
					   (((mispos(2, 0)   >= astpos(4,0) and mispos(2, 0)    <= astpos(4,0)+63) and ((mispos(2, 1)+5 <= astpos(4,1)+63 and mispos(2, 1)+5 >= astpos(4,1)) or (mispos(2, 1) >= astpos(4,1) and mispos(2, 1) <= astpos(4,1)+63))))) then
						collis := '1';
						astcollide <= "100";
						miscollide <= "010";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(5) = '1') then    --asteroid in use
					if(((mispos(2, 0)+5 >= astpos(5,0) and mispos(2, 0)+5 <= astpos(5,0)+63) and ((mispos(2, 1)+5 <= astpos(5,1)+63 and mispos(2, 1)+5 >= astpos(5,1)) or (mispos(2, 1) >= astpos(5,1) and mispos(2, 1) <= astpos(5,1)+63))) or 
					   (((mispos(2, 0)   >= astpos(5,0) and mispos(2, 0)    <= astpos(5,0)+63) and ((mispos(2, 1)+5 <= astpos(5,1)+63 and mispos(2, 1)+5 >= astpos(5,1)) or (mispos(2, 1) >= astpos(5,1) and mispos(2, 1) <= astpos(5,1)+63))))) then
						collis := '1';
						astcollide <= "101";
						miscollide <= "010";
						--scorevar := scorevar + "00001";
					end if;
				end if;
			end if;
			
			if(misactive(3) = '1') then
				if(astactive(0) = '1') then    --asteroid in use
					if(((mispos(3, 0)+5 >= astpos(0, 0) and mispos(3, 0)+5 <= astpos(0, 0)+63) and ((mispos(3, 1)+5 <= astpos(0, 1)+63 and mispos(3, 1)+5 >= astpos(0, 1)) or (mispos(3, 1) >= astpos(0, 1) and mispos(3, 1) <= astpos(0, 1)+63))) or 
					   (((mispos(3, 0)   >= astpos(0, 0) and mispos(3, 0)    <= astpos(0, 0)+63) and ((mispos(3, 1)+5 <= astpos(0, 1)+63 and mispos(3, 1)+5 >= astpos(0, 1)) or (mispos(3, 1) >= astpos(0, 1) and mispos(3, 1) <= astpos(0, 1)+63))))) then
						collis := '1';
						astcollide <= "000";
						miscollide <= "011";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(1) = '1') then    --asteroid in use
					if(((mispos(3, 0)+5 >= astpos(1,0) and mispos(3, 0)+5 <= astpos(1,0)+63) and ((mispos(3, 1)+5 <= astpos(1,1)+63 and mispos(3, 1)+5 >= astpos(1,1)) or (mispos(3, 1) >= astpos(1,1) and mispos(3, 1) <= astpos(1,1)+63))) or 
					   (((mispos(3, 0)   >= astpos(1,0) and mispos(3, 0)    <= astpos(1,0)+63) and ((mispos(3, 1)+5 <= astpos(1,1)+63 and mispos(3, 1)+5 >= astpos(1,1)) or (mispos(3, 1) >= astpos(1,1) and mispos(3, 1) <= astpos(1,1)+63))))) then
						collis := '1';
						astcollide <= "001";
						miscollide <= "011";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(2) = '1') then    --asteroid in use
					if(((mispos(3, 0)+5 >= astpos(2,0) and mispos(3, 0)+5 <= astpos(2,0)+63) and ((mispos(3, 1)+5 <= astpos(2,1)+63 and mispos(3, 1)+5 >= astpos(2,1)) or (mispos(3, 1) >= astpos(2,1) and mispos(3, 1) <= astpos(2,1)+63))) or 
					   (((mispos(3, 0)   >= astpos(2,0) and mispos(3, 0)    <= astpos(2,0)+63) and ((mispos(3, 1)+5 <= astpos(2,1)+63 and mispos(3, 1)+5 >= astpos(2,1)) or (mispos(3, 1) >= astpos(2,1) and mispos(3, 1) <= astpos(2,1)+63))))) then
						collis := '1';
						astcollide <= "010";
						miscollide <= "011";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(3) = '1') then    --asteroid in use
					if(((mispos(3, 0)+5 >= astpos(3,0) and mispos(3, 0)+5 <= astpos(3,0)+63) and ((mispos(3, 1)+5 <= astpos(3,1)+63 and mispos(3, 1)+5 >= astpos(3,1)) or (mispos(3, 1) >= astpos(3,1) and mispos(3, 1) <= astpos(3,1)+63))) or 
					   (((mispos(3, 0)   >= astpos(3,0) and mispos(3, 0)    <= astpos(3,0)+63) and ((mispos(3, 1)+5 <= astpos(3,1)+63 and mispos(3, 1)+5 >= astpos(3,1)) or (mispos(3, 1) >= astpos(3,1) and mispos(3, 1) <= astpos(3,1)+63))))) then
						collis := '1';
						astcollide <= "011";
						miscollide <= "011";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(4) = '1') then    --asteroid in use
					if(((mispos(3, 0)+5 >= astpos(4,0) and mispos(3, 0)+5 <= astpos(4,0)+63) and ((mispos(3, 1)+5 <= astpos(4,1)+63 and mispos(3, 1)+5 >= astpos(4,1)) or (mispos(3, 1) >= astpos(4,1) and mispos(3, 1) <= astpos(4,1)+63))) or 
					   (((mispos(3, 0)   >= astpos(4,0) and mispos(3, 0)    <= astpos(4,0)+63) and ((mispos(3, 1)+5 <= astpos(4,1)+63 and mispos(3, 1)+5 >= astpos(4,1)) or (mispos(3, 1) >= astpos(4,1) and mispos(3, 1) <= astpos(4,1)+63))))) then
						collis := '1';
						astcollide <= "100";
						miscollide <= "011";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(5) = '1') then    --asteroid in use
					if(((mispos(3, 0)+5 >= astpos(5,0) and mispos(3, 0)+5 <= astpos(5,0)+63) and ((mispos(3, 1)+5 <= astpos(5,1)+63 and mispos(3, 1)+5 >= astpos(5,1)) or (mispos(3, 1) >= astpos(5,1) and mispos(3, 1) <= astpos(5,1)+63))) or 
					   (((mispos(3, 0)   >= astpos(5,0) and mispos(3, 0)    <= astpos(5,0)+63) and ((mispos(3, 1)+5 <= astpos(5,1)+63 and mispos(3, 1)+5 >= astpos(5,1)) or (mispos(3, 1) >= astpos(5,1) and mispos(3, 1) <= astpos(5,1)+63))))) then
						collis := '1';
						astcollide <= "101";
						miscollide <= "011";
						--scorevar := scorevar + "00001";
					end if;
				end if;
			end if;
			
			if(misactive(4) = '1') then
				if(astactive(0) = '1') then    --asteroid in use
					if(((mispos(4, 0)+5 >= astpos(0, 0) and mispos(4, 0)+5 <= astpos(0, 0)+63) and ((mispos(4, 1)+5 <= astpos(0, 1)+63 and mispos(4, 1)+5 >= astpos(0, 1)) or (mispos(4, 1) >= astpos(0, 1) and mispos(4, 1) <= astpos(0, 1)+63))) or 
					   (((mispos(4, 0)   >= astpos(0, 0) and mispos(4, 0)    <= astpos(0, 0)+63) and ((mispos(4, 1)+5 <= astpos(0, 1)+63 and mispos(4, 1)+5 >= astpos(0, 1)) or (mispos(4, 1) >= astpos(0, 1) and mispos(4, 1) <= astpos(0, 1)+63))))) then
						collis := '1';
						astcollide <= "000";
						miscollide <= "100";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(1) = '1') then    --asteroid in use
					if(((mispos(4, 0)+5 >= astpos(1,0) and mispos(4, 0)+5 <= astpos(1,0)+63) and ((mispos(4, 1)+5 <= astpos(1,1)+63 and mispos(4, 1)+5 >= astpos(1,1)) or (mispos(4, 1) >= astpos(1,1) and mispos(4, 1) <= astpos(1,1)+63))) or 
					   (((mispos(4, 0)   >= astpos(1,0) and mispos(4, 0)    <= astpos(1,0)+63) and ((mispos(4, 1)+5 <= astpos(1,1)+63 and mispos(4, 1)+5 >= astpos(1,1)) or (mispos(4, 1) >= astpos(1,1) and mispos(4, 1) <= astpos(1,1)+63))))) then
						collis := '1';
						astcollide <= "001";
						miscollide <= "100";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(2) = '1') then    --asteroid in use
					if(((mispos(4, 0)+5 >= astpos(2,0) and mispos(4, 0)+5 <= astpos(2,0)+63) and ((mispos(4, 1)+5 <= astpos(2,1)+63 and mispos(4, 1)+5 >= astpos(2,1)) or (mispos(4, 1) >= astpos(2,1) and mispos(4, 1) <= astpos(2,1)+63))) or 
					   (((mispos(4, 0)   >= astpos(2,0) and mispos(4, 0)    <= astpos(2,0)+63) and ((mispos(4, 1)+5 <= astpos(2,1)+63 and mispos(4, 1)+5 >= astpos(2,1)) or (mispos(4, 1) >= astpos(2,1) and mispos(4, 1) <= astpos(2,1)+63))))) then
						collis := '1';
						astcollide <= "010";
						miscollide <= "100";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(3) = '1') then    --asteroid in use
					if(((mispos(4, 0)+5 >= astpos(3,0) and mispos(4, 0)+5 <= astpos(3,0)+63) and ((mispos(4, 1)+5 <= astpos(3,1)+63 and mispos(4, 1)+5 >= astpos(3,1)) or (mispos(4, 1) >= astpos(3,1) and mispos(4, 1) <= astpos(3,1)+63))) or 
					   (((mispos(4, 0)   >= astpos(3,0) and mispos(4, 0)    <= astpos(3,0)+63) and ((mispos(4, 1)+5 <= astpos(3,1)+63 and mispos(4, 1)+5 >= astpos(3,1)) or (mispos(4, 1) >= astpos(3,1) and mispos(4, 1) <= astpos(3,1)+63))))) then
						collis := '1';
						astcollide <= "011";
						miscollide <= "100";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(4) = '1') then    --asteroid in use
					if(((mispos(4, 0)+5 >= astpos(4,0) and mispos(4, 0)+5 <= astpos(4,0)+63) and ((mispos(4, 1)+5 <= astpos(4,1)+63 and mispos(4, 1)+5 >= astpos(4,1)) or (mispos(4, 1) >= astpos(4,1) and mispos(4, 1) <= astpos(4,1)+63))) or 
					   (((mispos(4, 0)   >= astpos(4,0) and mispos(4, 0)    <= astpos(4,0)+63) and ((mispos(4, 1)+5 <= astpos(4,1)+63 and mispos(4, 1)+5 >= astpos(4,1)) or (mispos(4, 1) >= astpos(4,1) and mispos(4, 1) <= astpos(4,1)+63))))) then
						collis := '1';
						astcollide <= "100";
						miscollide <= "100";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(5) = '1') then    --asteroid in use
					if(((mispos(4, 0)+5 >= astpos(5,0) and mispos(4, 0)+5 <= astpos(5,0)+63) and ((mispos(4, 1)+5 <= astpos(5,1)+63 and mispos(4, 1)+5 >= astpos(5,1)) or (mispos(4, 1) >= astpos(5,1) and mispos(4, 1) <= astpos(5,1)+63))) or 
					   (((mispos(4, 0)   >= astpos(5,0) and mispos(4, 0)    <= astpos(5,0)+63) and ((mispos(4, 1)+5 <= astpos(5,1)+63 and mispos(4, 1)+5 >= astpos(5,1)) or (mispos(4, 1) >= astpos(5,1) and mispos(4, 1) <= astpos(5,1)+63))))) then
						collis := '1';
						astcollide <= "101";
						miscollide <= "100";
						--scorevar := scorevar + "00001";
					end if;
				end if;
			end if;
			
			if(misactive(5) = '1') then
				if(astactive(0) = '1') then    --asteroid in use
					if(((mispos(5, 0)+5 >= astpos(0, 0) and mispos(5, 0)+5 <= astpos(0, 0)+63) and ((mispos(5, 1)+5 <= astpos(0, 1)+63 and mispos(5, 1)+5 >= astpos(0, 1)) or (mispos(5, 1) >= astpos(0, 1) and mispos(5, 1) <= astpos(0, 1)+63))) or 
					   (((mispos(5, 0)   >= astpos(0, 0) and mispos(5, 0)    <= astpos(0, 0)+63) and ((mispos(5, 1)+5 <= astpos(0, 1)+63 and mispos(5, 1)+5 >= astpos(0, 1)) or (mispos(5, 1) >= astpos(0, 1) and mispos(5, 1) <= astpos(0, 1)+63))))) then
						collis := '1';
						astcollide <= "000";
						miscollide <= "101";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(1) = '1') then    --asteroid in use
					if(((mispos(5, 0)+5 >= astpos(1,0) and mispos(5, 0)+5 <= astpos(1,0)+63) and ((mispos(5, 1)+5 <= astpos(1,1)+63 and mispos(5, 1)+5 >= astpos(1,1)) or (mispos(5, 1) >= astpos(1,1) and mispos(5, 1) <= astpos(1,1)+63))) or 
					   (((mispos(5, 0)   >= astpos(1,0) and mispos(5, 0)    <= astpos(1,0)+63) and ((mispos(5, 1)+5 <= astpos(1,1)+63 and mispos(5, 1)+5 >= astpos(1,1)) or (mispos(5, 1) >= astpos(1,1) and mispos(5, 1) <= astpos(1,1)+63))))) then
						collis := '1';
						astcollide <= "001";
						miscollide <= "101";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(2) = '1') then    --asteroid in use
					if(((mispos(5, 0)+5 >= astpos(2,0) and mispos(5, 0)+5 <= astpos(2,0)+63) and ((mispos(5, 1)+5 <= astpos(2,1)+63 and mispos(5, 1)+5 >= astpos(2,1)) or (mispos(5, 1) >= astpos(2,1) and mispos(5, 1) <= astpos(2,1)+63))) or 
					   (((mispos(5, 0)   >= astpos(2,0) and mispos(5, 0)    <= astpos(2,0)+63) and ((mispos(5, 1)+5 <= astpos(2,1)+63 and mispos(5, 1)+5 >= astpos(2,1)) or (mispos(5, 1) >= astpos(2,1) and mispos(5, 1) <= astpos(2,1)+63))))) then
						collis := '1';
						astcollide <= "010";
						miscollide <= "101";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(3) = '1') then    --asteroid in use
					if(((mispos(5, 0)+5 >= astpos(3,0) and mispos(5, 0)+5 <= astpos(3,0)+63) and ((mispos(5, 1)+5 <= astpos(3,1)+63 and mispos(5, 1)+5 >= astpos(3,1)) or (mispos(5, 1) >= astpos(3,1) and mispos(5, 1) <= astpos(3,1)+63))) or 
					   (((mispos(5, 0)   >= astpos(3,0) and mispos(5, 0)    <= astpos(3,0)+63) and ((mispos(5, 1)+5 <= astpos(3,1)+63 and mispos(5, 1)+5 >= astpos(3,1)) or (mispos(5, 1) >= astpos(3,1) and mispos(5, 1) <= astpos(3,1)+63))))) then
						collis := '1';
						astcollide <= "011";
						miscollide <= "101";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(4) = '1') then    --asteroid in use
					if(((mispos(5, 0)+5 >= astpos(4,0) and mispos(5, 0)+5 <= astpos(4,0)+63) and ((mispos(5, 1)+5 <= astpos(4,1)+63 and mispos(5, 1)+5 >= astpos(4,1)) or (mispos(5, 1) >= astpos(4,1) and mispos(5, 1) <= astpos(4,1)+63))) or 
					   (((mispos(5, 0)   >= astpos(4,0) and mispos(5, 0)    <= astpos(4,0)+63) and ((mispos(5, 1)+5 <= astpos(4,1)+63 and mispos(5, 1)+5 >= astpos(4,1)) or (mispos(5, 1) >= astpos(4,1) and mispos(5, 1) <= astpos(4,1)+63))))) then
						collis := '1';
						astcollide <= "100";
						miscollide <= "101";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(5) = '1') then    --asteroid in use
					if(((mispos(5, 0)+5 >= astpos(5,0) and mispos(5, 0)+5 <= astpos(5,0)+63) and ((mispos(5, 1)+5 <= astpos(5,1)+63 and mispos(5, 1)+5 >= astpos(5,1)) or (mispos(5, 1) >= astpos(5,1) and mispos(5, 1) <= astpos(5,1)+63))) or 
					   (((mispos(5, 0)   >= astpos(5,0) and mispos(5, 0)    <= astpos(5,0)+63) and ((mispos(5, 1)+5 <= astpos(5,1)+63 and mispos(5, 1)+5 >= astpos(5,1)) or (mispos(5, 1) >= astpos(5,1) and mispos(5, 1) <= astpos(5,1)+63))))) then
						collis := '1';
						astcollide <= "101";
						miscollide <= "101";
						--scorevar := scorevar + "00001";
					end if;
				end if;
			end if;
			
			if(misactive(6) = '1') then
				if(astactive(0) = '1') then    --asteroid in use
					if(((mispos(6, 0)+5 >= astpos(0, 0) and mispos(6, 0)+5 <= astpos(0, 0)+63) and ((mispos(6, 1)+5 <= astpos(0, 1)+63 and mispos(6, 1)+5 >= astpos(0, 1)) or (mispos(6, 1) >= astpos(0, 1) and mispos(6, 1) <= astpos(0, 1)+63))) or 
					   (((mispos(6, 0)   >= astpos(0, 0) and mispos(6, 0)    <= astpos(0, 0)+63) and ((mispos(6, 1)+5 <= astpos(0, 1)+63 and mispos(6, 1)+5 >= astpos(0, 1)) or (mispos(6, 1) >= astpos(0, 1) and mispos(6, 1) <= astpos(0, 1)+63))))) then
						collis := '1';
						astcollide <= "000";
						miscollide <= "110";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(1) = '1') then    --asteroid in use
					if(((mispos(6, 0)+5 >= astpos(1,0) and mispos(6, 0)+5 <= astpos(1,0)+63) and ((mispos(6, 1)+5 <= astpos(1,1)+63 and mispos(6, 1)+5 >= astpos(1,1)) or (mispos(6, 1) >= astpos(1,1) and mispos(6, 1) <= astpos(1,1)+63))) or 
					   (((mispos(6, 0)   >= astpos(1,0) and mispos(6, 0)    <= astpos(1,0)+63) and ((mispos(6, 1)+5 <= astpos(1,1)+63 and mispos(6, 1)+5 >= astpos(1,1)) or (mispos(6, 1) >= astpos(1,1) and mispos(6, 1) <= astpos(1,1)+63))))) then
						collis := '1';
						astcollide <= "001";
						miscollide <= "110";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(2) = '1') then    --asteroid in use
					if(((mispos(6, 0)+5 >= astpos(2,0) and mispos(6, 0)+5 <= astpos(2,0)+63) and ((mispos(6, 1)+5 <= astpos(2,1)+63 and mispos(6, 1)+5 >= astpos(2,1)) or (mispos(6, 1) >= astpos(2,1) and mispos(6, 1) <= astpos(2,1)+63))) or 
					   (((mispos(6, 0)   >= astpos(2,0) and mispos(6, 0)    <= astpos(2,0)+63) and ((mispos(6, 1)+5 <= astpos(2,1)+63 and mispos(6, 1)+5 >= astpos(2,1)) or (mispos(6, 1) >= astpos(2,1) and mispos(6, 1) <= astpos(2,1)+63))))) then
						collis := '1';
						astcollide <= "010";
						miscollide <= "110";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(3) = '1') then    --asteroid in use
					if(((mispos(6, 0)+5 >= astpos(3,0) and mispos(6, 0)+5 <= astpos(3,0)+63) and ((mispos(6, 1)+5 <= astpos(3,1)+63 and mispos(6, 1)+5 >= astpos(3,1)) or (mispos(6, 1) >= astpos(3,1) and mispos(6, 1) <= astpos(3,1)+63))) or 
					   (((mispos(6, 0)   >= astpos(3,0) and mispos(6, 0)    <= astpos(3,0)+63) and ((mispos(6, 1)+5 <= astpos(3,1)+63 and mispos(6, 1)+5 >= astpos(3,1)) or (mispos(6, 1) >= astpos(3,1) and mispos(6, 1) <= astpos(3,1)+63))))) then
						collis := '1';
						astcollide <= "011";
						miscollide <= "110";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(4) = '1') then    --asteroid in use
					if(((mispos(6, 0)+5 >= astpos(4,0) and mispos(6, 0)+5 <= astpos(4,0)+63) and ((mispos(6, 1)+5 <= astpos(4,1)+63 and mispos(6, 1)+5 >= astpos(4,1)) or (mispos(6, 1) >= astpos(4,1) and mispos(6, 1) <= astpos(4,1)+63))) or 
					   (((mispos(6, 0)   >= astpos(4,0) and mispos(6, 0)    <= astpos(4,0)+63) and ((mispos(6, 1)+5 <= astpos(4,1)+63 and mispos(6, 1)+5 >= astpos(4,1)) or (mispos(6, 1) >= astpos(4,1) and mispos(6, 1) <= astpos(4,1)+63))))) then
						collis := '1';
						astcollide <= "100";
						miscollide <= "110";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(5) = '1') then    --asteroid in use
					if(((mispos(6, 0)+5 >= astpos(5,0) and mispos(6, 0)+5 <= astpos(5,0)+63) and ((mispos(6, 1)+5 <= astpos(5,1)+63 and mispos(6, 1)+5 >= astpos(5,1)) or (mispos(6, 1) >= astpos(5,1) and mispos(6, 1) <= astpos(5,1)+63))) or 
					   (((mispos(6, 0)   >= astpos(5,0) and mispos(6, 0)    <= astpos(5,0)+63) and ((mispos(6, 1)+5 <= astpos(5,1)+63 and mispos(6, 1)+5 >= astpos(5,1)) or (mispos(6, 1) >= astpos(5,1) and mispos(6, 1) <= astpos(5,1)+63))))) then
						collis := '1';
						astcollide <= "101";
						miscollide <= "110";
						--scorevar := scorevar + "00001";
					end if;
				end if;
			end if;
			
			if(misactive(7) = '1') then
				if(astactive(0) = '1') then    --asteroid in use
					if(((mispos(7, 0)+5 >= astpos(0, 0) and mispos(7, 0)+5 <= astpos(0, 0)+63) and ((mispos(7, 1)+5 <= astpos(0, 1)+63 and mispos(7, 1)+5 >= astpos(0, 1)) or (mispos(7, 1) >= astpos(0, 1) and mispos(7, 1) <= astpos(0, 1)+63))) or 
					   (((mispos(7, 0)   >= astpos(0, 0) and mispos(7, 0)    <= astpos(0, 0)+63) and ((mispos(7, 1)+5 <= astpos(0, 1)+63 and mispos(7, 1)+5 >= astpos(0, 1)) or (mispos(7, 1) >= astpos(0, 1) and mispos(7, 1) <= astpos(0, 1)+63))))) then
						collis := '1';
						astcollide <= "000";
						miscollide <= "111";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(1) = '1') then    --asteroid in use
					if(((mispos(7, 0)+5 >= astpos(1,0) and mispos(7, 0)+5 <= astpos(1,0)+63) and ((mispos(7, 1)+5 <= astpos(1,1)+63 and mispos(7, 1)+5 >= astpos(1,1)) or (mispos(7, 1) >= astpos(1,1) and mispos(7, 1) <= astpos(1,1)+63))) or 
					   (((mispos(7, 0)   >= astpos(1,0) and mispos(7, 0)    <= astpos(1,0)+63) and ((mispos(7, 1)+5 <= astpos(1,1)+63 and mispos(7, 1)+5 >= astpos(1,1)) or (mispos(7, 1) >= astpos(1,1) and mispos(7, 1) <= astpos(1,1)+63))))) then
						collis := '1';
						astcollide <= "001";
						miscollide <= "111";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(2) = '1') then    --asteroid in use
					if(((mispos(7, 0)+5 >= astpos(2,0) and mispos(7, 0)+5 <= astpos(2,0)+63) and ((mispos(7, 1)+5 <= astpos(2,1)+63 and mispos(7, 1)+5 >= astpos(2,1)) or (mispos(7, 1) >= astpos(2,1) and mispos(7, 1) <= astpos(2,1)+63))) or 
					   (((mispos(7, 0)   >= astpos(2,0) and mispos(7, 0)    <= astpos(2,0)+63) and ((mispos(7, 1)+5 <= astpos(2,1)+63 and mispos(7, 1)+5 >= astpos(2,1)) or (mispos(7, 1) >= astpos(2,1) and mispos(7, 1) <= astpos(2,1)+63))))) then
						collis := '1';
						astcollide <= "010";
						miscollide <= "111";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(3) = '1') then    --asteroid in use
					if(((mispos(7, 0)+5 >= astpos(3,0) and mispos(7, 0)+5 <= astpos(3,0)+63) and ((mispos(7, 1)+5 <= astpos(3,1)+63 and mispos(7, 1)+5 >= astpos(3,1)) or (mispos(7, 1) >= astpos(3,1) and mispos(7, 1) <= astpos(3,1)+63))) or 
					   (((mispos(7, 0)   >= astpos(3,0) and mispos(7, 0)    <= astpos(3,0)+63) and ((mispos(7, 1)+5 <= astpos(3,1)+63 and mispos(7, 1)+5 >= astpos(3,1)) or (mispos(7, 1) >= astpos(3,1) and mispos(7, 1) <= astpos(3,1)+63))))) then
						collis := '1';
						astcollide <= "011";
						miscollide <= "111";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(4) = '1') then    --asteroid in use
					if(((mispos(7, 0)+5 >= astpos(4,0) and mispos(7, 0)+5 <= astpos(4,0)+63) and ((mispos(7, 1)+5 <= astpos(4,1)+63 and mispos(7, 1)+5 >= astpos(4,1)) or (mispos(7, 1) >= astpos(4,1) and mispos(7, 1) <= astpos(4,1)+63))) or 
					   (((mispos(7, 0)   >= astpos(4,0) and mispos(7, 0)    <= astpos(4,0)+63) and ((mispos(7, 1)+5 <= astpos(4,1)+63 and mispos(7, 1)+5 >= astpos(4,1)) or (mispos(7, 1) >= astpos(4,1) and mispos(7, 1) <= astpos(4,1)+63))))) then
						collis := '1';
						astcollide <= "100";
						miscollide <= "111";
						--scorevar := scorevar + "00001";
					end if;
				end if;
				
				if(astactive(5) = '1') then    --asteroid in use
					if(((mispos(7, 0)+5 >= astpos(5,0) and mispos(7, 0)+5 <= astpos(5,0)+63) and ((mispos(7, 1)+5 <= astpos(5,1)+63 and mispos(7, 1)+5 >= astpos(5,1)) or (mispos(7, 1) >= astpos(5,1) and mispos(7, 1) <= astpos(5,1)+63))) or 
					   (((mispos(7, 0)   >= astpos(5,0) and mispos(7, 0)    <= astpos(5,0)+63) and ((mispos(7, 1)+5 <= astpos(5,1)+63 and mispos(7, 1)+5 >= astpos(5,1)) or (mispos(7, 1) >= astpos(5,1) and mispos(7, 1) <= astpos(5,1)+63))))) then
						collis := '1';
						astcollide <= "101";
						miscollide <= "111";
						--scorevar := scorevar + "00001";
					end if;
				end if;
			end if;
			collide <= collis;
			if(collis = '1') then
				scorevar := scorevar + "00001";
				if(scorevar = "00010") then
					onesvar := onesvar + "00001";
					scorevar := "00000";
				end if;
				if(onesvar >= "01010") then
					tensvar  := tensvar + "00001";
					onesvar  := "00000";
					--scorevar := "00000";
				end if;
			end if;
			scoreones   <= onesvar;   --scorevar;
			scoretens   <= tensvar;
		end if;
	end process;

end Behavioral;