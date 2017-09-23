library ieee;
use ieee.std_logic_1164.all;

entity unidade_controle_transmissao is
	port(liga			 	 	: in  std_logic;
		  enviar			 	 	: in  std_logic;
		  reset		    	 	: in  std_logic;
		  clock		    	 	: in  std_logic;
		  DTR			       	: out std_logic;
		  RTS		       	 	: out std_logic;
		  enable_transmissao : out std_logic;
		  s_estado				: out std_logic_vector(1 downto 0));	-- depuracao
end unidade_controle_transmissao;

architecture unidade_controle_transmissao_arch of unidade_controle_transmissao is
type tipo_estado is (inicial, ligado, transmissao);
signal estado   : tipo_estado;
   
begin
	process (clock, estado, reset)
	begin
   
	if reset = '1' then
		estado <= inicial;
         
	elsif (clock'event and clock = '1') then
		case estado is
			when inicial =>
				if liga = '1' then
					estado <= ligado;
				end if;

			when ligado =>
				if liga = '1' then
					if enviar = '1' then
						estado <= transmissao;
					end if;
					else
						estado <= inicial;
				end if;

			when transmissao =>
				if enviar = '0' then
					estado <= inicial;
				end if;

		end case;
	end if;
	end process;
   
	process (estado)
	begin
		case estado is
			when inicial =>
				s_estado <= "00";
				DTR <= '1';
			when ligado =>
				s_estado <= "01";
				RTS <= '1';
			when transmissao =>
				s_estado <= "10";
				enable_transmissao <= '1';
		end case;
   end process;
end unidade_controle_transmissao_arch;