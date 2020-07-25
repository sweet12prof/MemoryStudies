----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.07.2020 22:44:20
-- Design Name: 
-- Module Name: Cache_Datapath - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Cache_Datapath is
  Port ( 
            clk                        : in std_logic;
            reset                      : in std_logic;
            
            Address                    : in std_logic_vector(31 downto 0);
            
            MEM_BlockData              : in std_logic_vector(127 downto 0);
            CACHE_BlockData            : out std_logic_vector(127 downto 0);
            
            DP_BlockWord_In            : in std_logic_vector(31 downto 0);
            DP_BlockWord_Out           : out std_logic_vector(31 downto 0);
            
            WE                         : in std_logic;
            
            
            
        );
end Cache_Datapath;

architecture Behavioral of Cache_Datapath is
    use work.cache_path_packages.all;
    
begin
    

end Behavioral;
