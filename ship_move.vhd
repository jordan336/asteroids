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
-- CREATED		"Tue Apr 30 14:53:44 2013"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ship_move IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		ps2data :  IN  STD_LOGIC;
		ps2clk :  IN  STD_LOGIC;
		inside_draw :  IN  STD_LOGIC;
		missile_clear :  IN  STD_LOGIC;
		vga_clk :  IN  STD_LOGIC;
		keyboard_clk :  OUT  STD_LOGIC;
		reset_scancode :  OUT  STD_LOGIC;
		data_ready :  OUT  STD_LOGIC;
		action_ready :  OUT  STD_LOGIC;
		missile_ready :  OUT  STD_LOGIC;
		edgeout :  OUT  STD_LOGIC;
		heading :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0);
		scancode :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		ShipX :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		ShipY :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END ship_move;

ARCHITECTURE bdf_type OF ship_move IS 

COMPONENT keyboard
	PORT(ps2data : IN STD_LOGIC;
		 ps2clk : IN STD_LOGIC;
		 sysClk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 reset_scancode : IN STD_LOGIC;
		 new_key : OUT STD_LOGIC;
		 edgeout : OUT STD_LOGIC;
		 scancode : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT counter
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 pulse : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT heading_register
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 inside_draw : IN STD_LOGIC;
		 heading_in : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 heading_out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT spaceship
	PORT(Reset : IN STD_LOGIC;
		 data_ready : IN STD_LOGIC;
		 frame_clk : IN STD_LOGIC;
		 system_clk : IN STD_LOGIC;
		 missile_clear : IN STD_LOGIC;
		 scan_code : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 reset_out : OUT STD_LOGIC;
		 action_out : OUT STD_LOGIC;
		 missile_out : OUT STD_LOGIC;
		 heading_out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 ShipX : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 ShipY : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(7 DOWNTO 0);


BEGIN 
keyboard_clk <= SYNTHESIZED_WIRE_7;
reset_scancode <= SYNTHESIZED_WIRE_1;
data_ready <= SYNTHESIZED_WIRE_4;
scancode <= SYNTHESIZED_WIRE_6;



b2v_inst : keyboard
PORT MAP(ps2data => ps2data,
		 ps2clk => ps2clk,
		 sysClk => SYNTHESIZED_WIRE_7,
		 reset => reset,
		 reset_scancode => SYNTHESIZED_WIRE_1,
		 new_key => SYNTHESIZED_WIRE_4,
		 edgeout => edgeout,
		 scancode => SYNTHESIZED_WIRE_6);


b2v_inst1 : counter
PORT MAP(clk => clk,
		 reset => reset,
		 pulse => SYNTHESIZED_WIRE_7);


b2v_inst2 : heading_register
PORT MAP(clk => SYNTHESIZED_WIRE_7,
		 reset => reset,
		 inside_draw => inside_draw,
		 heading_in => SYNTHESIZED_WIRE_3,
		 heading_out => heading);


b2v_inst4 : spaceship
PORT MAP(Reset => reset,
		 data_ready => SYNTHESIZED_WIRE_4,
		 frame_clk => vga_clk,
		 system_clk => SYNTHESIZED_WIRE_7,
		 missile_clear => missile_clear,
		 scan_code => SYNTHESIZED_WIRE_6,
		 reset_out => SYNTHESIZED_WIRE_1,
		 action_out => action_ready,
		 missile_out => missile_ready,
		 heading_out => SYNTHESIZED_WIRE_3,
		 ShipX => ShipX,
		 ShipY => ShipY);


END bdf_type;