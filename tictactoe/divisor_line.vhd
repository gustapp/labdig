library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity divisor_line is
	port(
	 clock                 : in  std_logic;
	 reset                 : in  std_logic;
	 enable					  : in  std_logic; 
	 trans_andamento		  : in  std_logic;
	 transmite_dado		  : out std_logic;
	 fim						  : out std_logic;
	 dado_trans				  : out std_logic_vector(6 downto 0);
  );
end divisor_line;

architecture divisor_line_arch of divisor_line is
type tipo_estado is (INICIAL, MINUS_ONE, PLUS_ONE, MINUS_TWO, PLUS_TWO, MINUS_THREE, FIM);
signal estado : tipo_estado;
-- Define ASCII

constant minus  : std_logic_vector(6 downto 0) := "1011111";
constant plus   : std_logic_vector(6 downto 0) := "0101011";
constant BS 	 : std_logic_vector(6 downto 0) := "0001000";

begin
  
  process (clock, reset, enable, trans_andamento)
  begin

  if reset = '1' then
    estado <= INICIAL;
  elsif clock'event and clock = '1' and trans_andamento = '0' then
    case estado is
      when INICIAL =>
        if enable = '1' then
          estado <= MINUS_ONE;
        end if;
		when MINUS_ONE =>
			if enable = '1' then
          estado <= PLUS_ONE;
        end if;
      when PLUS_ONE =>
        if enable = '1' then
          estado <= MINUS_TWO;
        end if;
      when MINUS_TWO =>
        if enable = '1' then
          estado <= PLUS_TWO;
        end if;
      when PLUS_TWO =>
        if enable = '1' then
          estado <= MINUS_THREE;
        end if;
		when MINUS_THREE =>
        if enable = '1' then
          estado <= FIM;
        end if;
		when FIM =>
        if enable = '1' then
          estado <= INICIAL;
        end if;
    end case;
  end if;
  end process;

  process (estado)
  begin
    case estado is
      when INICIAL =>
			transmite_dado <= '0';
			dado_trans <= "0000000";
		when MINUS_ONE =>
			transmite_dado <= '1';
			dado_trans <= minus;
      when PLUS_ONE =>
			transmite_dado <= '1';
			dado_trans <= plus;
      when MINUS_TWO =>
			transmite_dado <= '1';
			dado_trans <= minus;
      when PLUS_TWO =>
			transmite_dado <= '1';
			dado_trans <= plus;
		when MINUS_THREE =>
			transmite_dado <= '1';
			dado_trans <= minus;
		when FIM =>
			transmite_dado <= '1';
			dado_trans <= BS;
    end case;
  end process;
 
end divisor_line_arch;