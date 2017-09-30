library IEEE;
use IEEE.std_logic_1164.all;

entity Interface is
	port (
		clock						  : in  std_logic;
		reset						  : in  std_logic;
		dado						  : in  std_logic;
		prontoRecep				: in  std_logic;
		paridadeOK				: in  std_logic;
		prontoTransm			: in  std_logic;
		recebe_dado				: in  std_logic;
		transmite_dado		: in  std_logic;
		dado_trans				: in  std_logic_vector(6 downto 0); -- Chaves SW6 a SW0
		dado_rec					: out std_logic_vector(6 downto 0);
		transm_andamento	: out std_logic;
		tem_dado_rec			: out std_logic;
		partida					  : out std_logic;
		dados_ascii				: out std_logic
	);
end Interface;

architecture hierarquica of Interface is





begin



end hierarquica;
