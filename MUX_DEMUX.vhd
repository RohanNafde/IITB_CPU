
-- MUXes


-- 2 to 1 MUX

library ieee;
use ieee.std_logic_1164.all;

entity mux_2to1 is
	port(A0, A1, S0 : in std_logic;
		Z: out std_logic);
end mux_2to1;

architecture bhv of mux_2to1 is

begin
	process (A0, A1, S0) is
	begin
		if (S0 ='0') then
			Z <= A0;
		elsif (S0 ='1') then
			Z <= A1;
		end if;
	end process;
end bhv;

-- 4 to 1 MUX

library ieee;
use ieee.std_logic_1164.all;

entity mux_4to1 is
	port(A0, A1, A2, A3, S0, S1 : in std_logic;
		Z: out std_logic);
end mux_4to1;

architecture bhv of mux_4to1 is

begin
	process (A0, A1, A2, A3, S0, S1) is
	begin
		if (S0 ='0' and S1 = '0') then
			Z <= A0;
		elsif (S0 ='1' and S1 = '0') then
			Z <= A1;
		elsif (S0 ='0' and S1 = '1') then
			Z <= A2;
		elsif (S0 ='1' and S1 = '1') then
			Z <= A3;
		end if;
	end process;
end bhv;

-- 8 to 1 MUX

library ieee;
use ieee.std_logic_1164.all;

entity mux_8to1 is
	port(A0, A1, A2, A3, A4, A5, A6, A7, S0, S1, S2 : in std_logic;
		Z: out std_logic);
end mux_8to1;

architecture bhv of mux_8to1 is

begin
	process (A0, A1, A2, A3, A4, A5, A6, A7, S0, S1, S2) is
	begin
		if (S0 ='0' and S1 = '0' and S2 = '0') then
			Z <= A0;
		elsif (S0 ='1' and S1 = '0' and S2 = '0') then
			Z <= A1;
		elsif (S0 ='0' and S1 = '1' and S2 = '0') then
			Z <= A2;
		elsif (S0 ='1' and S1 = '1' and S2 = '0') then
			Z <= A3;
		elsif (S0 ='0' and S1 = '0' and S2 = '1') then
			Z <= A4;
		elsif (S0 ='1' and S1 = '0' and S2 = '1') then
			Z <= A5;
		elsif (S0 ='0' and S1 = '1' and S2 = '1') then
			Z <= A6;
		elsif (S0 ='1' and S1 = '1' and S2 = '1') then
			Z <= A7;
		end if;
	end process;
end bhv;


--DEMUXes


-- 1 to 2 DEMUX

library ieee;
use ieee.std_logic_1164.all;

entity demux_1to2 is
	port(F, S0 : in std_logic;
	A0, A1: out std_logic);
end demux_1to2;

architecture bhv of demux_1to2 is

begin
	process (F, S0) is
	begin
		if (S0 ='0') then
			A0 <= F;
		elsif (S0 ='1') then
		end if;
	end process;
end bhv;

-- 1 to 4 DEMUX

library ieee;
use ieee.std_logic_1164.all;

entity demux_1to4 is
	port(F, S0, S1 : in std_logic;
	A0, A1, A2, A3: out std_logic);
end demux_1to4;

architecture bhv of demux_1to4 is

begin
	process (F, S0, S1) is
	begin
		if (S0 ='0' and S1 = '0') then
			A0 <= F;
		elsif (S0 ='1' and S1 = '0') then
			A1 <= F;
		elsif (S0 ='0' and S1 = '1') then
			A2 <= F;
		elsif (S0 ='1' and S1 = '1') then
			A3 <= F;
		end if;
	end process;
end bhv;

-- 1 to 8 DEMUX

library ieee;
use ieee.std_logic_1164.all;

entity demux_1to8 is
	port(F, S0, S1, S2 : in std_logic;
	A0, A1, A2, A3, A4, A5, A6, A7: out std_logic);
end demux_1to8;

architecture bhv of demux_1to8 is

begin
	process (F, S0, S1, S2) is
	begin
		if (S0 ='0' and S1 = '0' and S2 = '0') then
			A0 <= F;
		elsif (S0 ='1' and S1 = '0' and S2 = '0') then
			A1 <= F;
		elsif (S0 ='0' and S1 = '1' and S2 = '0') then
			A2 <= F;
		elsif (S0 ='1' and S1 = '1' and S2 = '0') then
			A3 <= F;
		elsif (S0 ='0' and S1 = '0' and S2 = '1') then
			A4 <= F;
		elsif (S0 ='1' and S1 = '0' and S2 = '1') then
			A5 <= F;
		elsif (S0 ='0' and S1 = '1' and S2 = '1') then
			A6 <= F;
		elsif (S0 ='1' and S1 = '1' and S2 = '1') then
			A7 <= F;
		end if;
	end process;
end bhv;
