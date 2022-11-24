library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regs is
	port(current_state : in std_logic_vector(2 downto 0);
      ip : in std_logic_vector(15 downto 0); 
      op : out std_logic_vector(15 downto 0));
end regs;

architecture bhv of regs is
begin
	proc: process(current_state)
	begin
		op <= ip;
	end process;
end bhv;