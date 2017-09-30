library IEEE;
use IEEE.std_logic_1164.all;

entity GeradorTick is
  generic(
     M: integer := 50000000     -- modulo do contador
  );
	port (
		clock						: in  std_logic;
		reset						: in  std_logic;
		tick						: out std_logic
	);
end GeradorTick;

architecture arch of GeradorTick is
   signal contagem, prox_contagem: integer;
begin
   -- registrador
   process(clk,reset)
   begin
      if (reset='1') then
         contagem <= 0;
      elsif (clk'event and clk='1') then
         contagem <= prox_contagem;
      end if;
   end process;
   -- logica de proximo estado
   prox_contagem <= 0 when contagem=(M-1) else contagem + 1;
   -- logica de saida
   tick <= '1' when contagem=(M-1) else '0';
end arch;
