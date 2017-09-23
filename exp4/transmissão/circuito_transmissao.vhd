library ieee;
use ieee.std_logic_1164.all;

entity circuito_transmissao is
	port(liga			 	 : in  std_logic;
		  enviar			 	 : in  std_logic;
		  reset		    	 : in  std_logic;
		  clock		    	 : in  std_logic;
		  dado_serial   	 : in  std_logic;
		  envioOk	    	 : out std_logic;
		  DTR			       : out std_logic;
		  RTS		       	 : out std_logic;
		  TD		       	 : out std_logic;
		  d_estado			 : out std_logic_vector(1 downto 0));
end circuito_transmissao;

architecture circuito_transmissao_Arch of circuito_transmissao is 
	
	component fluxo_de_dados_transmissao is 
		port(dado_serial			: in  std_logic;
			  enable_transmissao : in std_logic;
			  TD						: out std_logic);
	end component;

	component unidade_controle_transmissao is
		port(liga			 	 	: in  std_logic;
			  enviar			 	 	: in  std_logic;
			  reset		    	 	: in  std_logic;
			  clock		    	 	: in  std_logic;
			  DTR			       	: out std_logic;
			  RTS		       	 	: out std_logic;
			  enable_transmissao : out std_logic;
			  s_estado				: out std_logic_vector(1 downto 0));
	end component;

signal s_enable_transmissao : std_logic;
	
begin 
	
	k1 : unidade_controle_transmissao port map (liga, enviar, reset, clock, DTR, RTS, s_enable_transmissao, d_estado);
	k2 : fluxo_de_dados_transmissao   port map (dado_serial, s_enable_transmissao, TD);
	
	envioOk <= s_enable_transmissao;

end circuito_transmissao_Arch;