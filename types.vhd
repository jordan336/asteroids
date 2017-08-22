library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
	
package types is
	type mispostype is array (7 downto 0, 1 downto 0 ) of std_logic_vector(9 downto 0);
	type mispossingletype is array (1 downto 0 ) of std_logic_vector(9 downto 0);
	type misheadtype is array (7 downto 0) of std_logic_vector(2 downto 0);
	type misactivetype is array (7 downto 0) of std_logic;
	type misXYtype is array (7 downto 0) of std_logic_vector(9 downto 0);
	
	type astpostype is array (5 downto 0, 1 downto 0 ) of std_logic_vector(9 downto 0);
	type astpossingletype is array (1 downto 0 ) of std_logic_vector(9 downto 0);
	type astheadtype is array (5 downto 0) of std_logic_vector(2 downto 0);
	type astactivetype is array (5 downto 0) of std_logic;
	type astlifetype is array(5 downto 0) of integer;
	
end package;