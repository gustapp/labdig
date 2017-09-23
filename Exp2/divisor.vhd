library IEEE;
use IEEE.std_logic_1164.all;

entity divisor is

	port(
    clock      : in  std_logic;
	  reset      : in  std_logic;
	  enable     : in  std_logic;
    e_s        : in  std_logic;
	  amostra    : out std_logic;
    amostragem : out std_logic;
	  conta4     : out std_logic_vector(1 downto 0);
	  conta8     : out std_logic_vector(3 downto 0));
end divisor;

architecture structure of divisor is

	component contador_mod4 is
		port(
        clock		  : in std_logic;
			  reset		  : in std_logic;
			  enable		: in std_logic;
		    contagem	: out std_logic_vector(1 downto 0);
		    fim			  : out std_logic);
	end component;

	component contador_mod8 is
			port(
        clock	   	: in std_logic;
			  reset	  	: in std_logic;
			  enable 		: in std_logic;
			  contagem	: out std_logic_vector(3 downto 0);
			  fim		  	: out std_logic);
	end component;

signal fim_mod4, fim_mod8 : std_logic;
begin

	c1 : contador_mod4 port map (clock, reset, enable, conta4, fim_mod4);
	c2 : contador_mod8 port map(clock, reset, enable, conta8, fim_mod8);

	amostra    <=  fim_mod4 xor fim_mod8;
  amostragem <=  fim_mod4 xor fim_mod8 and e_s;

end structure;
