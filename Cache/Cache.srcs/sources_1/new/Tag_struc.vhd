----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.07.2020 21:51:44
-- Design Name: 
-- Module Name: Tag_struc - Behavioral
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

entity Tag_struc is
  Port ( 
            clk : in std_logic;
            WE  : in std_logic;
            A   : in std_logic_vector(9 downto 0);
            RD  : out std_logic_vector(17 downto 0);
            WD  : in std_logic_vector(17 downto 0)
        );
end Tag_struc;
   
architecture Behavioral of Tag_struc is
    type mem_array is array (0 to 1023) of std_logic_vector( 17 downto 0 );
    signal MEM : mem_array;
begin
    write_proc : process(clk)
                    begin
                        if(rising_edge(clk)) then 
                            if(WE = '1') then 
                                MEM(to_integer(unsigned(A))) <= WD;
                            end if;
                        end if;
                    end process;
    
    RD <= MEM(to_integer(unsigned(A)));
end Behavioral;
