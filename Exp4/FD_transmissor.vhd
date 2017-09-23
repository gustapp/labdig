library ieee;
use ieee.std_logic_1164.all;

entity FD_transmissor is
	port(dado_serial			: in  std_logic;
		  enable_transmissao : in std_logic;
		  TD						: out std_logic);
end FD_transmissor;

architecture combinatorio of FD_transmissor is

begin
	process (dado_serial, enable_transmissao)
	begin
		TD <= dado_serial and enable_transmissao;
	end process;

end combinatorio;
