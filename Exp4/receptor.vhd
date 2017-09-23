library IEEE;
use IEEE.std_logic_1164.all;

entity receptor is
  port (
    CLOCK, RESET, LIGA, CD, RD               :   in  std_logic;
    DTR, temDadoRecebido, DadoRecebido       :   out std_logic;
    dep_estado                               :   out std_logic_vector(1 downto 0)
  );
end receptor;

architecture hierarquica of receptor is

  component UC_receptor is
    port(
      CLOCK, RESET, LIGA , CD         : in  std_logic;
      DTR, enable_recepcao            : out std_logic;
      dep_estado                      : out std_logic_vector(1 downto 0)
    );
  end component;

  component FD_receptor is
    port(
      CD, RD, enable_recepcao             : in  std_logic;
      temDadoRecebido, DadoRecebido       : out std_logic
    );
  end component;

signal s_en_recep : std_logic;

begin

  UC: UC_receptor   port map(CLOCK, RESET, LIGA, CD, DTR, s_en_recep, dep_estado);
  FD: FD_receptor   port map(CD, RD, s_en_recep, temDadoRecebido, DadoRecebido);

end hierarquica;
