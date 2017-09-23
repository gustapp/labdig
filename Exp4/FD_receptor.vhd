library IEEE;
use IEEE.std_logic_1164.all;

entity FD_receptor is
  port(
    CD, RD, enable_recepcao             : in  std_logic;
    temDadoRecebido, DadoRecebido       : out std_logic
  );
end FD_receptor;

architecture fluxo_dados of FD_receptor is
begin
  temDadoRecebido <= CD;
  DadoRecebido <= enable_recepcao and RD;
end fluxo_dados;
