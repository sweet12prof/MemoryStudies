----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.07.2020 22:31:47
-- Design Name: 
-- Module Name: mainMemPackages - Behavioral
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

package memPackages is 
    component mainMemory_Controller is
     generic (   
            readCycles  : integer ;
            writeCycles : integer 
         );
        Port ( 
                clk             :   in std_logic;
                reset           :   in std_logic;
                
                mainMEm_WE                  : out std_logic;
                mainMem_ready               : out std_logic;
                
                Cache_mainMemOperation           : in std_logic;
                Cache_mainMemWe                  : in std_logic
              );
    end component;
    
    component mainMemoryDatapath is
      Port ( 
                clk                         : in std_logic;           
                
                mainMEm_WE                  : in std_logic;
                
                mainMEm_A                   : in std_logic_vector(12 downto 0);
                
                mainMem_Read_BlockData      : out std_logic_vector(127 downto 0);
                mainMem_Write_BlockData     : in std_logic_vector(127 downto 0)
                
            );
    end component;
    
    signal mainMem_Read_BlockData      :   std_logic_vector(127 downto 0);
    --signal Cache_Write_BlockData     :   std_logic_vector(127 downto 0);   
   
    signal mainMem_ready               :   std_logic;
    
    
end package;