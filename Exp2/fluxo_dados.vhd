library IEEE;
use IEEE.std_logic_1164.all;

entity fluxo_dados is
  port ();
end fluxo_dados;

architecture estrutural of fluxo_dados is

  component divisor is
  	port(
      clock      : in  std_logic;
  	  reset      : in  std_logic;
  	  enable     : in  std_logic;
  	  amostra    : out std_logic;
  	  conta4     : out std_logic_vector(1 downto 0);
  	  conta8     : out std_logic_vector(3 downto 0));
  end component;


begin


end estrutural;
