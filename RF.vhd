library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registers is 
	port (reg_a1: in std_logic_vector(2 downto 0);
			reg_a2: in std_logic_vector(2 downto 0);
			reg_a3: in std_logic_vector(2 downto 0);
			rf_wr: in std_logic;
			reg_d1: out std_logic_vector(15 downto 0);
			reg_d2: out std_logic_vector(15 downto 0);
			reg_d3: in std_logic_vector(15 downto 0);
			clk: in std_logic
	);
end entity;

architecture behav of registers is 
type mem_array is array (0 to 7 ) of std_logic_vector (15 downto 0);
signal regs: mem_array :=(
   x"0008",x"0006", x"0001", x"FFFF",
	x"FFFF",x"FFFF", x"FFFF",x"0000"
   ); 
--pc defined seperately as a signal in IITB_CPU
begin

regs_read: process(reg_a1, reg_a2)
begin
		reg_d1 <= regs(to_integer(unsigned(reg_a1)));
		reg_d2 <= regs(to_integer(unsigned(reg_a2)));
end process;

regs_write: process(clk)
begin
if(rf_wr = '1') then
 if (rising_edge(clk)) then
	regs(to_integer(unsigned(reg_a3))) <= reg_d3;
 end if;
end if;
end process;

end behav;