library ieee;
use ieee.std_logic_1164.all;

entity circuito_recepcao is
	port(liga			 	 : in  std_logic;
		  reset		    	 : in  std_logic;
		  CD		       	 : in  std_logic;
		  RD		       	 : in  std_logic;
		  clock		    	 : in  std_logic;
		  DTR				    : out std_logic;
		  temDadoRecebido	 : out std_logic;
		  DadoRecebido		 : out std_logic;
		  d_estado			 : out std_logic_vector(1 downto 0));
end circuito_recepcao;

architecture circuito_recepcao_Arch of circuito_recepcao is 
	
	component fluxo_de_dados_recepcao is 
		port(RD						: in  std_logic;
			  enable_recepcao    : in std_logic;
			  DadoRecebido			: out std_logic);
	end component;

	component unidade_controle_recepcao is
		port(liga			 	 	: in  std_logic;
			  reset		    	 	: in  std_logic;
			  CD		       	   : in  std_logic;
			  clock		    	 	: in  std_logic;
			  enable_recepcao    : out std_logic;
			  DTR				      : out std_logic;
			  s_estado				: out std_logic_vector(1 downto 0));
	end component;

signal s_enable_recepcao : std_logic;
	
begin 
	
	k1 : unidade_controle_recepcao port map (liga, reset, CD, clock, s_enable_recepcao, DTR, d_estado);
	k2 : fluxo_de_dados_recepcao   port map (RD, s_enable_recepcao, DadoRecebido);
	
	temDadoRecebido <= s_enable_recepcao;

end circuito_recepcao_Arch;