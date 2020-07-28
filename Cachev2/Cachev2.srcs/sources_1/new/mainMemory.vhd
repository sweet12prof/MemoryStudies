----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.07.2020 22:34:41
-- Design Name: 
-- Module Name: mainMemory - Behavioral
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

entity mainMemory is
 Port ( 
            clk           : in std_logic;
            reset         : in std_logic;
            
            Cache_DataAddress               : in std_logic_vector(12 downto 0); -- Address FromCache
            Cache_Write_BlockData           : in std_logic_vector(127 downto 0);      ---WriteData From Cache
            Cache_mainMEm_WE                : in std_logic;     
            Cache_mainMemOperation          : in std_logic;                      
            
            mainMem_Read_BlockData          : out std_logic_vector(127 downto 0); ----To Cache
               ----From Cache 
            mainMem_ready                   : out std_logic                       ----To Cache
            
        );
end mainMemory;

architecture Behavioral of mainMemory is
    use work. memPackages.all;
     signal mainMEm_WE_Sig                  :  std_logic;
begin
    
    mainMemoryDP  : mainMemoryDatapath Port map 
           ( 
                clk                         => clk,
            
                mainMEm_WE                  => mainMEm_WE_Sig,
               
                mainMEm_A                   => Cache_DataAddress,
               
                mainMem_Read_BlockData      => mainMem_Read_BlockData,
                mainMem_Write_BlockData     => Cache_Write_BlockData
                
            );
            
     mmController: mainMemory_Controller 
        generic map 
        (   
            readCycles  => 4,
            writeCycles => 4 
         )
        Port map
         ( 
                clk                      => clk,
                reset                    => reset,
                --                         =>
                mainMEm_WE               => mainMEm_WE_Sig,
                mainMem_ready            => mainMem_ready,
                --                         =>
                Cache_mainMemOperation   => Cache_mainMemOperation,
                Cache_mainMemWe          => Cache_mainMEm_WE
              );
   

end Behavioral;
