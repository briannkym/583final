library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Sync is
Port(
clk: in std_logic;
HSync, VSync: out std_logic;
R, G, B : out std_logic_vector(3 downto 0)
);

end Sync;

Architecture behavioral of Sync is
signal x_pos : integer range 0 to 800:= 0;
signal y_pos : integer range 0 to 525:= 0;

begin
	process(clk)
	begin
		if(clk'event and clk='1') then
			if(x_pos < 800) then
				x_pos <= x_pos + 1;
			else
				x_pos <= 0;
				if(y_pos < 525) then
					y_pos <= y_pos + 1;
				else
					y_pos <= 0;
				end if;

			end if;
			if(x_pos > 15 and x_pos < 112) then
				Hsync <= '0';
			else
				HSync <='1';
			end if;
			if(y_pos > 9 and y_pos < 12) then 
				Vsync <='0';
			else
				Vsync <='1';
			end if;
			if((x_pos > 0 and x_pos < 160) or (y_pos > 0 and y_pos < 45))
				R <= (others => '0');
				G <= (others => '0');
				B <= (others => '0');
			end if;
			if(y_pos >= 0 and y_pos < 45)
			end if;

		end if;

	end process;
end behavioral;
