library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity round_crl is
	port(
	 clock                 : in  std_logic;
	 reset                 : in  std_logic;
	 single0					  : in  std_logic_vector(1 downto 0);
	 single1					  : in  std_logic_vector(1 downto 0);
	 single2					  : in  std_logic_vector(1 downto 0);
	 single3					  : in  std_logic_vector(1 downto 0);
	 single4				  	  : in  std_logic_vector(1 downto 0);
	 single5					  : in  std_logic_vector(1 downto 0);
	 single6					  : in  std_logic_vector(1 downto 0);
	 single7					  : in  std_logic_vector(1 downto 0);
	 single8					  : in  std_logic_vector(1 downto 0);
	 player					  : out std_logic
  );
end round_crl;

architecture next_player of round_crl is
signal temp : std_logic_vector(9 downto 0);
begin
    
    -- XOR First level
    temp(0) <= single0(0) XOR single0(1);
    temp(1) <= single1(0) XOR single1(1);
    temp(2) <= single2(0) XOR single2(1);
    temp(3) <= single3(0) XOR single3(1);
    temp(4) <= single4(0) XOR single4(1);
    temp(5) <= single5(0) XOR single5(1);
    temp(6) <= single6(0) XOR single6(1);
    temp(7) <= single7(0) XOR single7(1);
    temp(8) <= single8(0) XOR single8(1);
    
    -- XOR Second level
    temp(9) <= temp(0) XOR temp(1) XOR temp(2) XOR temp(3) XOR temp(4) XOR temp(5) XOR temp(6) XOR temp(7) XOR temp(8);
    
    player <= temp(9);

end next_player;
