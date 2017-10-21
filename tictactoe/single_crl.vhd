library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity single_crl is
	port(
	 clock                 : in  std_logic;
	 reset                 : in  std_logic;
	 enable					  : in  std_logic;
	 player			        : in  std_logic; -- '0' player 1 ;
														 -- '1' palyer 2
	 saida	              : out std_logic_vector(1 downto 0); -- '00' vazio;
																				  -- '01' player 1;
																				  -- '10' player 2;
																				  -- '11' erro
	 handler					  : out std_logic_vector(1 downto 0)
  );
end single_crl;

architecture estados of single_crl is
type tipo_estado is (INICIAL, PLAYER_ONE, PLAYER_TWO, ERRO_ONE, ERRO_TWO);
signal estado : tipo_estado;
begin

  process (clock, reset, enable, player)
  begin

  if reset = '1' then
    estado <= INICIAL;
  elsif clock'event and clock = '1' then
    case estado is
      when INICIAL =>
        if enable = '1' then
          if player = '1' then
				estado <= PLAYER_ONE;
			else
				estado <= PLAYER_TWO;
			end if;
        end if;
		when PLAYER_ONE =>
			if enable = '1' then
          estado <= ERRO_ONE;
        end if;
      when PLAYER_TWO =>
        if enable = '1' then
          estado <= ERRO_TWO;
        end if;
      when ERRO_ONE =>
        estado <= PLAYER_ONE;
      when ERRO_TWO =>
        estado <= PLAYER_TWO;
    end case;
  end if;
  end process;

  process (estado)
  begin
    case estado is
      when INICIAL =>
			saida <= "00";
			handler <= "00";
		when PLAYER_ONE =>
			saida <= "01";
			handler <= "01";
      when PLAYER_TWO =>
			saida <= "10";
			handler <= "10";
      when ERRO_ONE =>
			saida <= "01";
			handler <= "11";
      when ERRO_TWO =>
			saida <= "10";
			handler <= "11";
    end case;
  end process;
end estados;
