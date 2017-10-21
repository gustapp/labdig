library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity data_line is
	port(
	 clock                 : in  std_logic;
	 reset                 : in  std_logic;
	 enable					  : in  std_logic; 
	 single_0              : in  std_logic_vector(1 downto 0);
	 single_1              : in  std_logic_vector(1 downto 0);
	 single_2              : in  std_logic_vector(1 downto 0);
	 trans_andamento		  : in  std_logic;
	 transmite_dado		  : out std_logic;
	 fim						  : out std_logic;
	 dado_trans				  : out std_logic_vector(6 downto 0);
  );
end data_line;

architecture data_line_arch of data_line is
type tipo_estado is (INICIAL, DATA_ONE, PIPE_ONE, DATA_TWO, PIPE_TWO, DATA_THREE, FIM);
signal estado : tipo_estado;

-- Define Single

constant vazio  		: std_logic_vector(1 downto 0) := "00";
constant player_one  : std_logic_vector(1 downto 0) := "01";
constant player_two  : std_logic_vector(1 downto 0) := "10";


-- Define ASCII

constant pipe  : std_logic_vector(6 downto 0) := "1111100";
constant BS 	 : std_logic_vector(6 downto 0) := "0001000";
constant CR 	 : std_logic_vector(6 downto 0) := "0001101";
constant O  : std_logic_vector(6 downto 0) := "1001111";
constant X  : std_logic_vector(6 downto 0) := "1011000";

begin
  
  process (clock, reset, enable, trans_andamento)
  begin

  if reset = '1' then
    estado <= INICIAL;
  elsif clock'event and clock = '1' and trans_andamento = '0' then
    case estado is
      when INICIAL =>
        if enable = '1' then
          estado <= DATA_ONE;
        end if;
		when DATA_ONE =>
			if enable = '1' then
          estado <= PIPE_ONE;
        end if;
      when PIPE_ONE =>
        if enable = '1' then
          estado <= DATA_TWO;
        end if;
      when DATA_TWO =>
        if enable = '1' then
          estado <= PIPE_TWO;
        end if;
      when PIPE_TWO =>
        if enable = '1' then
          estado <= DATA_THREE;
        end if;
		when DATA_THREE =>
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
		when DATA_ONE =>
			transmite_dado <= '1';
			case single_0 is
				when vazio =>
					dado_trans <= CR;
				when player_one =>
					dado_trans <= X;
				when player_two =>
					dado_trans <= O;
				when others =>
					dado_trans <= "0100011"; -- # pra debug
      when PIPE_ONE =>
			transmite_dado <= '1';
			dado_trans <= pipe;
      when DATA_TWO =>
			transmite_dado <= '1';
			case single_1 is
				when vazio =>
					dado_trans <= CR;
				when player_one =>
					dado_trans <= X;
				when player_two =>
					dado_trans <= O;
				when others =>
					dado_trans <= "0100011"; -- # pra debug
      when PIPE_TWO =>
			transmite_dado <= '1';
			dado_trans <= pipe;
		when DATA_THREE =>
			transmite_dado <= '1';
			case single_3 is
				when vazio =>
					dado_trans <= CR;
				when player_one =>
					dado_trans <= X;
				when player_two =>
					dado_trans <= O;
				when others =>
					dado_trans <= "0100011"; -- # pra debug
		when FIM =>
			transmite_dado <= '1';
			dado_trans <= BS;
    end case;
  end process;
 
end divisor_line_arch;