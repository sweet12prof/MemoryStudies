----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.07.2020 02:20:00
-- Design Name: 
-- Module Name: cacheTop_packages - Behavioral
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

package cacheTop_packages is
    component cache_Controller is
      Port ( 
                    clk                           : in std_logic;
                    reset                         : in std_logic;                        
                    TagStruc_WE                   : out std_logic;                    --- --- WriteEnable For Tag sTRUC, THIS COMES FROM Cache Controller                           
                    ValidStruc_WE                 : out std_logic;               --- WriteEnable For Bit sTRUC, THIS COMES FROM Cache Controller
                    ValidStruc_WriteZero          : out std_logic;               --- WriteEnable For Bit sTRUC, THIS COMES FROM Cache Controller       
                    DirtyStruc_WE                 : out std_logic;               --- WriteEnable For Dirty sTRUC, THIS COMES FROM Cache Controller
                    DirtyStruc_WriteZero          : out std_logic;               --- WriteEnable For Dirty sTRUC, THIS COMES FROM Cache Controller              
                    DataStruc_writeBlock          : out std_logic;                       --- writeBlock Enable from CC for Data Struc
                    DataStruc_WE                  : out std_logic;                       --- WriteEnable For Data sTRUC, THIS COMES FROM Cache Controller                                
                    Cache_Hit                    : in std_logic;   ---- From Cache Datapath To Cache Controller
                    Cache_BlockDirty             : in std_logic;    ----From Cache Datapath to Cache Controller                                            
                    WB_Address_SEL               : out std_logic;    -- fROM CACHE CONTROLLER USED Select b/n the possible addresses sent to main Memory              
                    DP_memOperation              : in std_logic;     --- Datapath uses this to inititate a Cache Operation
                    DP_WE                        : IN std_logic;     --- Datapath uses this to indicate a Write or Read Operation to Cache
                    Cache_mainMemOperation       : out std_logic;   --- Cache uses this to inform main memory for an Operation
                    Cache_mainMemWe              : out std_logic;    ---Cache uses this to inform main memory for a write or Read       
                    mainMem_ready                : in std_logic;    ---- Main memory uses this to inform memory of successful completion of assigned work, active LOW 
                    CacheReady                   : out std_logic
             );
    end component;

    component cache_Datapath is
      Port ( 
                    clk                           : in std_logic;
                    reset                         : in std_logic;                        
                    TagStruc_WE                   : in std_logic;                    --- --- WriteEnable For Tag sTRUC, THIS COMES FROM Cache Controller
                    DP_Address                    : in std_logic_vector(14 downto 0); -- Adress From Datapath
                    
                    ValidStruc_WE                  : IN std_logic;               --- WriteEnable For Bit sTRUC, THIS COMES FROM Cache Controller
                    ValidStruc_WriteZero           : IN std_logic;               --- WriteEnable For Bit sTRUC, THIS COMES FROM Cache Controller
                    
                    DirtyStruc_WE                  : IN std_logic;               --- WriteEnable For Dirty sTRUC, THIS COMES FROM Cache Controller
                    DirtyStruc_WriteZero           : IN std_logic;               --- WriteEnable For Dirty sTRUC, THIS COMES FROM Cache Controller
                    
                    CPU_DP_Data_In                : in std_logic_vector(31 downto 0);  ---Data Input From CPU Datapath
                    Mem_Data_In                   : in std_logic_vector(127 downto 0); ---Data Input(Block Data) from Main MEMORY
                    
                    DataStruc_writeBlock          : in std_logic;                       --- writeBlock Enable from CC for Data Struc
                    DataStruc_WE                  : in std_logic;                       --- WriteEnable For Data sTRUC, THIS COMES FROM Cache Controller
                    
                    Cache_DataOut             : out std_logic_vector(127 downto 0); --- Data Output From Cache
                    
                    Cache_Hit                    : out std_logic;   ---- From Cache Datapath To Cache Controller
                    Cache_BlockDirty             : out std_logic;    ----From Cache Datapath to Cache Controller            
                    
                    Mem_Address                  : out std_logic_vector(14 downto 0);  --- Address sent to main Memory on misss ; can be Current DP Address or Tag Cocatenation with some part of DP Address
                    WB_Address_SEL               : IN std_logic    -- fROM CACHE CONTROLLER USED Select b/n the possible addresses sent to main Memory                        
      
            );
     end component;

end cacheTop_packages;

