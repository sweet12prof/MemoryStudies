----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.07.2020 23:13:05
-- Design Name: 
-- Module Name: cache_BitStrucs - Behavioral
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

entity cache_BitStrucs is
  Port ( 
            clk                   : in std_logic;
            reset                 : in std_logic;
            
            BitStrucs_WE          : IN std_logic; 
            BitStrucs_WriteZero   : IN std_logic;
            Index                 : in std_logic_vector(6 downto 0);
            
            Bit_Out               : out std_logic   
        );
end cache_BitStrucs;

architecture Behavioral of cache_BitStrucs is
    signal Q : std_logic_vector(127 downto 0);
begin
    process(clk, reset)
        begin 
            if(reset = '1') then 
                Q <= (others => '0');
            
            elsif(rising_edge(clk)) then 
                for i in 0 to 127 loop
                    if( i = to_integer(unsigned(Index)) ) then 
                        if(BitStrucs_WE = '1') then 
                            if( BitStrucs_WriteZero = '1') then 
                                Bit_Out <= '0';
                                Q(i) <= '0';  
                            else 
                                Bit_Out <= '1';
                                Q(i) <= '1';
                            end if;
                        else 
                            Bit_Out <= Q(i);  
                        end if;                 
                    end if;
                end loop;
             end if;
        end process;

end Behavioral;
