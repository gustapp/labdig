library ieee;
use ieee.std_logic_1164.all;

entity transmissor is
	port(liga			 	  : in  std_logic;
		  enviar			 	 : in  std_logic;
		  reset		    	 : in  std_logic;
		  clock		    	 : in  std_logic;
		  dado_serial    : in  std_logic;
      CTS            : in  std_logic;
		  envioOk	    	 : out std_logic;
		  DTR			       : out std_logic;
		  RTS		       	 : out std_logic;
		  TD		       	 : out std_logic;
		  d_estado			 : out std_logic_vector(1 downto 0));
end transmissor;

architecture hierarquico of transmissor is

	component FD_transmissor is
		port(dado_serial			: in  std_logic;
			  enable_transmissao : in std_logic;
			  TD						: out std_logic);
	end component;

	component UC_transmissor is
		port(liga			 	 	: in  std_logic;
			  enviar			 	 	: in  std_logic;
			  reset		    	 	: in  std_logic;
			  clock		    	 	: in  std_logic;
        CTS             : in  std_logic;
			  DTR			       	: out std_logic;
			  RTS		       	 	: out std_logic;
			  enable_transmissao : out std_logic;
			  s_estado				: out std_logic_vector(1 downto 0));
	end component;

signal s_enable_transmissao : std_logic;

begin

	k1 : UC_transmissor port map (liga, enviar, reset, clock, CTS, DTR, RTS, s_enable_transmissao, d_estado);
	k2 : FD_transmissor   port map (dado_serial, s_enable_transmissao, TD);

	envioOk <= s_enable_transmissao;

end hierarquico;
