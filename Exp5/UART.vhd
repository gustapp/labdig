library IEEE;
use IEEE.std_logic_1164.all;

entity UART is
	port (
		clock						 : in  std_logic;
		reset						 : in  std_logic; -- SW9
		recebe_dado			 : in  std_logic; -- SW8
		transmite_dado	 : in  std_logic; -- SW7
    dado_trans			 : in  std_logic_vector(6 downto 0); -- SW6 a SW0
		entrada					 : in  std_logic; --
    saida            : out std_logic; --
		transm_andamento : out std_logic; -- LEDR[0]
		dado_rec				 : out std_logic_vector(6 downto 0); -- HEX1 e HEX0
		tem_dado_rec		 : out std_logic  -- LEDR[9]
  );
end UART;

architecture hierarquica of UART is

	component GeradorTick is
		port (
			clock						: in  std_logic;
			reset						: in  std_logic;
			tick_tx					: out std_logic
		);
	end component;

	component Recepcao is
		port (
			clock						: in  std_logic;
			reset						: in  std_logic;
			tick_rx					: in  std_logic;
			dado_serial				: in  std_logic;
			dado						: out std_logic;
			pronto					: out std_logic;
			paridade_ok				: out std_logic
		);
	end component;


	component Transmissao is
		port (
			clock						: in  std_logic;
			reset						: in  std_logic;
			tick_tx					: in  std_logic;
			partida					: in  std_logic;
			dados_ascii			: in  std_logic;
			pronto					: out std_logic;
			saida						: out std_logic
		);
	end component;

	component Interface is
		port (
			clock						: in  std_logic;
			reset						: in  std_logic;
			dado						: in  std_logic;
			prontoRecep				: in  std_logic;
			paridadeOK				: in  std_logic;
			prontoTransm			: in  std_logic;
			recebe_dado				: in  std_logic;
			transmite_dado			: in  std_logic;
			dado_trans				: in  std_logic;
			dado_rec					: out std_logic;
			transm_andamento		: out std_logic;
			tem_dado_rec			: out std_logic;
			partida					: out std_logic;
			dados_ascii				: out std_logic
		);
	end component;

signal s_tx, s_rx, s_partida, s_dados_asc									: std_logic;
signal s_dado, s_pronto_trans, s_prontoRecep, s_paridade_ok			: std_logic;


begin


	z:	GeradorTick					generic map(M=>1200)  port map(clock, reset, s_rx);
	r:	Recepcao						port map(clock, reset, s_rx, entrada, s_dado, s_prontoRecep, s_paridade_ok);
	x:  GeradorTick					generic map(M=>19200) port map(clock, reset, s_tx);
	t:	Transmissao 				port map(clock, reset, s_tx, s_partida, s_dados_ascii, s_pronto_trans, saida);
	i:  Interface 					port map(clock, reset, s_dado, s_prontoRecep, s_paridade_ok, s_pronto_trans, recebe_dado, transmite_dado, dado_trans, dado_rec, transm_andamento, tem_dado_rec, s_partida, s_dados_ascii);



end hierarquica;
