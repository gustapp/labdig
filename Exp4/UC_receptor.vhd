library IEEE;
use IEEE.std_logic_1164.all;

entity UC_receptor is
  port(
    CLOCK, RESET, LIGA, CD          : in  std_logic;
    DTR, enable_recepcao            : out std_logic;
    estado                          : out std_logic_vector(1 downto 0)
  );
end UC_receptor;

architecture estados of UC_receptor is
type tipo_estado is (INICIAL, LIGADO, RECEBENDO)
signal estado : tipo_estado;
begin
  process (LIGA, RESET, CLOCK, estado)
  begin
  if RESET = '1'then
    estado <= INICIAL;
  elsif (clock'event and clock='1') then
    case estado is
      when INICIAL =>
        if LIGA = '1' then
          estado <= LIGADO;
        end if;
      when LIGADO =>
        if LIGA = '1' and CD = '1' then
          estado <= RECEBENDO;
        elsif LIGA = '0' then
          estado <= INICIAL;
        end if;
      when RECEBENDO =>
        if LIGA = '0' then
          estado <= INICIAL;
        end if;
    end case;
  end if;
  end process;
  process (estado)
  begin
    case estado is
      when INICIAL =>
        estado <= "00";
        DTR <= '0';
        enable_recepcao <= '0';
      when LIGADO =>
        estado <= "01";
        DTR <= '1';
      when RECEBENDO =>
        estado <= "10";
        enable_recepcao = '1';
    end case;
  end process;
end estados;
