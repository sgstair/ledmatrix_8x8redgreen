----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:01:13 04/25/2010 
-- Design Name: 
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( sck : in  STD_LOGIC;
           sdatain : in  STD_LOGIC;
           sdataout : out  STD_LOGIC := '1';
           latch : in  STD_LOGIC;
           row : in  STD_LOGIC_VECTOR (2 downto 0);
           ledrow : out  STD_LOGIC_VECTOR (7 downto 0) := "11111111";
           ledgrn : out  STD_LOGIC_VECTOR (7 downto 0) := "11111111";
           ledred : out  STD_LOGIC_VECTOR (7 downto 0) := "11111111");
end main;

architecture Behavioral of main is

signal shiftreg : std_logic_vector(15 downto 0) := X"0000";

begin

process(sck)
begin
	if sck'event and sck='1' then
		sdataout <= shiftreg(15);
		shiftreg <= shiftreg(14 downto 0) & sdatain;
	end if;
end process;

process(latch)
begin
	if latch'event and latch='1' then
		ledgrn <= shiftreg(7 downto 0) xor "11111111";
		ledred <= shiftreg(15 downto 8) xor "11111111";
	end if;
	
	if latch='1' then
      for i in 0 to 7 loop
		   if i=row then
				ledrow(i) <= '0';
			else
				ledrow(i) <= '1';
			end if;
		end loop;
	else
		ledrow <= "11111111";
	end if;
end process;
	
	
end Behavioral;

