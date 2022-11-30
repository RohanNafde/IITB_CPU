library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IITB_CPU is
  port(clk, reset: in std_logic; op1: out std_logic_vector(15 downto 0); op2 : out std_logic_vector(2 downto 0)
  );
end entity IITB_CPU;

architecture ach of IITB_CPU is

signal T1, T2, T3, T4, T5, pc, T1_n, T2_n, pc_n,T3_n, rf_d3_n, mem_di, alu_a, alu_b, alu_c, sig2, sig4, sig8, sig14, sig15, sig16, sig21, mem_a0, s6, s9, rs9, mem_d0, rf_d3, rf_d1, rf_d2: std_logic_vector(15 downto 0) := x"0000";
signal X1, C0, C1, C2, sig1, sig3, sig5, sig6, sig7, sig9, sig10, sig11, sig12, sig20, t1_wr, t2_wr, t3_wr, pc_wr, rf_wr, mem_wr, c_out, z_out, O0, O1, O2, O3: std_logic := '0';
signal rf_a1, rf_a3,reg_a2, count, sig17: std_logic_vector(2 downto 0) := "000";
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
			rf_wr: in std_logic;
			reg_d1: out std_logic_vector(15 downto 0);
			reg_d2: out std_logic_vector(15 downto 0);
			reg_d3: in std_logic_vector(15 downto 0);
			clk: in std_logic
	);
end component registers;

component mem is
	port( mem_a1: in std_logic_vector(15 downto 0);
	mem_a0: in std_logic_vector(15 downto 0);
	mem_wr: in std_logic;
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
  port(C0,clk: in std_logic; C1: in std_logic; C2: in std_logic;
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
X1 <= (not C1) or C2;

--signals
O3 <= T1(15);
O2 <= T1(14);
O1 <= T1(13);
O0 <= T1(12);
sig1 <= O2 and O1;
sig3 <= O2;
sig5 <= (not C1) or C2;
sig6 <= O3 xor O2;
sig7 <= (O3 and (not O1)) or (O0 and O1);
sig8 <= "0000000000000" & count;
sig9 <= (O0 and O1) or (O3 and (not O1)) or ((not O3) and O2);
sig10 <= (O2 and O1) or ((not O3) and (not O1) and O0);
sig11 <= ((not C1) and O1);
sig12 <= ((not C2) and (not O3) and O2 and (not O1)) or (O3 and (not O2));
sig13(0) <= (O3 and O2 and (not O1) and (not O0) and C1 and C0);
sig13(1) <= ((not O3) and (not O2) and O1 and (not O0));
sig20 <= (not O3) and (not O1) and (O0 or O2);

--muxes
--mux1: mux_2to1 port map (A0 => T2, A1 => pc, S0 => X1, Z => alu_a);
--mux2: mux_2to1 port map (A0 => T3, A1 => sig8, S0 => sig1, Z => sig2);
--mux3: mux_2to1 port map (A0 => s9, A1 => s6, S0 => sig3, Z => sig4);
--mux4: mux_4to1 port map (A0 => sig2, A1 => x"0001", A2 => sig4, A3 => sig4, S0 => sig5, S1 => C0, Z => alu_b);
--mux5: mux_4to1 port map (A0 => T2, A1 => rs9, A2 => mem_d0, A3 => pc, S0 => sig6, S1 => sig7, Z => rf_d3);
--mux6: mux3_4to1 port map (A0 => T1(5 downto 3), A1 => T1(8 downto 6), A2 => T1(11 downto 9), A3 => count, S0 => sig9, S1 => sig10, Z => rf_a3);
--mux7: mux_3to1 port map (A0 => T1(11 downto 9), A1 => T1(8 downto 6), A2 => count, S0 => sig11, S1 => sig12, Z => rf_a1);
--mux8: mux_2to1 port map (A0 => T1, A1 => mem_d0, S0 => t1_wr, Z => T1_n);
--mux9: mux_2to1 port map (A0 => alu_c, A1 => rf_d1, S0 => C0, Z => T2_n);
--mux10: mux_2to1 port map (A0 => T2, A1 => sig14, S0 => t2_wr, Z => T2_n);
--mux17: mux_2to1 port map (A0 => rf_d2, A1 =>s6, S0 => sig20, Z => T3_n);
--mux11: mux_2to1 port map (A0 => T3, A1 => sig21, S0 => t3_wr, Z => T3_n);
--mux12: mux_2to1 port map (A0 => alu_c, A1 => rf_d1, S0 => C2, Z => pc_n);
--mux13: mux_2to1 port map (A0 => pc, A1 => sig15, S0 => pc_wr, Z => pc_n);
--mux14: mux_2to1 port map (A0 => pc, A1 => T2, S0 => C0, Z => mem_a0);
--mux15: mux_2to1 port map (A0 => mem_a0, A1 => sig16, S0 => mem_wr, Z => mem_a0);
--mux16: mux3_2to1 port map (A0 => rf_a3, A1 => sig17, S0 => rf_wr, Z => rf_a3);

proc1: process(c2,c1,c0,clk)
begin
if(t1_wr = '1') then
		T1 <= mem_d0;
	else
		null;
end if;
if(sig1 = '1') then
		sig2 <= sig8;
	else
		sig2 <= T3;
end if;

if(rising_edge(clk)) then
	if(c2 = '0' and pc_wr = '1') then
		pc <= std_logic_vector(unsigned(pc)+1);
	elsif(c2 = '1' and pc_wr = '1') then
		pc <= rf_d1;
	else
		null;
	end if;
	if(c0 = '0' and t2_wr = '1') then
		T2 <= alu_c;
	elsif(c0 = '1' and t2_wr = '1') then
		T2 <= rf_d1;
	else
		null;
	end if;
end if;
--if(clk = '0') then
--	
--end if;
if(rising_edge(c0)) then 
	
end if;
if(falling_edge(clk)) then
	if(sig6 = '0' and sig7 = '0') then
		rf_d3 <= T2;
	elsif(sig6 = '1' and sig7 = '0') then
		rf_d3 <= rs9;
	elsif(sig6 = '0' and sig7 = '1') then
		rf_d3 <= mem_d0;
	else
		rf_d3 <= pc;
	end if;
	if(sig20 = '0' and t3_wr = '1') then 
		T3 <= rf_d2;
	elsif(sig20 = '1' and t3_wr = '1') then
		T3 <= s6;
	else
		null;
	end if;
	if(X1 = '1') then
		alu_a <= pc;
	else
		alu_a <= T2;
	end if;
	if(sig3 = '1') then
		sig4 <= s6;
	else
		sig4 <= s9;
	end if;
	if(sig5 = '0' and c0 = '0') then
		alu_b <= sig2;
	elsif(sig5 = '1' and c0 = '0') then
		alu_b <= x"0001";
	elsif(sig5 = '0' and c0 = '1') then
		alu_b <= sig4;
	else
		alu_b <= sig4;
	end if;
	if(sig9 = '0' and sig10 = '0') then
		rf_a3 <= T1(5 downto 3);
	elsif(sig9 = '1' and sig10 = '0') then
		rf_a3 <= T1(8 downto 6);
	elsif(sig9 = '0' and sig10 = '1') then
		rf_a3 <= T1(11 downto 9);
	else
		rf_a3 <= count;
	end if;
	if(sig11 = '0' and sig12 = '0') then
		rf_a1 <= T1(11 downto 9);
	elsif(sig11 = '1' and sig12 = '0') then
		rf_a1 <= T1(8 downto 6);
	else
		rf_a1 <= count;
	end if;
	if(c0 = '0') then
		mem_a0 <= pc;
	else
		mem_a0 <= T2;
	end if;
		
--	if (t2_wr = '1') then
--		T2 <= T2_n;
--	else
--		null;
--	end if;
--	if(t3_wr = '1') then
--		T3 <= T3_n;
--	else
--		null;
--	end if;

--	if(pc_wr = '1') then
--		pc <= std_logic_vector(unsigned(pc) + 1);
--	else
--		null;
--	end if;
end if;
--	if(rf_wr = '1') then
--		rf_d3 <= rf_d3_n;
--	else
--		null;
--	end if;
--	if(mem_wr = '1') then
--		mem_di <= rf_d1;
--	else
--		null;
--	end if;
end process;

--other components
fsm1: fsm port map (clock => clk, reset => reset, carry => c_out, zero => z_out, op_code => T1(15 downto 12), imm => T1(7 downto 0), lsb => T1(1 downto 0), C1 => C1, C2 => C2, C0 => C0, count => count);
alu1: alu port map (A => alu_a, B => alu_b, C => alu_c, control_lines => sig13, carry_out => c_out, zero_out => z_out); 
mem1: mem port map (mem_a1 => T2, mem_a0 => mem_a0, mem_d1 => rf_d1, mem_d0 => mem_d0, clk => clk, mem_wr => mem_wr);
--T1 <= mem_d0;
--testing
reg1: registers port map (reg_a1 => rf_a1, reg_a2 => T1(8 downto 6), reg_a3 => rf_a3, reg_d1 => rf_d1, reg_d2 => rf_d2, reg_d3 => rf_d3, clk => clk, rf_wr => rf_wr);
--testing
se1: SE6 port map (A => T1(5 downto 0), B => s6);
se2: SE9 port map (A => T1(8 downto 0), B => s9);
se3: RSE9 port map (A => T1(8 downto 0), B => rs9);
cu1: CU port map (C0 => C0, clk => clk, C1 => C1, C2 => C2, T1_WR =>t1_wr, T2_WR => t2_wr, T3_WR => t3_wr, RF_WR => rf_wr, PC_WR => pc_wr, Mem_WR => mem_wr);


op1 <= alu_c;
op2(0) <= c0;
op2(1) <= c1;
op2(2) <= c2;
--op2 <= T1(8 downto 6);

end ach;
