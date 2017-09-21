library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity contador_mod8 is
    port(clock     : in  std_logic;
         reset     : in  std_logic;
         enable    : in  std_logic;
         contagem  : out std_logic_vector(2 downto 0);
         fim       : out std_logic);
end contador_mod8;

architecture exemplo of contador_mod8 is
signal IQ: unsigned(2 downto 0);

begin
	process (clock, conta, IQ, zera)
	begin

	if clock'event and clock = '1' then
		if zera = '1' then
			IQ <= (others => '0');
		elsif conta = '1' then
			IQ <= IQ + 1;
		end if;
	end if;

  if IQ = 7 then
		fim <= '1';
	else
		fim <= '0';
	end if;

	contagem <= std_logic_vector(IQ);

	end process;
end exemplo;
