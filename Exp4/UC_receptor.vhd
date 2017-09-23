library IEEE;
use IEEE.std_logic_1164.all;

entity UC_receptor is
  port(
    LIGA, RESET, CLOCK, CTS         : in  std_logic;
    DTR                             : out std_logic;
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
        if LIGA = '1' and CTS = '1' then
          estado <= RECEBENDO;
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
      when LIGADO =>
        estado <= "01";
        DTR <= '1';
      when RECEBENDO =>
        estado <= "10";
        DTR <= '1';
    end case;
  end process;
end estados;
