library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CU is
  port(C0, clk: in std_logic; C1: in std_logic; C2: in std_logic;
  T1_WR: out std_logic; T2_WR: out std_logic; T3_WR: out std_logic; RF_WR: out std_logic;
  Mem_WR: out std_logic; PC_WR: out std_logic);
end entity CU;

architecture bhv of CU is
signal T2_WR_n,PC_WR_n: std_logic;
begin
T1_WR <= (not C2) and (not C1) and (not C0);
T2_WR <= (not C2) and (C1 xor C0);
PC_WR <= (C2 and (C1 or C0)) or ((not C2) and (not C1) and (not C0));
T3_WR <= (not C2) and (not C1) and C0;
RF_WR <= (not C2) and C1 and C0;
Mem_WR <= C2 and (not C1) and (not C0);

end bhv;