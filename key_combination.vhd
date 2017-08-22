library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity for combinational logic providing interface between register and rest of circuit
entity key_combination is
	port( reg_contents : in std_logic_vector(10 downto 0);
		  clk, inside_send, reset_scancode, reset : in std_logic;
		  scancode : out std_logic_vector(7 downto 0); 
		  new_key : out std_logic );
end key_combination;

architecture behavioral of key_combination is 

	component d_flip_flop is
		port( D, clk : in std_logic;
			Q : out std_logic );
	end component d_flip_flop;
	
	signal new_key_signal : std_logic;
	signal bits : std_logic_vector(2 downto 0);
	
	begin
	flip : d_flip_flop port map(clk=>clk, D=>new_key_signal, Q=>new_key);   --remembers if a new key is available
	
	process(clk, reset_scancode, reg_contents, inside_send, bits)
	begin
		bits <= reg_contents(0) & reg_contents(10) & inside_send;   --looking for start and stop bits, as well as not being inside a sending cycle
		if(reset_scancode = '1') then
			new_key_signal <= '0';   --scan code needs to be reset, so new key is not available
		elsif(bits = "010") then     --new scancode is ready since start / stop bits in place and not inside a sending cycle
			new_key_signal <= '1';
		else
			new_key_signal <= '0';
		end if;
		scancode <= reg_contents(8 downto 1);
	end process;
	
end behavioral;