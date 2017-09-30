library IEEE;
use IEEE.std_logic_1164.all;

entity Transmissao is
	port (
		clock						: in  std_logic;
		reset						: in  std_logic;
		tick_tx					: in  std_logic;
		partida					: in  std_logic;
		dados_ascii			: in  std_logic;
		pronto					: out std_logic;
		saida						: out std_logic
	);
end Transmissao;

architecture hierarquica of Transmissao is





begin



end hierarquica;
