----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.07.2020 21:49:51
-- Design Name: 
-- Module Name: Valid_Struc - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Valid_Struc is
  Port ( 
            clk   : std_logic; 
            reset : std_logic;
            --D     : in std_logic_vector(1023 downto 0 );
            someNum : in std_logic_vector(10 downto 0);
            Q     : out std_logic_vector(1023 downto 0)
        );
end Valid_Struc;

architecture Behavioral of Valid_Struc is
    signal q_i : std_logic_vector(1023 downto 0);
begin
    q <= q_i;
    
    process(clk, reset)
        begin 
            if(reset = '1') then 
                Q_i <= (others => '0');
            elsif(rising_edge(clk)) then 
                for i in 0 to 1023 loop
                    if(i = to_integer(unsigned(someNum)) ) then 
                        q_i(i) <= '1';
                    else
                        q_i(i) <= q_i(i);
                    end if;
                        
                end loop;
            end if;
        end process;
end Behavioral;
