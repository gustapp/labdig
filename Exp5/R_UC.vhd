library IEEE;
use IEEE.std_logic_1164.all;

entity R_UC is
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
end R_UC;

architecture estados of unidade_controle is
type tipo_estado is (INICIAL, VERIFICA_AMOSTRA, RECEBE, VERIFICA_PARIDADE, APRESENTA);
signal estado : tipo_estado;
begin

  process (clock, e_s, finaliza_recepcao)
  begin

  if reset = '1' then
    estado <= INICIAL;
  elsif clock'event and clock = '1' then
    case estado is
      when INICIAL =>
        if e_s = '0' then
          estado <= VERIFICA_AMOSTRA;
        else
          estado <= INICIAL;
        end if;
		when VERIFICA_AMOSTRA =>
			if e_s = '0' and amostra = '1' then
				estado <= RECEBE;
			elsif e_s = '1' and amostra = '1' then
				estado <= INICIAL;
			else
				estado <= VERIFICA_AMOSTRA;
			end if;
      when RECEBE =>
        if finaliza_recepcao = '1' then
          estado <= VERIFICA_PARIDADE;
        else
          estado <= RECEBE;
        end if;
      when VERIFICA_PARIDADE =>
        estado <= APRESENTA;
      when APRESENTA =>
        if reset = '1' then
          estado <= INICIAL;
        else
          estado <= APRESENTA;
        end if;
    end case;
  end if;
  end process;

  process (estado)
  begin
    case estado is
      when INICIAL =>
        saida_estado <= "000";
		  amostrando <= '0';
        recebendo <= '0';
        verificando_paridade <= '0';
        apresentando <= '0';
		when VERIFICA_AMOSTRA =>
			saida_estado <= "001";
			amostrando <= '1';
			recebendo <= '0';
			verificando_paridade <= '0';
			apresentando <= '0';
      when RECEBE =>
        saida_estado <= "010";
		  amostrando <= '0';
        recebendo <= '1';
        verificando_paridade <= '0';
        apresentando <= '0';
      when VERIFICA_PARIDADE =>
        saida_estado <= "011";
		  amostrando <= '0';
        recebendo <= '0';
        verificando_paridade <= '1';
        apresentando <= '0';
      when APRESENTA =>
        saida_estado <= "100";
		  amostrando <= '0';
        recebendo <= '0';
        verificando_paridade <= '0';
        apresentando <= '1';
    end case;
  end process;
end estados;
