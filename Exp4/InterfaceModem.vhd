library IEEE;
use IEEE.std_logic_1164.all;

entity InterfaceModem is
  port (CLOCK, RESET, LIGA, DadoSerial, CD, RD, CTS   : in  std_logic;
        Enviar                                        : in  std_logic;
        DTR, RTS, TD, temDadoRecebido, DadoRecebido   : out std_logic;
        envioOK                                       : out std_logic;
        estado_transmissao, estado_recepcao           : out std_logic_vector(1 downto 0));
end InterfaceModem;

architecture hierarquico of InterfaceModem is


  component transmissor is
  	port(liga			 	   : in  std_logic;
  		  enviar			 	 : in  std_logic;
  		  reset		    	 : in  std_logic;
  		  clock		    	 : in  std_logic;
  		  dado_serial    : in  std_logic;
        CTS            : in  std_logic;
  		  envioOk	    	 : out std_logic;
  		  DTR			       : out std_logic;
  		  RTS		       	 : out std_logic;
  		  TD		       	 : out std_logic;
  		  d_estado			 : out std_logic_vector(1 downto 0));
  end component;

  component receptor is
    port (
      CLOCK, RESET, LIGA, CD, RD               :   in  std_logic;
      DTR, temDadoRecebido, DadoRecebido       :   out std_logic;
      dep_estado                               :   out std_logic_vector(1 downto 0)
    );
  end component;

signal s_dtr_1, s_dtr_2 : std_logic;

begin

  R: transmissor  port map(LIGA, Enviar, RESET, CLOCK, DadoSerial, CTS, envioOK, s_dtr_1, RTS, TD, estado_transmissao);
  T: receptor     port map(CLOCK, RESET, LIGA, CD, RD, s_dtr_2, temDadoRecebido, DadoRecebido, estado_recepcao);

DTR <= s_dtr_1 or s_dtr_2;

end hierarquico;
