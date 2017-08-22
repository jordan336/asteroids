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
-- CREATED		"Tue Apr 30 14:53:54 2013"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY asteroids IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		ps2data :  IN  STD_LOGIC;
		ps2clk :  IN  STD_LOGIC;
		hs :  OUT  STD_LOGIC;
		vs :  OUT  STD_LOGIC;
		VGA_clk :  OUT  STD_LOGIC;
		blank :  OUT  STD_LOGIC;
		sync :  OUT  STD_LOGIC;
		keyboard_clk :  OUT  STD_LOGIC;
		reset_scancode :  OUT  STD_LOGIC;
		data_ready :  OUT  STD_LOGIC;
		action_ready :  OUT  STD_LOGIC;
		missile_on :  OUT  STD_LOGIC;
		missile_ready :  OUT  STD_LOGIC;
		missile_clear :  OUT  STD_LOGIC;
		asteroid_on :  OUT  STD_LOGIC;
		edgeout :  OUT  STD_LOGIC;
		ship_on :  OUT  STD_LOGIC;
		shipCollision :  OUT  STD_LOGIC;
		resetOut :  OUT  STD_LOGIC;
		shipReset :  OUT  STD_LOGIC;
		collide :  OUT  STD_LOGIC;
		blue :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		DrawX :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		DrawY :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		green :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		heading :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0);
		hud_addrs :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		red :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		scancode :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		ShipX :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		ShipY :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0);
		spriteAddrs :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END asteroids;

ARCHITECTURE bdf_type OF asteroids IS 

COMPONENT color_mapper
	PORT(hudOn : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 missile_on : IN STD_LOGIC;
		 asteroid_on : IN STD_LOGIC;
		 ship_on : IN STD_LOGIC;
		 AsteroidB : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 AsteroidG : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 AsteroidR : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 hudB : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 hudG : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 hudR : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 MissileB : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 MissileG : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 MissileR : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 ShipB : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 ShipG : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 ShipR : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 Blue : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 Green : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 Red : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT asteroid_sprite_table
	PORT(clk : IN STD_LOGIC;
		 addr : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ship
	PORT(vga_clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 missile_clear : IN STD_LOGIC;
		 inside_draw : IN STD_LOGIC;
		 ps2data : IN STD_LOGIC;
		 ps2clk : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 drawX : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 drawY : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 ship_on : OUT STD_LOGIC;
		 missile_ready : OUT STD_LOGIC;
		 action_ready : OUT STD_LOGIC;
		 keyboard_clk : OUT STD_LOGIC;
		 reset_scancode : OUT STD_LOGIC;
		 data_ready : OUT STD_LOGIC;
		 edge_out : OUT STD_LOGIC;
		 heading : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 scancode : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ship_blue : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 ship_green : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 ship_red : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 shipX : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 shipY : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 spriteAddrs : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT hud_sprite_table
	PORT(clk : IN STD_LOGIC;
		 addr : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		 data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT vga_controller
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 hs : OUT STD_LOGIC;
		 vs : OUT STD_LOGIC;
		 pixel_clk : OUT STD_LOGIC;
		 blank : OUT STD_LOGIC;
		 sync : OUT STD_LOGIC;
		 DrawX : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 DrawY : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT missile
	PORT(reset : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 collide : IN STD_LOGIC;
		 missile_ready : IN STD_LOGIC;
		 drawX : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 drawY : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 misCollided : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 shipHeading : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 shipX : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 shipY : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 missile_on : OUT STD_LOGIC;
		 missile_clear : OUT STD_LOGIC;
		 mactive : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 missileBlue : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 missileGreen : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 missileRed : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 mpos0 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 mpos1 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 mpos2 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 mpos3 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 mpos4 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 mpos5 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 mpos6 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 mpos7 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0)
	);
END COMPONENT;

COMPONENT asteroid
	PORT(reset : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 collide : IN STD_LOGIC;
		 astCollided : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 drawX : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 drawY : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 shipX : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 shipY : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 spriteData : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		 asteroidOn : OUT STD_LOGIC;
		 shipCollision : OUT STD_LOGIC;
		 aactive : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 apos0 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 apos1 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 apos2 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 apos3 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 apos4 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 apos5 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 asteroidBlue : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 asteroidGreen : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 asteroidRed : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 spriteAddrs : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT collision
	PORT(reset : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 astactive : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 astpos0 : IN STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 astpos1 : IN STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 astpos2 : IN STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 astpos3 : IN STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 astpos4 : IN STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 astpos5 : IN STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 misactive : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 mispos0 : IN STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 mispos1 : IN STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 mispos2 : IN STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 mispos3 : IN STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 mispos4 : IN STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 mispos5 : IN STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 mispos6 : IN STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 mispos7 : IN STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
		 collide : OUT STD_LOGIC;
		 astcollide : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 miscollide : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 scoreones : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		 scoretens : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_constant0
	PORT(		 result : OUT STD_LOGIC_VECTOR(0 TO 0)
	);
END COMPONENT;

COMPONENT hud
	PORT(reset : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 drawX : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 drawY : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 scoreones : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 scoretens : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 spriteData : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 state : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 hudOn : OUT STD_LOGIC;
		 hudBlue : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 hudGreen : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 hudRed : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 spriteAddrs : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END COMPONENT;

COMPONENT state_machine
	PORT(reset : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 spacebar : IN STD_LOGIC;
		 shipCollision : IN STD_LOGIC;
		 resetOut : OUT STD_LOGIC;
		 shipReset : OUT STD_LOGIC;
		 stateOut : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_82 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_83 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_14 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_17 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_84 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_85 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_27 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_86 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_87 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_31 :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_88 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_89 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_39 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_40 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_90 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_91 :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_46 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_51 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_54 :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_55 :  STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_56 :  STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_57 :  STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_58 :  STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_59 :  STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_60 :  STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_61 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_62 :  STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_63 :  STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_64 :  STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_65 :  STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_66 :  STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_67 :  STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_68 :  STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_69 :  STD_LOGIC_VECTOR(1 DOWNTO 0 , 9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_74 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_75 :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_76 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_77 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_81 :  STD_LOGIC;


BEGIN 
VGA_clk <= SYNTHESIZED_WIRE_82;
missile_on <= SYNTHESIZED_WIRE_3;
missile_ready <= SYNTHESIZED_WIRE_89;
missile_clear <= SYNTHESIZED_WIRE_26;
asteroid_on <= SYNTHESIZED_WIRE_4;
ship_on <= SYNTHESIZED_WIRE_5;
shipCollision <= SYNTHESIZED_WIRE_81;
resetOut <= SYNTHESIZED_WIRE_21;
shipReset <= SYNTHESIZED_WIRE_23;
collide <= SYNTHESIZED_WIRE_88;
DrawX <= SYNTHESIZED_WIRE_86;
DrawY <= SYNTHESIZED_WIRE_87;
heading <= SYNTHESIZED_WIRE_40;
hud_addrs <= SYNTHESIZED_WIRE_31;
ShipX <= SYNTHESIZED_WIRE_90;
ShipY <= SYNTHESIZED_WIRE_91;



b2v_inst : color_mapper
PORT MAP(hudOn => SYNTHESIZED_WIRE_0,
		 clk => SYNTHESIZED_WIRE_82,
		 reset => SYNTHESIZED_WIRE_83,
		 missile_on => SYNTHESIZED_WIRE_3,
		 asteroid_on => SYNTHESIZED_WIRE_4,
		 ship_on => SYNTHESIZED_WIRE_5,
		 AsteroidB => SYNTHESIZED_WIRE_6,
		 AsteroidG => SYNTHESIZED_WIRE_7,
		 AsteroidR => SYNTHESIZED_WIRE_8,
		 hudB => SYNTHESIZED_WIRE_9,
		 hudG => SYNTHESIZED_WIRE_10,
		 hudR => SYNTHESIZED_WIRE_11,
		 MissileB => SYNTHESIZED_WIRE_12,
		 MissileG => SYNTHESIZED_WIRE_13,
		 MissileR => SYNTHESIZED_WIRE_14,
		 ShipB => SYNTHESIZED_WIRE_15,
		 ShipG => SYNTHESIZED_WIRE_16,
		 ShipR => SYNTHESIZED_WIRE_17,
		 Blue => blue,
		 Green => green,
		 Red => red);


b2v_inst1 : asteroid_sprite_table
PORT MAP(clk => SYNTHESIZED_WIRE_82,
		 addr => SYNTHESIZED_WIRE_19,
		 data => SYNTHESIZED_WIRE_51);


SYNTHESIZED_WIRE_83 <= SYNTHESIZED_WIRE_84 OR SYNTHESIZED_WIRE_21;


SYNTHESIZED_WIRE_85 <= SYNTHESIZED_WIRE_83 OR SYNTHESIZED_WIRE_23;


b2v_inst13 : ship
PORT MAP(vga_clk => SYNTHESIZED_WIRE_82,
		 reset => SYNTHESIZED_WIRE_85,
		 missile_clear => SYNTHESIZED_WIRE_26,
		 inside_draw => SYNTHESIZED_WIRE_27,
		 ps2data => ps2data,
		 ps2clk => ps2clk,
		 clk => clk,
		 drawX => SYNTHESIZED_WIRE_86,
		 drawY => SYNTHESIZED_WIRE_87,
		 ship_on => SYNTHESIZED_WIRE_5,
		 missile_ready => SYNTHESIZED_WIRE_89,
		 action_ready => action_ready,
		 keyboard_clk => keyboard_clk,
		 reset_scancode => reset_scancode,
		 data_ready => data_ready,
		 edge_out => edgeout,
		 heading => SYNTHESIZED_WIRE_40,
		 scancode => scancode,
		 ship_blue => SYNTHESIZED_WIRE_15,
		 ship_green => SYNTHESIZED_WIRE_16,
		 ship_red => SYNTHESIZED_WIRE_17,
		 shipX => SYNTHESIZED_WIRE_90,
		 shipY => SYNTHESIZED_WIRE_91,
		 spriteAddrs => spriteAddrs);


SYNTHESIZED_WIRE_84 <= NOT(reset);



b2v_inst18 : hud_sprite_table
PORT MAP(clk => SYNTHESIZED_WIRE_82,
		 addr => SYNTHESIZED_WIRE_31,
		 data => SYNTHESIZED_WIRE_76);


b2v_inst2 : vga_controller
PORT MAP(clk => clk,
		 reset => SYNTHESIZED_WIRE_84,
		 hs => hs,
		 vs => vs,
		 pixel_clk => SYNTHESIZED_WIRE_82,
		 blank => blank,
		 sync => sync,
		 DrawX => SYNTHESIZED_WIRE_86,
		 DrawY => SYNTHESIZED_WIRE_87);


b2v_inst21 : missile
PORT MAP(reset => SYNTHESIZED_WIRE_85,
		 clk => SYNTHESIZED_WIRE_82,
		 collide => SYNTHESIZED_WIRE_88,
		 missile_ready => SYNTHESIZED_WIRE_89,
		 drawX => SYNTHESIZED_WIRE_86,
		 drawY => SYNTHESIZED_WIRE_87,
		 misCollided => SYNTHESIZED_WIRE_39,
		 shipHeading => SYNTHESIZED_WIRE_40,
		 shipX => SYNTHESIZED_WIRE_90,
		 shipY => SYNTHESIZED_WIRE_91,
		 missile_on => SYNTHESIZED_WIRE_3,
		 missile_clear => SYNTHESIZED_WIRE_26,
		 mactive => SYNTHESIZED_WIRE_61,
		 missileBlue => SYNTHESIZED_WIRE_12,
		 missileGreen => SYNTHESIZED_WIRE_13,
		 missileRed => SYNTHESIZED_WIRE_14,
		 mpos0 => SYNTHESIZED_WIRE_62,
		 mpos1 => SYNTHESIZED_WIRE_63,
		 mpos2 => SYNTHESIZED_WIRE_64,
		 mpos3 => SYNTHESIZED_WIRE_65,
		 mpos4 => SYNTHESIZED_WIRE_66,
		 mpos5 => SYNTHESIZED_WIRE_67,
		 mpos6 => SYNTHESIZED_WIRE_68,
		 mpos7 => SYNTHESIZED_WIRE_69);


b2v_inst22 : asteroid
PORT MAP(reset => SYNTHESIZED_WIRE_85,
		 clk => SYNTHESIZED_WIRE_82,
		 collide => SYNTHESIZED_WIRE_88,
		 astCollided => SYNTHESIZED_WIRE_46,
		 drawX => SYNTHESIZED_WIRE_86,
		 drawY => SYNTHESIZED_WIRE_87,
		 shipX => SYNTHESIZED_WIRE_90,
		 shipY => SYNTHESIZED_WIRE_91,
		 spriteData => SYNTHESIZED_WIRE_51,
		 asteroidOn => SYNTHESIZED_WIRE_4,
		 shipCollision => SYNTHESIZED_WIRE_81,
		 aactive => SYNTHESIZED_WIRE_54,
		 apos0 => SYNTHESIZED_WIRE_55,
		 apos1 => SYNTHESIZED_WIRE_56,
		 apos2 => SYNTHESIZED_WIRE_57,
		 apos3 => SYNTHESIZED_WIRE_58,
		 apos4 => SYNTHESIZED_WIRE_59,
		 apos5 => SYNTHESIZED_WIRE_60,
		 asteroidBlue => SYNTHESIZED_WIRE_6,
		 asteroidGreen => SYNTHESIZED_WIRE_7,
		 asteroidRed => SYNTHESIZED_WIRE_8,
		 spriteAddrs => SYNTHESIZED_WIRE_19);


b2v_inst5 : collision
PORT MAP(reset => SYNTHESIZED_WIRE_83,
		 clk => SYNTHESIZED_WIRE_82,
		 astactive => SYNTHESIZED_WIRE_54,
		 astpos0 => SYNTHESIZED_WIRE_55,
		 astpos1 => SYNTHESIZED_WIRE_56,
		 astpos2 => SYNTHESIZED_WIRE_57,
		 astpos3 => SYNTHESIZED_WIRE_58,
		 astpos4 => SYNTHESIZED_WIRE_59,
		 astpos5 => SYNTHESIZED_WIRE_60,
		 misactive => SYNTHESIZED_WIRE_61,
		 mispos0 => SYNTHESIZED_WIRE_62,
		 mispos1 => SYNTHESIZED_WIRE_63,
		 mispos2 => SYNTHESIZED_WIRE_64,
		 mispos3 => SYNTHESIZED_WIRE_65,
		 mispos4 => SYNTHESIZED_WIRE_66,
		 mispos5 => SYNTHESIZED_WIRE_67,
		 mispos6 => SYNTHESIZED_WIRE_68,
		 mispos7 => SYNTHESIZED_WIRE_69,
		 collide => SYNTHESIZED_WIRE_88,
		 astcollide => SYNTHESIZED_WIRE_46,
		 miscollide => SYNTHESIZED_WIRE_39,
		 scoreones => SYNTHESIZED_WIRE_74,
		 scoretens => SYNTHESIZED_WIRE_75);


b2v_inst6 : lpm_constant0
PORT MAP(		 result(0) => SYNTHESIZED_WIRE_27);


b2v_inst7 : hud
PORT MAP(reset => SYNTHESIZED_WIRE_84,
		 clk => SYNTHESIZED_WIRE_82,
		 drawX => SYNTHESIZED_WIRE_86,
		 drawY => SYNTHESIZED_WIRE_87,
		 scoreones => SYNTHESIZED_WIRE_74,
		 scoretens => SYNTHESIZED_WIRE_75,
		 spriteData => SYNTHESIZED_WIRE_76,
		 state => SYNTHESIZED_WIRE_77,
		 hudOn => SYNTHESIZED_WIRE_0,
		 hudBlue => SYNTHESIZED_WIRE_9,
		 hudGreen => SYNTHESIZED_WIRE_10,
		 hudRed => SYNTHESIZED_WIRE_11,
		 spriteAddrs => SYNTHESIZED_WIRE_31);


b2v_inst9 : state_machine
PORT MAP(reset => SYNTHESIZED_WIRE_84,
		 clk => SYNTHESIZED_WIRE_82,
		 spacebar => SYNTHESIZED_WIRE_89,
		 shipCollision => SYNTHESIZED_WIRE_81,
		 resetOut => SYNTHESIZED_WIRE_21,
		 shipReset => SYNTHESIZED_WIRE_23,
		 stateOut => SYNTHESIZED_WIRE_77);


END bdf_type;