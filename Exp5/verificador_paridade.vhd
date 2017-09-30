veilibrary ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity verificador_paridade is
    port(
         reset      	: in  std_logic;
			enable		: in  std_logic;
			input_data	: in 	std_logic_vector(7 downto 0);
         paridadeOK  : out std_logic);
end verificador_paridade;

architecture exemplo of verificador_paridade is

begin
	process (reset, enable)
	begin
	if reset = '1' then
		paridadeOK <= '0';
	elsif enable = '1' then
		paridadeOK <= input_data(7) xor (not (input_data(6) xor input_data(5) xor input_data(4) xor input_data(3) xor input_data(2) xor input_data(1) xor input_data(0)));
	end if;
	end process;
end exemplo;
