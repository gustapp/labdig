library ieee;
use ieee.std_logic_1164.all;

entity fluxo_de_dados_recepcao is 
	port(RD						: in  std_logic;
		  enable_recepcao    : in std_logic;
		  DadoRecebido			: out std_logic);
end fluxo_de_dados_recepcao;

architecture fluxo_de_dados_recepcao_arch of fluxo_de_dados_recepcao is 
	
begin 
	process (RD, enable_recepcao)
	begin
		DadoRecebido <= RD and enable_recepcao;
	end process;

end fluxo_de_dados_recepcao_arch;