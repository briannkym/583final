library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Sync is
Port(
clk: in std_logic;
R_in, G_in, B_in : in std_logic_vector(3 downto 0);
x, y : out std_logic_vector(11 downto 0);
HSync, VSync: out std_logic;
R, G, B : out std_logic_vector(3 downto 0)
);

end Sync;

Architecture behavioral of Sync is
signal x_pos : unsigned(11 downto 0) := (others => '0');
signal y_pos : unsigned(11 downto 0) := (others => '0');

begin
--Output the correct x and y signals when their values are going to be rendered.
x <= std_logic_vector(x_pos - 160) when (x_pos > 159) else
	(others => '1');
y <= std_logic_vector(y_pos-45) when (y_pos > 44) else
	(others => '1');

	process(clk)
	begin
		--On the rising edge of the clock increment the x and y values.
		if(clk'event and clk='1') then
			if(x_pos < 800) then
				x_pos <= x_pos + 1;
			else
				x_pos <= (others => '0');
				if(y_pos < 525) then
					y_pos <= y_pos + 1;
				else
					y_pos <= (others => '0');
				end if;

			end if;
			
			--for x <160 and y <45 we must follow the vga protocol.
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
			if((x_pos >= 0 and x_pos < 160) or (y_pos >= 0 and y_pos < 45)) then
			
				R <= (others => '0');
				G <= (others => '0');
				B <= (others => '0');
			else --If we are in range, forward the red green and blue values coming in.
				R <= R_in;
				G <= G_in;
				B <= B_in;
			end if;

		end if;

	end process;
end behavioral;