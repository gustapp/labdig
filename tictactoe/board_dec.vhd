library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--- 0 1 2 | Q W E
--- 3 4 5 | A S D
--- 6 7 8 | Z X C

entity board_dec is
	port(
	 clock                 : in  std_logic;
	 reset                 : in  std_logic;
	 enable					  : in  std_logic;
	 char				        : in  std_logic_vector(6 downto 0); 
	 single_0              : out std_logic; 
	 single_1              : out std_logic; 
	 single_2              : out std_logic; 
	 single_3           	  : out std_logic; 
	 single_4         	  : out std_logic; 
	 single_5         	  : out std_logic; 
	 single_6      	     : out std_logic; 
	 single_7  		        : out std_logic; 
	 single_8	           : out std_logic
  );
end board_dec;

architecture board_decode_arch of board_dec is

-- Define ASCIIg

constant Q : std_logic_vector(6 downto 0) := "1010001";
constant W : std_logic_vector(6 downto 0) := "1010111";
constant E : std_logic_vector(6 downto 0) := "1000101";
constant A : std_logic_vector(6 downto 0) := "1000001";
constant S : std_logic_vector(6 downto 0) := "1010011";
constant D : std_logic_vector(6 downto 0) := "1000100";
constant Z : std_logic_vector(6 downto 0) := "1011010";
constant X : std_logic_vector(6 downto 0) := "1011000";
constant C : std_logic_vector(6 downto 0) := "1000011";

begin
  
  process (clock, reset, enable, char)
  begin

  if reset = '1' then
    single_0 <= '0';
	 single_1 <= '0';
	 single_2 <= '0';
    single_3 <= '0';
	 single_4 <= '0';
	 single_5 <= '0';
	 single_6 <= '0';
	 single_7 <= '0';
	 single_8 <= '0';
  elsif clock'event and clock = '1' then
    case char is
	 
      when Q =>
			single_0 <= '1';
			single_1 <= '0';
			single_2 <= '0';
			single_3 <= '0';
			single_4 <= '0';
			single_5 <= '0';
			single_6 <= '0';
			single_7 <= '0';
			single_8 <= '0';
			
		when W =>
			single_0 <= '0';
			single_1 <= '1';
			single_2 <= '0';
			single_3 <= '0';
			single_4 <= '0';
			single_5 <= '0';
			single_6 <= '0';
			single_7 <= '0';
			single_8 <= '0';
      when E =>
         single_0 <= '0';
			single_1 <= '0';
			single_2 <= '1';
			single_3 <= '0';
			single_4 <= '0';
			single_5 <= '0';
			single_6 <= '0';
			single_7 <= '0';
			single_8 <= '0';
      when A =>
			single_0 <= '0';
			single_1 <= '0';
			single_2 <= '0';
			single_3 <= '1';
			single_4 <= '0';
			single_5 <= '0';
			single_6 <= '0';
			single_7 <= '0';
			single_8 <= '0';
      when S =>
			single_0 <= '0';
			single_1 <= '0';
			single_2 <= '0';
			single_3 <= '0';
			single_4 <= '1';
			single_5 <= '0';
			single_6 <= '0';
			single_7 <= '0';
			single_8 <= '0';
		when D =>
			single_0 <= '0';
			single_1 <= '0';
			single_2 <= '0';
			single_3 <= '0';
			single_4 <= '0';
			single_5 <= '1';
			single_6 <= '0';
			single_7 <= '0';
			single_8 <= '0';
		when Z =>
			single_0 <= '0';
			single_1 <= '0';
			single_2 <= '0';
			single_3 <= '0';
			single_4 <= '0';
			single_5 <= '0';
			single_6 <= '1';
			single_7 <= '0';
			single_8 <= '0';
		when X =>
			single_0 <= '0';
			single_1 <= '0';
			single_2 <= '0';
			single_3 <= '0';
			single_4 <= '0';
			single_5 <= '0';
			single_6 <= '0';
			single_7 <= '1';
			single_8 <= '0';
		when C =>
			single_0 <= '0';
			single_1 <= '0';
			single_2 <= '0';
			single_3 <= '0';
			single_4 <= '0';
			single_5 <= '0';
			single_6 <= '0';
			single_7 <= '0';
			single_8 <= '1';
			
		when others =>
			single_0 <= '0';
			single_1 <= '0';
			single_2 <= '0';
			single_3 <= '0';
			single_4 <= '0';
			single_5 <= '0';
			single_6 <= '0';
			single_7 <= '0';
			single_8 <= '0';
    end case;
  end if;
  end process;
 
end board_decode_arch;