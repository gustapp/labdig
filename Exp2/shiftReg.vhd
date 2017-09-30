library ieee;
use ieee.std_logic_1164.all;

entity shiftReg is
    port(clock      : in  std_logic;
         load       : in  std_logic;
         shift      : in  std_logic;
         e_s        : in  std_logic;
         bit_out    : out std_logic_vector(11 downto 0) := '0');
end shiftReg;

architecture exemplo of shiftReg is
signal IQ				: std_logic_vector(11 downto 0);
signal paridade		: std_logic;

begin
	process (clock, load, shift, IQ)
	begin

	if (clock'event and clock = '1') then
		if (shift = '1') then
			bit_out <= IQ(0);
			IQ <= RIN & IQ(11 downto 1);
		end if;
  end if;
    saida <= IQ;
	end process;
end exemplo;
