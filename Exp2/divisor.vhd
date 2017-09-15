library IEEE;
use IEEE.std_logic_1164.all;

entity divisor is

	port(
      clock		: in std_logic;
		  zera		: in std_logic;
		  conta		: in std_logic;
		  amostra	: out std_logic;
		  conta4		: out std_logic_vector(1 downto 0);
		  conta8		: out std_logic_vector(3 downto 0));
end divisor;

architecture structure of divisor is

	component contador_mod4 is
		port(
        clock		: in std_logic;
			  zera		: in std_logic;
			  conta 		: in std_logic;
		    contagem	: out std_logic_vector(1 downto 0);
		    fim			: out std_logic);
	end component;

	component contador_mod8 is
			port(
        clock		: in std_logic;
			  zera		: in std_logic;
			  conta 		: in std_logic;
			  contagem	: out std_logic_vector(3 downto 0);
			  fim			: out std_logic);
	end component;

signal s1, s2 : std_logic;
begin

	c1 : contador_mod4 port map (clock, zera, conta, conta4, s1);
	c2 : contador_mod8 port map(clock, zera, conta, conta8, s2);

	amostra <= s1 xor s2;

end structure;
