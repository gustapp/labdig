library ieee;
use ieee.std_logic_1164.all;

entity unidade_controle_recepcao is
	port(liga			 	 	: in  std_logic;
		  reset		    	 	: in  std_logic;
		  CD		       	   : in  std_logic;
		  clock		    	 	: in  std_logic;
		  enable_recepcao    : out std_logic;
		  DTR				      : out std_logic;
		  s_estado				: out std_logic_vector(1 downto 0));	-- depuracao
end unidade_controle_recepcao;

architecture unidade_controle_recepcao_arch of unidade_controle_recepcao is
type tipo_estado is (inicial, ligado, recepcao);
signal estado   : tipo_estado;
   
begin
	process (clock, estado, reset, liga, CD)
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
					if CD = '1' then
						estado <= recepcao;
					end if;
					else
						estado <= inicial;
				end if;

			when recepcao =>
				if CD = '0' then
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
			when recepcao =>
				s_estado <= "10";
				enable_recepcao <= '1';
		end case;
   end process;
end unidade_controle_recepcao_arch;