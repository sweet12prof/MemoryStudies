----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.07.2020 23:13:05
-- Design Name: 
-- Module Name: Cache - Behavioral
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

entity Cache is
  Port     
   ( 
        clk         : in std_logic;
        reset       : in std_logic;
        
        CPU_DP_Data_In                : in std_logic_vector(31 downto 0);  ---Data Input From CPU Datapath
        Mem_Data_In                   : in std_logic_vector(127 downto 0); --  BlockDataInput from memory
        
        DP_memOperation              : in std_logic;     --- Datapath uses this to inititate a Cache Operation
        DP_WE                        : IN std_logic;     --- Datapath uses this to indicate a Write or Read Operation to Cache
        DP_Address                   : in std_logic_vector(14 downto 0);  --- Address from CPU datapath
        
        Mem_Address                   : out std_logic_vector(14 downto 0); --Memory Address To main memory
        Cache_DataOut                 : out std_logic_vector(127 downto 0); --- Data Output From Cache
        Cache_mainMemOperation       : out std_logic;   --- Cache uses this to inform main memory for an Operation
        Cache_mainMemWe              : out std_logic;    ---Cache uses this to inform main memory for a write or Read       
        mainMem_ready                : in std_logic;    ---- Main memory uses this to inform memory of successful completion of assigned work, active LOW 
        CacheReady                   : out std_logic
        
   );
end Cache;

architecture Behavioral of Cache is
    use work.cacheTop_packages.all;
    signal TagStruc_WE                   :  std_logic;                    --- --- WriteEnable For Tag sTRUC, THIS COMES FROM Cache Controller  
    signal ValidStruc_WE                 :  std_logic;               --- WriteEnable For Bit sTRUC, THIS COMES FROM Cache Controller           
    signal ValidStruc_WriteZero          :  std_logic;               --- WriteEnable For Bit sTRUC, THIS COMES FROM Cache Controller           
    signal DirtyStruc_WE                 :  std_logic;               --- WriteEnable For Dirty sTRUC, THIS COMES FROM Cache Controller         
    signal DirtyStruc_WriteZero          :  std_logic;               --- WriteEnable For Dirty sTRUC, THIS COMES FROM Cache Controller         
    signal DataStruc_writeBlock          :  std_logic;                       --- writeBlock Enable from CC for Data Struc                      
    signal DataStruc_WE                  :  std_logic;                       --- WriteEnable For Data sTRUC, THIS COMES FROM Cache Controller     
    signal Cache_Hit                     :  std_logic;   ---- From Cache Datapath To Cache Controller
    signal Cache_BlockDirty              :  std_logic;    ----From Cache Datapath to Cache Controller                
    signal WB_Address_SEL                :  std_logic;    -- fROM CACHE CONTROLLER USED Select b/n the possible addresses sent to main Memory 
    
    
begin

    CacheController : cache_Controller port map
           ( 
                    clk                       =>   clk, 
                    reset                     =>   reset,                     
                    TagStruc_WE               =>   TagStruc_WE,                  --- --- WriteEnable For Tag sTRUC, THIS COMES FROM Cache Controller                           
                    ValidStruc_WE             =>   ValidStruc_WE,             --- WriteEnable For Bit sTRUC, THIS COMES FROM Cache Controller
                    ValidStruc_WriteZero      =>   ValidStruc_WriteZero,             --- WriteEnable For Bit sTRUC, THIS COMES FROM Cache Controller       
                    DirtyStruc_WE             =>   DirtyStruc_WE,             --- WriteEnable For Dirty sTRUC, THIS COMES FROM Cache Controller
                    DirtyStruc_WriteZero      =>   DirtyStruc_WriteZero,             --- WriteEnable For Dirty sTRUC, THIS COMES FROM Cache Controller              
                    DataStruc_writeBlock      =>   DataStruc_writeBlock,                     --- writeBlock Enable from CC for Data Struc
                    DataStruc_WE              =>   DataStruc_WE,                     --- WriteEnable For Data sTRUC, THIS COMES FROM Cache Controller                                
                    Cache_Hit                 =>   Cache_Hit,---- From Cache Datapath To Cache Controller
                    Cache_BlockDirty          =>   Cache_BlockDirty,----From Cache Datapath to Cache Controller                                            
                    WB_Address_SEL            =>   WB_Address_SEL, -- fROM CACHE CONTROLLER USED Select b/n the possible addresses sent to main Memory              
                    DP_memOperation           =>   DP_memOperation, --- Datapath uses this to inititate a Cache Operation
                    DP_WE                     =>   DP_WE, --- Datapath uses this to indicate a Write or Read Operation to Cache
                    Cache_mainMemOperation    =>   Cache_mainMemOperation, --- Cache uses this to inform main memory for an Operation
                    Cache_mainMemWe           =>   Cache_mainMemWe, ---Cache uses this to inform main memory for a write or Read       
                    mainMem_ready             =>   mainMem_ready,---- Main memory uses this to inform memory of successful completion of assigned work, active LOW 
                    CacheReady                =>   CacheReady
             );
             
             
     
     CacheDatapath: cache_Datapath port map
         ( 
                    clk                   =>   clk,  
                    reset                 =>   reset,                          
                    TagStruc_WE           =>   TagStruc_WE,                      --- --- WriteEnable For Tag sTRUC, THIS COMES FROM Cache Controller
                    DP_Address            =>   DP_Address,   -- Adress From Datapath   
                    ValidStruc_WE         =>   ValidStruc_WE,                 --- WriteEnable For Bit sTRUC, THIS COMES FROM Cache Controller
                    ValidStruc_WriteZero  =>   ValidStruc_WriteZero,                 --- WriteEnable For Bit sTRUC, THIS COMES FROM Cache Controller
                    DirtyStruc_WE         =>   DirtyStruc_WE,                 --- WriteEnable For Dirty sTRUC, THIS COMES FROM Cache Controller
                    DirtyStruc_WriteZero  =>   DirtyStruc_WriteZero,                 --- WriteEnable For Dirty sTRUC, THIS COMES FROM Cache Controller
                    CPU_DP_Data_In        =>   CPU_DP_Data_In,    ---Data Input From CPU Datapath
                    Mem_Data_In           =>   Mem_Data_In,   ---Data Input(Block Data) from Main MEMORY
                    DataStruc_writeBlock  =>   DataStruc_writeBlock,                         --- writeBlock Enable from CC for Data Struc
                    DataStruc_WE          =>   DataStruc_WE,                         --- WriteEnable For Data sTRUC, THIS COMES FROM Cache Controller
                    Cache_DataOut         =>   Cache_DataOut,   --- Data Output From Cache
                    Cache_Hit             =>   Cache_Hit,     ---- From Cache Datapath To Cache Controller
                    Cache_BlockDirty      =>   Cache_BlockDirty,      ----From Cache Datapath to Cache Controller  
                    Mem_Address           =>   Mem_Address,    --- Address sent to main Memory on misss ; can be Current DP Address or Tag Cocatenation with some part of DP Address
                    WB_Address_SEL        =>   WB_Address_SEL    -- fROM CACHE CONTROLLER USED Select b/n the possible addresses sent to main Memory                        
      
            );
   
    
end Behavioral;
