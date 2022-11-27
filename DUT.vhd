-- A DUT entity is used to wrap your design so that we can combine it with testbench.
-- This example shows how you can do this for the OR Gate

library ieee;
use ieee.std_logic_1164.all;

entity DUT is
    port(input_vector: in std_logic_vector(1 downto 0);
       	output_vector: out std_logic_vector(18 downto 0));
end entity;

architecture DutWrap of DUT is
component IITB_CPU is
	port (clk, reset: in std_logic;  op1: out std_logic_vector(15 downto 0); op2 : out std_logic_vector(2 downto 0));
end component IITB_CPU;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: IITB_CPU
			port map (
					-- order of inputs B A
					clk => input_vector(1),
					reset => input_vector(0),
               -- order of output OUTPUT
					op1 => output_vector(18 downto 3),
					op2 => output_vector(2 downto 0));
end DutWrap;