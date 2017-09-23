library ieee;
use ieee.std_logic_1164.all;

entity fluxo_de_dados_transmissao is 
	port(dado_serial			: in  std_logic;
		  enable_transmissao : in std_logic;
		  TD						: out std_logic);
end fluxo_de_dados_transmissao;

architecture fluxo_de_dados_transmissao_Arch of fluxo_de_dados_transmissao is 
	
begin 
	process (dado_serial, enable_transmissao)
	begin
		TD <= dado_serial and enable_transmissao;
	end process;

end fluxo_de_dados_transmissao_Arch;