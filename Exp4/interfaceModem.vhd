library IEEE;
use IEEE.std_logic_1164.all;

entity InterfaceModem is
  port (
    CLOCK, RESET, Liga, Enviar DadoSerial, CTS, CD, RD    :   in  std_logic;
    envioOK, temDadoRecebido, DadoRecebido, DTR, RTS, TD  :   out std_logic
  );
end InterfaceModem;

architecture hierarquica of InterfaceModem is

begin

end hierarquica;
