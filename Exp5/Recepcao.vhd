library IEEE;
use IEEE.std_logic_1164.all;

entity Recepcao is
	port (
		clock						: in  std_logic;
		reset						: in  std_logic;
		tick_rx					: in  std_logic;
		dado_serial			: in  std_logic;
		dado						: out std_logic;
		pronto					: out std_logic;
		paridade_ok			: out std_logic
	);
end Recepcao;

architecture hierarquica of Recepcao is

  component R_FD is
		port(
		  clock							: in  std_logic;
	    reset							: in  std_logic;
		  e_s							: in  std_logic;
	    amostrando					: in  std_logic;
		  recebendo 					: in  std_logic;
		  verificando_paridade		: in  std_logic;
		  apresentando				: in  std_logic;
	    amostra						: out std_logic;
		  finaliza_recepcao			: out std_logic;
		  paridadeOK					: out std_logic;
		  saida							: out std_logic_vector(7 downto 0);
		  display1						: out std_logic_vector(6 downto 0);
		  display2						: out std_logic_vector(6 downto 0);
		  dep_mod9						: out std_logic_vector(3 downto 0)
	 );
	end component;

	component R_UC is
		port(
		 clock                 : in  std_logic;
		 reset                 : in  std_logic;
		 e_s						  : in  std_logic;
		 amostra			        : in  std_logic;
		 finaliza_recepcao     : in  std_logic;
		 amostrando				  : out std_logic;
		 recebendo             : out std_logic;
		 verificando_paridade  : out std_logic;
		 apresentando          : out std_logic;
		 saida_estado          : out std_logic_vector(2 downto 0)
	);
	end component;

signal s_amostrando, s_recebendo, s_verificando_paridade, s_apresentando : std_logic;
signal s_amostra : std_logic;
signal s_finaliza_recepcao : std_logic;

begin

	FD: fluxo_dados port map(clock, reset, e_s, s_amostrando, s_recebendo, s_verificando_paridade, s_apresentando, s_amostra, s_finaliza_recepcao, paridadeOK, saida, display1, display2, dep_mod9);
	UC: unidade_controle port map(clock, reset, e_s, s_amostra, s_finaliza_recepcao, s_amostrando, s_recebendo, s_verificando_paridade, s_apresentando, UC_estado);

end hierarquica;
