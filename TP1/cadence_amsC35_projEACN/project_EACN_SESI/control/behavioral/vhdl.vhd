library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control is
    Port ( D  : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           Q  : out STD_LOGIC);
end control;

architecture Behavioral of control is
    signal DATA : STD_LOGIC;
begin

    DATA <= D when (EN = '1') else DATA;
    Q <= DATA;

end Behavioral;