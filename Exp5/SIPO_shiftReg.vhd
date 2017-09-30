SIlibrary IEEE;
use IEEE.std_logic_1164.all;

entity SIPO_shiftReg is
	port (clock, reset, enable			: in  std_logic;
			input_data						: in  std_logic;
			saida								: out std_logic_vector(7 downto 0):= (others => '1'));
end SIPO_shiftReg;

architecture behavioral of SIPO_shiftReg is
signal IQ: std_logic_vector(7 downto 0);
begin
	process(clock, reset, enable, input_data)
	begin
	if(clock'event and clock = '1' ) then
		if reset = '1' then
			IQ <= (others => '0');
		elsif enable = '1' then
			IQ <= input_data & IQ(7 downto 1);
		end if;
	end if;
	end process;
	saida <= IQ;
end behavioral;
	
