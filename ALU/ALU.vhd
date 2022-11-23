library ieee;
use ieee.std_logic_1164.all;

entity alu is
	port(A: in std_logic_vector(15 downto 0);
		 B: in std_logic_vector(15 downto 0);
		 C: out std_logic_vector(15 downto 0);
		 control_lines: in std_logic_vector(1 downto 0);
		 carry_out: out std_logic;
		 zero_out: out std_logic);
end entity;

architecture behav of alu is
	signal temp_add: std_logic_vector(16 downto 0)
	
	-- Adder
	function add(A: in std_logic_vector(15 downto 0);
		B: in std_logic_vector(15 downto 0))
	return std_logic_vector is
	
	variable sum : std_logic_vector(16 downto 0):= (others=>'0');
	variable carry : std_logic_vector(16 downto 0):= (others=>'0');
	
	begin
		full_adder:
		for i in 0 to 15 loop
			sum(i):= carry(i) xor (A(i) xor B(i));
			carry(i+1):= (A(i) and B(i)) or (B(i) and carry(i)) or (A(i) and carry(i));
		end loop full_adder;
		
		sum(16):= carry(16);
		return sum;
	end add;
	
	-- Subtractor
	function sub(A: in std_logic_vector(15 downto 0);
		B: in std_logic_vector(15 downto 0))
	return std_logic_vector is
	
	variable B_Bar : std_logic_vector(15 downto 0):= (others=>'0');
	variable B_2comp : std_logic_vector(15 downto 0):= (others=>'0');
	variable Temp1 : std_logic_vector(16 downto 0):= (others=>'0');
	variable Temp2 : std_logic_vector(16 downto 0):= (others=>'0');
	variable add_1 : std_logic_vector(15 downto 0):= (0 => '1', others=>'0');
	variable diff : std_logic_vector(15 downto 0):= (others=>'0');
	variable carry : std_logic:= '1';
	
	begin
		B_Bar := not B;
		Temp1 := add(B_Bar, add_1);
		B_2comp := Temp1(15 downto 0);
		Temp2 := add(B_2comp, A);
		diff := Temp2(15 downto 0);
		
	return diff;
	end sub;
	
	-- Bitwise NAND
	function Bitwise(A: in std_logic_vector(15 downto 0);
		B: in std_logic_vector(15 downto 0))
	return std_logic_vector is
	
	variable bitwise : std_logic_vector(15 downto 0):= (others=>'0');
	
	begin
		bit_nand:
		for i in 0 to 15 loop
			bitwise(i) := A(i) nand B(i);
		end loop bit_nand;
		
	return bitwise;
	end Bitwise;
	
	-- main
	begin
		alu : process(A, B, control_lines)
		begin
			temp_add <= add(A, B)
			
			main_if:
			if (control_lines(3) = '0')and(control_lines(3) = '0') then
				C <= temp_add(15 downto 0);
				carry_flag <= temp_add(16);
				if (unsigned(C)=0)
					zero_out <= '1';
				else
					zero_out <= '0';
				end if;
			elsif (control_lines(3) = '0')and(control_lines(3) = '1') then
				C <= sub(B, A);
				if (unsigned(C)=0)
					zero_out <= '1';
				else
					zero_out <= '0';
				end if;
			elsif (control_lines(3) = '1')and(control_lines(3) = '0') then
				C <= Bitwise(A, B);
				if (unsigned(C)=0)
					zero_out <= '1';
				else
					zero_out <= '0';
				end if;
			end if main_if;
		end process ;
	end behav ;