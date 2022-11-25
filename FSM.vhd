library ieee;
use ieee.std_logic_1164.all;

entity fsm is
	port(clock, reset: in std_logic; op_code: in std_logic_vector (3 downto 0);  
			C2, C1, C0: out std_logic  );
end fsm;

architecture bhv of fsm is

type statetype is (S1, S2, S3, S4, S5, S6, S7, S8);
signal ps, ns : statetype;  

begin 

	update: process(clock, reset)
	begin
		if(reset='1')then 
			ps <= S1;
		elsif(clock' event and clock = '1')then
			ps <= ns;
		end if;
	end process update;

	next_state_output_logic: process (ps, op_code)
	begin 
		case ps is 

		when S1 =>
			if op_code = "0011" or op_code = "1001" or op_code = "1000" then 
				ns <= S4;
			else 
				ns <= S2;
			end if;

		when S2 =>
			if op_code = "0001" or op_code = "0000" then 
				ns <= S1;
			else 
				ns <= S3;
			end if;

		when S3 =>
			if op_code(3) = '1' or op_code(2) = '1' then 
				ns <= S6;
			elsif op_code(2) = '1' or op_code(0) = '1' then 
				ns <= S5;
			else 
				ns <= S4;
			end if;

		when S4 =>
			if op_code(2) = '1' or op_code(1) = '1' then 
				ns <= S3;
			elsif op_code = "1000" or op_code = "1010" then 
				ns <= S6;
			elsif op_code = "1001" or op_code = "1011" then 
				ns <= S8;
			else 
				ns <= S1;
			end if;

		when S5 =>
			if op_code(2) = '1' or op_code(1) = '1' then 
				ns <= S3;
			else 
				ns <= S1;
			end if;

		when S6 =>
			if op_code(3) = '1' or op_code(2) = '0' then 
				ns <= S1;
			else 
				ns <= S7;
			end if;
				
		when S7 =>
			ns <= S1;

		when S8 =>
			ns <= S1;

		end case; 
	end process next_state_output_logic;

	Output_process: process(ps)
	begin
		case ps is

		when S1 =>
			C2 <= '0';
			C1 <= '0';
			C0 <= '0';

		when S2 =>
			C2 <= '0';
			C1 <= '0';
			C0 <= '1';

		when S3 =>
			C2 <= '0';
			C1 <= '1';
			C0 <= '0';

		when S4 =>
			C2 <= '0';
			C1 <= '1';
			C0 <= '1';

		when S5 =>
			C2 <= '1';
			C1 <= '0';
			C0 <= '0';

		when S6 =>
			C2 <= '1';
			C1 <= '0';
			C0 <= '1';

		when S7 =>
			C2 <= '1';
			C1 <= '1';
			C0 <= '0';

		when S8 =>
			C2 <= '1';
			C1 <= '1';
			C0 <= '1';
			
		end case;
	end process Output_process;

end bhv;
