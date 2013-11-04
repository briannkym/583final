library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity VGA is
Port(
Clock_24: in std_logic_vector(1 downto 0);
VGA_HS,VGA_VS: out std_logic;
VGA_R, VGA_G, VGA_B: out std_logic_vector(3 downto 0);
Key: in std_logic_vector(3 downto 0);
SW: in std_logic_vector(1 downto 0)
);
end VGA;


Architecture 
