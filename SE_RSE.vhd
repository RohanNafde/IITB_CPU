-- Sign Extender 6

library ieee;
use ieee.std_logic_1164.all;

entity SE6 is
	port (A: in std_logic_vector(5 downto 0);
			B: out std_logic_vector(15 downto 0));
end entity;

architecture bhv of SE6 is
begin
	B <= "000000000" & A(5 downto 0);
end bhv;


-- Sign Extender 9

library ieee;
use ieee.std_logic_1164.all;

entity SE9 is
	port (A: in std_logic_vector(8 downto 0);
			B: out std_logic_vector(15 downto 0));
end entity;

architecture bhv of SE9 is
begin
	B <= "000000" & A(8 downto 0);
end bhv;


-- What is its name?


library ieee;
use ieee.std_logic_1164.all;

entity RSE9 is
	port (A: in std_logic_vector(8 downto 0); 
			B: out std_logic_vector(15 downto 0));
end entity;

architecture bhv of RSE9 is
begin
	B <= A(8 downto 0) & "000000";
end bhv;