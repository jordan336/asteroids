library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library asteroids;
use asteroids.types.all;

-- astsile entity
entity state_machine is
   Port ( reset  : in std_logic;
		  clk : in std_logic;
		  spacebar : in std_logic;
		  shipCollision : in std_logic;
		  stateOut : out std_logic_vector(1 downto 0);
		  resetOut, shipReset : out std_logic );
end state_machine;
	
	
architecture Behavioral of state_machine is

type ctrl_state is (start, three, two, one, startout, threeout, twoout, oneout);
signal state, next_state : ctrl_state;

begin

assign_next_state : process (clk, reset)
begin
  if (reset = '1') then
    state      <= start;
  elsif (rising_edge(clk)) then
    state <= next_state;
  end if;
end process;

get_next_state : process (state, spacebar, shipCollision) --, clk, reset)
begin
	--if(reset = '1') then
	--	next_state <= start;
	--elsif(rising_edge(clk)) then
		case state is
			when start => 
				if (spacebar = '1') then
					next_state <= startout;
				else
					next_state <= start;
				end if;
			when startout =>
				next_state <= three;
			when three =>
				if (shipCollision = '0') then
					next_state <= three;
				else
					next_state <= threeout;
				end if;
			when threeout =>
				next_state <= two;
			when two =>
				if (shipCollision = '0') then
					next_state <= two;
				else
					next_state <= twoout;
				end if;
			when twoout =>
				next_state <= one;
			when one =>
				if (shipCollision = '0') then
					next_state <= one;
				else
					next_state <= oneout;
				end if;
			when oneout =>
				next_state <= start;
		end case;
	--end if;
end process;    
    
    
Assign_Control_Signals : process (state)  --clk, reset, state)
variable shipVar, resetVar : std_logic;
variable stateVar : std_logic_vector(1 downto 0);
begin
	  --if (reset = '1') then
	  --stateVar := "00";
	--	shipVar  := '0';
		--resetVar := '0';
	  --elsif (rising_edge(clk)) then
			case state is
				when start => 
					stateVar := "00";
					resetVar := '0';
					shipVar  := '0';
				when startout =>
					stateVar := "00";
					resetVar := '1';
					shipVar  := '1';
				when three =>
					stateVar := "11";
					resetVar := '0';
					shipVar  := '0';
				when threeout =>
					stateVar := "11";
					shipVar  := '1';
					resetVar := '0';
				when two =>
					stateVar := "10";
					shipVar  := '0';
					resetVar := '0';
				when twoout =>
					stateVar := "10";
					shipVar  := '1';
					resetVar := '0';
				when one =>
					stateVar := "01";
					shipVar  := '0';
					resetVar := '0';
				when oneout =>
					stateVar := "01";
					shipVar  := '1';
					resetVar := '0';
			end case;
			shipReset <= shipVar;
			resetOut  <= resetVar;
			stateOut  <= stateVar;
		--end if;
end process;    
    
    
    
    
end Behavioral;











