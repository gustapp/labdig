library IEEE;
use IEEE.std_logic_1164.all;

entity unidade_controle is
  port(
    clock                 : in  std_logic;
    reset                 : in  std_logic;
    entrada_serial        : in  std_logic;
    finaliza_recepcao     : in  std_logic;
    finaliza_paridade     : in  std_logic;
    recebendo             : out std_logic;
    verificando_paridade  : out std_logic;
    apresentando          : out std_logic;
    saida_estado          : out std_logic_vector(1 downto 0)
  );
end unidade_controle;

architecture estados of unidade_controle is
type tipo_estado is (INICIAL, RECEBE, VERIFICA_PARIDADE, APRESENTA);
signal estado : tipo_estado;
begin

  process (clock, entrada_serial, finaliza_recepcao, finaliza_paridade)
  begin

  if reset = '1' then
    estado <= INICIAL;
  elsif clock'event and clock = '1' then
    case estado is
      when INICIAL =>
        if entrada_serial = '0' then
          estado <= RECEBE;
        else
          estado <= INICIAL;
        end if;
      when RECEBE =>
        if finaliza_recepcao = '1' then
          estado <= VERIFICA_PARIDADE;
        else
          estado <= RECEBE;
        end if;
      when VERIFICA_PARIDADE =>
        if finaliza_paridade = '1' then
          estado <= APRESENTA;
        else
          estado <= VERIFICA_PARIDADE;
        end if;
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
        saida_estado <= "00";
        recebendo <= '0';
        verificando_paridade <= '0';
        apresentando <= '0';
      when RECEBE =>
        saida_estado <= "01";
        recebendo <= '1';
        verificando_paridade <= '0';
        apresentando <= '0';
      when VERIFICA_PARIDADE =>
        saida_estado <= "10";
        recebendo <= '0';
        verificando_paridade <= '1';
        apresentando <= '0';
      when APRESENTA =>
        saida_estado <= "11";
        recebendo <= '0';
        verificando_paridade <= '0';
        apresentando <= '1';
    end case;
  end process;
end estados;
