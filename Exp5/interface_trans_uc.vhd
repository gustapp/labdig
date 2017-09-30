-- VHDL da Unidade de Controle

library ieee;
use ieee.std_logic_1164.all;

entity interface_trans_uc is
   port(clock              : in   std_logic;
        reseta             : in   std_logic;
        transmite_dado     : in   std_logic;
		pronto     		   : in   std_logic;
        trans_andamento    : out  std_logic);
end interface_trans_uc;

architecture interface_trans_uc_arch of interface_trans_uc is
type tipo_estado is (inicial, transmissao);
signal estado   : tipo_estado;

begin
	process (clock, estado, reseta)
	begin

	if reseta = '1' then
		estado <= inicial;

	elsif (clock'event and clock = '1') then
		case estado is
			when inicial =>			-- Aguarda sinal de inicio de transmissão
				if transmite_dado = '1' then
					estado <= transmissao;
				else
					estado <= inicial;
				end if;

			when transmissao =>
				if pronto = '1' then
					estado <= inicial;
				else
					estado <= transmissao;
				end if;
		end case;
	end if;
	end process;

	process (estado)
	begin
		case estado is
			when inicial =>
				trans_andamento <= '0';
			when transmissao =>
				trans_andamento <= '1';
		end case;
   end process;
end interface_trans_uc_arch;
