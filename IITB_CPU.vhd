library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IITB_CPU is
  port(clk, reset: in std_logic
  );
end entity IITB_CPU;

architecture ach of IITB_CPU is

signal T1, T2, T3, pc, alu_a, alu_b, alu_c, sig2, sig4, sig8, sig14, sig15, sig16, mem_a0, s6, s9, rs9, mem_d0, rf_d3, rf_d1, rf_d2: std_logic_vector(15 downto 0) := x"0000";
signal X1, C0, C1, C2, sig1, sig3, sig5, sig6, sig7, sig9, sig10, sig11, sig12, t1_wr, t2_wr, t3_wr, pc_wr, rf_wr, mem_wr, c_out, z_out, O0, O1, O2, O3: std_logic := '0';
signal rf_a1, rf_a3, count, sig17: std_logic_vector(2 downto 0) := "000";
signal sig13: std_logic_vector(1 downto 0) := "00";
  
component mux_2to1 is
	port(A0, A1: in std_logic_vector(15 downto 0); S0 : in std_logic;
		Z: out std_logic_vector(15 downto 0));
end component;

component mux3_2to1 is
	port(A0, A1: in std_logic_vector(2 downto 0); S0 : in std_logic;
		Z: out std_logic_vector(2 downto 0));
end component mux3_2to1;

component mux_4to1 is
	port(A0, A1, A2, A3: in std_logic_vector(15 downto 0); S0, S1 : in std_logic;
		Z: out std_logic_vector(15 downto 0));
end component mux_4to1;

component mux3_4to1 is
	port(A0, A1, A2, A3: in std_logic_vector(2 downto 0); S0, S1 : in std_logic;
		Z: out std_logic_vector(2 downto 0));
end component mux3_4to1;

component mux_3to1 is
	port(A0, A1, A2: in std_logic_vector(2 downto 0); S0, S1 : in std_logic;
		Z: out std_logic_vector(2 downto 0));
end component mux_3to1;

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
			clk: in std_logic
	);
end component registers;

component mem is
	port( mem_a1: in std_logic_vector(15 downto 0);
	mem_a0: in std_logic_vector(15 downto 0);
	 mem_d1: in std_logic_vector(15 downto 0);
	 mem_d0: out std_logic_vector(15 downto 0);
	 clk : in std_logic
	 );
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

component CU is
  port(C0: in std_logic; C1: in std_logic; C2: in std_logic;
  T1_WR: out std_logic; T2_WR: out std_logic; T3_WR: out std_logic; RF_WR: out std_logic;
  Mem_WR: out std_logic; PC_WR: out std_logic
  );
end component CU;

component fsm is
	port(clock, reset, carry, zero: in std_logic;
			op_code: in std_logic_vector (3 downto 0);
			imm: in std_logic_vector (7 downto 0);
			lsb: in std_logic_vector(1 downto 0);
			C2, C1, C0: out std_logic;
			count: out std_logic_vector(2 downto 0));
end component fsm;

begin

--reg1: registers port map (reg_a1 => "111", reg_d1 => pc);
--mem1: mem port map(mem_a0 => pc, mem_d0 => T1);
--alu1:
X1 <= ((not C1) and C0) or C2;

--signals
O3 <= T1(15);
O2 <= T1(14);
O1 <= T1(13);
O0 <= T1(12);
sig1 <= O2 and O1;
sig3 <= not O1;
sig5 <= C1 and C0;
sig6 <= O3 xor O2;
sig7 <= (O3 and (not O1)) or (O0 and O1);
sig8 <= "0000000000000" & count;
sig9 <= (O0 and O1) or (O3 and (not O1)) or ((not O3) and O2);
sig10 <= (O2 and O1) or ((not O3) and (not O1) and O0);
sig11 <= ((not C1) and O1);
sig12 <= ((not C2) and (not O3) and O2 and (not O1)) or (O3 and (not O2));
sig13(0) <= (O3 and O2 and (not O1) and (not O0) and C1 and C0);
sig13(1) <= ((not O3) and (not O2) and O1 and (not O0));

--muxes
mux1: mux_2to1 port map (A0 => T2, A1 => pc, S0 => X1, Z => alu_a);
mux2: mux_2to1 port map (A0 => T3, A1 => sig8, S0 => sig1, Z => sig2);
mux3: mux_2to1 port map (A0 => s6, A1 => s9, S0 => sig3, Z => sig4);
mux4: mux_4to1 port map (A0 => x"0001", A1 => sig2, A2 => x"0001", A3 => sig4, S0 => C2, S1 => sig5, Z => alu_b);
mux5: mux_4to1 port map (A0 => T2, A1 => rs9, A2 => mem_d0, A3 => pc, S0 => sig6, S1 => sig7, Z => rf_d3);
mux6: mux3_4to1 port map (A0 => T1(5 downto 3), A1 => T1(8 downto 6), A2 => T1(11 downto 9), A3 => count, S0 => sig9, S1 => sig10, Z => sig17);
mux7: mux_3to1 port map (A0 => T1(11 downto 9), A1 => T1(8 downto 6), A2 => count, S0 => sig11, S1 => sig12, Z => rf_a1);
mux8: mux_2to1 port map (A0 => T1, A1 => mem_d0, S0 => t1_wr, Z => T1);
mux9: mux_2to1 port map (A0 => alu_c, A1 => rf_d1, S0 => C0, Z => sig14);
mux10: mux_2to1 port map (A0 => T2, A1 => sig14, S0 => t2_wr, Z => T2);
mux11: mux_2to1 port map (A0 => T3, A1 => rf_d2, S0 => t3_wr, Z => T3);
mux12: mux_2to1 port map (A0 => alu_c, A1 => rf_d1, S0 => C2, Z => sig15);
mux13: mux_2to1 port map (A0 => pc, A1 => sig15, S0 => pc_wr, Z => pc);
mux14: mux_2to1 port map (A0 => pc, A1 => T2, S0 => C2, Z => sig16);
mux15: mux_2to1 port map (A0 => mem_a0, A1 => sig16, S0 => mem_wr, Z => mem_a0);
mux16: mux3_2to1 port map (A0 => rf_a3, A1 => sig17, S0 => rf_wr, Z => rf_a3);

--other components
fsm1: fsm port map (clock => clk, reset => reset, carry => c_out, zero => z_out, op_code => T1(15 downto 12), imm => T1(7 downto 0), lsb => T1(1 downto 0), C1 => C1, C2 => C2, C0 => C0, count => count);
alu1: alu port map (A => alu_a, B => alu_b, C => alu_c, control_lines => sig13, carry_out => c_out, zero_out => z_out); 
mem1: mem port map (mem_a1 => T2, mem_a0 => mem_a0, mem_d1 => rf_d1, mem_d0 => mem_d0, clk => clk);
reg1: registers port map (reg_a1 => rf_a1, reg_a2 => T1(8 downto 6), reg_a3 => rf_a3, reg_d1 => rf_d1, reg_d2 => rf_d2, reg_d3 => rf_d3, clk => clk);
se1: SE6 port map (A => T1(5 downto 0), B => s6);
se2: SE9 port map (A => T1(8 downto 0), B => s9);
se3: RSE9 port map (A => T1(8 downto 0), B => rs9);
cu1: CU port map (C0 => C0, C1 => C1, C2 => C2, T1_WR =>t1_wr, T2_WR => t2_wr, T3_WR => t3_wr, RF_WR => rf_wr, PC_WR => pc_wr, Mem_WR => mem_wr);


end ach;
