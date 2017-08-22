-- Copyright (C) 1991-2010 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II"
-- VERSION		"Version 9.1 Build 350 03/24/2010 Service Pack 2 SJ Web Edition"
-- CREATED		"Mon Mar 04 19:36:27 2013"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY keyboard IS 
	PORT
	(
		ps2data :  IN  STD_LOGIC;
		ps2clk :  IN  STD_LOGIC;
		sysClk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		reset_scancode :  IN  STD_LOGIC;
		new_key :  OUT  STD_LOGIC;
		edgeout    : out std_logic;
		scancode :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END keyboard;

ARCHITECTURE bdf_type OF keyboard IS 

COMPONENT scan_register
	PORT(din : IN STD_LOGIC;
		 edge : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 reset_scancode : IN STD_LOGIC;
		 contents : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT clock_sync
	PORT(systemClk : IN STD_LOGIC;
		 psClk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 falling : OUT STD_LOGIC;
		 inside_send : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT key_combination
	PORT(clk : IN STD_LOGIC;
		 inside_send : IN STD_LOGIC;
		 reset_scancode : IN STD_LOGIC;
		 reset : in std_logic;
		 reg_contents : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 new_key : OUT STD_LOGIC;
		 scancode : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(10 DOWNTO 0);

BEGIN 

b2v_inst4 : scan_register
PORT MAP(din => ps2data,
		 edge => SYNTHESIZED_WIRE_0,
		 clk => sysClk,
		 reset => reset,
		 reset_scancode => reset_scancode,
		 contents => SYNTHESIZED_WIRE_2 );

edgeout <= SYNTHESIZED_WIRE_0;

b2v_inst5 : clock_sync
PORT MAP(systemClk => sysClk,
		 psClk => ps2clk,
		 reset => reset,
		 falling => SYNTHESIZED_WIRE_0,
		 inside_send => SYNTHESIZED_WIRE_1);


b2v_inst6 : key_combination
PORT MAP(clk => sysClk,
		 reset => reset,
		 inside_send => SYNTHESIZED_WIRE_1,
		 reset_scancode => reset_scancode,
		 reg_contents => SYNTHESIZED_WIRE_2,
		 new_key => new_key,
		 scancode => scancode );

END bdf_type;
