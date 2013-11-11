library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity VGA is
Port(
Clock_24: in std_logic_vector(1 downto 0);
VGA_HS, VGA_VS: out std_logic;
VGA_R, VGA_G, VGA_B: out std_logic_vector(3 downto 0);
Key: in std_logic_vector(3 downto 0);
SW: in std_logic_vector(1 downto 0)
);
end VGA;

Architecture structural of VGA is

Component Sync is
Port(
clk: in std_logic;
HSync, VSync: out std_logic;
R, G, B : out std_logic_vector(3 downto 0)
);
End Component Sync;

begin

Sync_Imp: Sync
port map(
clk => Clock_24(0),
HSync => VGA_HS,
VSync => VGA_VS,
R => VGA_R,
G => VGA_G,
B => VGA_B,
);

end structural;
