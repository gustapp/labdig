library IEEE;
use IEEE.std_logic_1164.all;

entity Recepcao is
	port (
		clock						: in  std_logic;
		reset						: in  std_logic;
		tick_rx					: in  std_logic;
		dado_serial				: in  std_logic;
		dado						: out std_logic;
		pronto					: out std_logic;
		paridade_ok				: out std_logic
	);
end Recepcao;

architecture hierarquica of Recepcao is





begin



end hierarquica;
