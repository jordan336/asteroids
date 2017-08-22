library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity to synchronize fast system clock with slow keyboard clock
--counts from 0 to 10 on each of 11 falling edges of keyboard clock
--locates falling edges of keyboard clock for shifting purposes
entity clock_sync is
	port(systemClk, psClk, reset : in std_logic;
		 falling, inside_send : out std_logic );
end clock_sync;

architecture behavioral of clock_sync is

	--d flip flops to store keyboard clock values
	component d_flip_flop is
		port( D, clk : in std_logic;
		           Q : out std_logic );
	end component d_flip_flop;

	signal q0, q1, int_internal : std_logic;   --output of d flip flops
	signal q : std_logic_vector(1 downto 0);   --vector of d flip flop outputs
	shared variable count : std_logic_vector(3 downto 0);
	
	begin
	
	dff0 : d_flip_flop port map(D=>psClk, clk=>systemClk, Q=>q0);
	dff1 : d_flip_flop port map(D=>q0, clk=>systemClk, Q=>q1);
	
	--process to count falling edges		
	process(reset, systemClk, q1, q0)
	begin
		q <= q1&q0;
		if(reset = '1') then
			count := "0000";
		elsif(rising_edge(systemClk)) then
			if(count = "1011") then   --reset on 12th count, 11th keyboard falling edge
				count := "0000";
			end if;
			if(q = "10") then    --falling edge found
				count := count + "0001";
			else
				count := count;
			end if;
		end if;
	end process;		
	
	--process to determine if inside a sending cycle
	get_output : process(reset, systemClk, q1, q0, q, int_internal)
	begin
		q <= q1&q0;
		if(reset = '1') then
			int_internal <= '0';
			falling <= '0';
		elsif(rising_edge(systemClk)) then
			if(q = "10") then    --falling edge found
				falling <= '1';
				int_internal <= '1';
			else 
				if(count = "1011") then   --reset at 12th count
					int_internal <= '0';
				end if;
				falling <= '0';
			end if;
			inside_send <= int_internal;   --signal to reset of circuit if currently inside a sending cycle
		end if;
	end process;
	
end behavioral;