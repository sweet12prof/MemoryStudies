----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.07.2020 00:31:12
-- Design Name: 
-- Module Name: cachePackages - Behavioral
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

package cachePackages is

  component cache_TagStruc is
      Port ( 
                clk                 : in std_logic;
                CacheIndex          : in std_logic_vector(6 downto 0);
                
                TagStruc_DataIn     : in std_logic_vector(3 downto 0);  ---Data Input From CPU Datapath                      
                
                TagStruc_WE         : in std_logic;
              
                TagStruc_DataOut   : out std_logic_vector(3 downto 0) --- Data Output
                
            );
    end component;

    component cache_BitStrucs is
      Port ( 
                clk                   : in std_logic;
                reset                 : in std_logic;
                
                BitStrucs_WE          : IN std_logic; 
                BitStrucs_WriteZero   : IN std_logic;
                Index                 : in std_logic_vector(6 downto 0);
                
                Bit_Out               : out std_logic   
            );
    end component;
    
    component cache_DataStruc is
      Port ( 
                clk                 : in std_logic;
                CacheIndex          : in std_logic_vector(8 downto 0);
                
                CPU_DP_Data_In      : in std_logic_vector(31 downto 0);  ---Data Input From CPU Datapath
                Mem_Data_In         : in std_logic_vector(127 downto 0); ---Data Input(Block Data) from Main MEMORY
                
                DataStruc_writeBlock          : in std_logic;
                DataStruc_WE                  : in std_logic;
                
                DataStruc_DataOut             : out std_logic_vector(127 downto 0) --- Data Output
                
            );
    end component;
    
    
    
end cachePackages;

