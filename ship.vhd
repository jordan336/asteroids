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
-- CREATED		"Tue Apr 30 14:53:19 2013"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ship IS 
	PORT
	(
		missile_clear :  IN  STD_LOGIC;
		inside_draw :  IN  STD_LOGIC;
		ps2data :  IN  STD_LOGIC;
		ps2clk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		vga_clk :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		drawX :  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
		drawY :  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
		missile_ready :  OUT  STD_LOGIC;
		action_ready :  OUT  STD_LOGIC;
		keyboard_clk :  OUT  STD_LOGIC;
		reset_scancode :  OUT  STD_LOGIC;
		data_ready :  OUT  STD_LOGIC;
		edge_out :  OUT  STD_LOGIC;
		ship_on :  OUT  STD_LOGIC;
		heading :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0);
		scancode :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		ship_blue :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		ship_green :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		ship_red :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		shipX :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		shipY :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		spriteAddrs :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END ship;

ARCHITECTURE bdf_type OF ship IS 

COMPONENT ship_draw
	PORT(reset : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 drawX : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 drawY : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 shipHeading : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 shipX : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 shipY : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 spriteData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 shipOn : OUT STD_LOGIC;
		 shipBlue : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 shipGreen : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 shipRed : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 spriteAddrs : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sprite_table
	PORT(clk : IN STD_LOGIC;
		 addr : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ship_move
	PORT(missile_clear : IN STD_LOGIC;
		 inside_draw : IN STD_LOGIC;
		 vga_clk : IN STD_LOGIC;
		 ps2data : IN STD_LOGIC;
		 ps2clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 missile_ready : OUT STD_LOGIC;
		 action_ready : OUT STD_LOGIC;
		 keyboard_clk : OUT STD_LOGIC;
		 reset_scancode : OUT STD_LOGIC;
		 data_ready : OUT STD_LOGIC;
		 edgeout : OUT STD_LOGIC;
		 heading : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 scancode : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ShipX : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 ShipY : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(7 DOWNTO 0);


BEGIN 
heading <= SYNTHESIZED_WIRE_0;
shipX <= SYNTHESIZED_WIRE_1;
shipY <= SYNTHESIZED_WIRE_2;
spriteAddrs <= SYNTHESIZED_WIRE_4;



b2v_inst : ship_draw
PORT MAP(reset => reset,
		 clk => vga_clk,
		 drawX => drawX,
		 drawY => drawY,
		 shipHeading => SYNTHESIZED_WIRE_0,
		 shipX => SYNTHESIZED_WIRE_1,
		 shipY => SYNTHESIZED_WIRE_2,
		 spriteData => SYNTHESIZED_WIRE_3,
		 shipOn => ship_on,
		 shipBlue => ship_blue,
		 shipGreen => ship_green,
		 shipRed => ship_red,
		 spriteAddrs => SYNTHESIZED_WIRE_4);


b2v_inst2 : sprite_table
PORT MAP(clk => vga_clk,
		 addr => SYNTHESIZED_WIRE_4,
		 data => SYNTHESIZED_WIRE_3);


b2v_inst23 : ship_move
PORT MAP(missile_clear => missile_clear,
		 inside_draw => inside_draw,
		 vga_clk => vga_clk,
		 ps2data => ps2data,
		 ps2clk => ps2clk,
		 reset => reset,
		 clk => clk,
		 missile_ready => missile_ready,
		 action_ready => action_ready,
		 keyboard_clk => keyboard_clk,
		 reset_scancode => reset_scancode,
		 data_ready => data_ready,
		 edgeout => edge_out,
		 heading => SYNTHESIZED_WIRE_0,
		 scancode => scancode,
		 ShipX => SYNTHESIZED_WIRE_1,
		 ShipY => SYNTHESIZED_WIRE_2);


END bdf_type;