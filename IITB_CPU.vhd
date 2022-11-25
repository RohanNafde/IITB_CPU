library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IITB_CPU is
	port(clk: in std_logic);
end entity IITB_CPU;

architecture ach of IITB_CPU is
  
component mux_2to1 is
	port(A0, A1, S0 : in std_logic;
		Z: out std_logic);
end component;

component mux_4to1 is
	port(A0, A1, A2, A3, S0, S1 : in std_logic;
		Z: out std_logic);
end component mux_4to1;

component mux_8to1 is
	port(A0, A1, A2, A3, A4, A5, A6, A7, S0, S1, S2 : in std_logic;
		Z: out std_logic);
end component mux_8to1;

component demux_1to2 is
	port(F, S0 : in std_logic;
	A0, A1: out std_logic);
end component demux_1to2;

component demux_1to4 is
	port(F, S0, S1 : in std_logic;
	A0, A1, A2, A3: out std_logic);
end component demux_1to4;

component demux_1to8 is
	port(F, S0, S1, S2 : in std_logic;
	A0, A1, A2, A3, A4, A5, A6, A7: out std_logic);
end component demux_1to8;

component registers is 
	port (reg_a1: in std_logic_vector(2 downto 0);
			reg_a2: in std_logic_vector(2 downto 0);
			reg_a3: in std_logic_vector(2 downto 0);
			reg_d1: out std_logic_vector(15 downto 0);
			reg_d2: out std_logic_vector(15 downto 0);
			reg_d3: in std_logic_vector(15 downto 0);
			clk: in std_logic);
end component registers;

component mem is
	port(mem_a1, mem_a0, mem_d1: in std_logic_vector(15 downto 0);
		mem_d0: out std_logic_vector(15 downto 0);
		clk : in std_logic);
end component mem;

component SE6 is
	port (A: in std_logic_vector(5 downto 0); B: out std_logic_vector(15 downto 0));
end component SE6;

component SE9 is
	port (A: in std_logic_vector(8 downto 0); B: out std_logic_vector(15 downto 0));
end component SE9;

component RSE9 is
	port (A: in std_logic_vector(8 downto 0); B: out std_logic_vector(15 downto 0));
end component RSE9;

component alu is
	port(A: in std_logic_vector(15 downto 0);
		 B: in std_logic_vector(15 downto 0);
		 C: out std_logic_vector(15 downto 0);
		 control_lines: in std_logic_vector(1 downto 0);
		 carry_out: out std_logic;
		 zero_out: out std_logic);
end component alu;

component fsm is
	port(clock, reset: in std_logic; op_code: in std_logic_vector (3 downto 0);  
			C2, C1, C0: out std_logic  );
end component fsm;

begin


end ach;
