library ieee;
use ieee.std_logic_1164.all;

entity SE6 is
port (A: in std_logic_vector(5 downto 0); B: out std_logic_vector(15 downto 0));
end entity;

architecture BHV of SE6 is
begin
	B <= "000000000" & A(5 downto 0);
end BHV;



library ieee;
use ieee.std_logic_1164.all;

entity SE9 is
port (A: in std_logic_vector(8 downto 0); B: out std_logic_vector(15 downto 0));
end entity;

architecture BHV of SE9 is
begin
	B <= "000000" & A(8 downto 0);
end BHV;



library ieee;
use ieee.std_logic_1164.all;

entity RSE9 is
port (A: in std_logic_vector(8 downto 0); B: out std_logic_vector(15 downto 0));
end entity;

architecture BHV of RSE9 is
begin
	B <= A(8 downto 0) & "000000";
end BHV;