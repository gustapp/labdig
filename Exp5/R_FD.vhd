library IEEE;
use IEEE.std_logic_1164.all;

entity R_FD is
	port(
		clock							: in  std_logic;
	   reset							: in  std_logic;
		 e_s							: in  std_logic;
	   amostrando					: in  std_logic;
		recebendo					: in  std_logic;
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
end R_FD;

architecture hierarquico of fluxo_dados is

	component divisor is
		port(
		  clock		: in  std_logic;
		  zera		: in  std_logic;
		  conta		: in  std_logic;
		  amostra	: out std_logic;
		  conta4		: out std_logic_vector(1 downto 0);
		  conta8		: out std_logic_vector(2 downto 0));
	end component;

	component contador_mod9 is
		port(clock     : in  std_logic;
			  zera      : in  std_logic;
           conta     : in  std_logic;
           contagem  : out std_logic_vector(3 downto 0);
           fim       : out std_logic);
	end component;

	component SIPO_shiftReg is
		port (clock, reset, enable			: in  std_logic;
				input_data						: in  std_logic;
				saida								: out std_logic_vector(7 downto 0):= (others => '1'));
	end component;

	component verificador_paridade is
    port(
         reset      	: in  std_logic;
			enable		: in  std_logic;
			input_data	: in 	std_logic_vector(7 downto 0);
         paridadeOK  : out std_logic);
	end component;

	component hex7seg_en is
		port (
			x3, x2, x1, x0 : in std_logic;
			enable : in std_logic;
			a,b,c,d,e,f,g : out std_logic
		);
	end component;


signal s_divide 			: std_logic;
signal s_amostra 			: std_logic;
signal s_conta 			: std_logic;
signal reset_contador	: std_logic;
signal s_saida				: std_logic_vector(7 downto 0);

begin

s_divide 		<= amostrando 		or 	recebendo;
s_conta 			<= recebendo 		and 	s_amostra;
reset_contador <= reset 			or 	verificando_paridade or apresentando;

	c1: divisor 					port map(clock, reset_contador, s_divide, s_amostra, open, open);
	c2: contador_mod9 			port map(clock, reset_contador, s_conta, dep_mod9, finaliza_recepcao);
	c3: SIPO_shiftReg 			port map(clock, reset, s_conta, e_s, s_saida);
	c4: verificador_paridade 	port map(reset, verificando_paridade, s_saida, paridadeOK);
	c5: hex7seg_en					port map(s_saida(3), s_saida(2), s_saida(1), s_saida(0), apresentando, display1(6), display1(5), display1(4), display1(3), display1(2), display1(1), display1(0));
	c6: hex7seg_en					port map('0', s_saida(6), s_saida(5), s_saida(4), apresentando, display2(6), display2(5), display2(4), display2(3), display2(2), display2(1), display2(0));

amostra 	<= s_amostra;
saida 	<= s_saida;

end hierarquico;
