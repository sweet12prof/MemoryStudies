----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.07.2020 23:13:05
-- Design Name: 
-- Module Name: cache_TagStruc - Behavioral
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

entity cache_TagStruc is
  Port ( 
            clk                 : in std_logic;
            CacheIndex          : in std_logic_vector(6 downto 0);
            
            TagStruc_DataIn     : in std_logic_vector(3 downto 0);  ---Data Input From CPU Datapath                      
            
            TagStruc_WE         : in std_logic;
          
            TagStruc_DataOut   : out std_logic_vector(3 downto 0) --- Data Output
            
        );
end cache_TagStruc;

architecture Behavioral of cache_TagStruc is
 type mem_araay is array (0 to 127) of std_logic_vector(3 downto 0);
 signal tag_MEM : mem_araay;
begin
    mem_proc : process(clk)
                    begin   
                        if(rising_edge(clk)) then 
                            if(TagStruc_WE = '1') then
                                tag_MEM(to_integer(unsigned(CacheIndex))) <= TagStruc_DataIn;
                            end if; 
                        end if;
                    end process;
                    
    TagStruc_DataOut <= tag_MEM(to_integer(unsigned(CacheIndex)));

end Behavioral;
