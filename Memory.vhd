library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem is
	port( mem_a1: in std_logic_vector(15 downto 0);
	mem_a0: in std_logic_vector(15 downto 0);
	 mem_d1: in std_logic_vector(15 downto 0);
	 mem_d0: out std_logic_vector(15 downto 0);
	 clk : in std_logic
	 );
end entity;
	 
architecture behav of mem is

type mem_array is array (0 to 31 ) of std_logic_vector (15 downto 0);

signal mem_data: mem_array :=(
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000"); 

signal mem_ins: mem_array := (
	b"1101000011110111", x"FFFF", x"FFFF", x"0000",
	x"FFFF",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000");

begin
	mem_action: process(clk)
	begin
		if (falling_edge(clk)) then
			mem_data(to_integer(unsigned(mem_a1))) <= mem_d1;
		end if;
	end process;

	mem_read: process(mem_a0)
		begin
		mem_d0 <= mem_data(to_integer(unsigned(mem_a0)));
	end process;
end behav;