----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.07.2020 23:13:05
-- Design Name: 
-- Module Name: cache_Datapath - Behavioral
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

entity cache_Datapath is
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
end cache_Datapath;

architecture Behavioral of cache_Datapath is
    use work.cachePackages.all;
    signal Valid : std_logic;
    signal WB_Address : std_logic_vector(14 downto 0);
    signal Tag : std_logic_vector(3 downto 0);
begin
    
    TagStruc: cache_TagStruc 
      Port map
            ( 
                clk                => clk,
                CacheIndex         => DP_Address(10 downto 4),
                 --                  =>
                TagStruc_DataIn    => DP_Address(14 downto 11),                
                  --                 =>
                TagStruc_WE        => TagStruc_WE,
                --                   =>
                TagStruc_DataOut   => Tag
                
            );
    
   ValidStruc:  cache_BitStrucs port map
           ( 
                clk                   => clk,
                reset                 => reset,
                --                      =>
                BitStrucs_WE          => ValidStruc_WE ,
                BitStrucs_WriteZero   => ValidStruc_WriteZero,
                Index                 => DP_Address(10 downto 4),
                --                      =>
                Bit_Out               =>  Valid
            );
            
   
   DirtyStruc:  cache_BitStrucs port map
           ( 
                clk                   => clk,
                reset                 => reset,
                --                      =>
                BitStrucs_WE          => DirtyStruc_WE,
                BitStrucs_WriteZero   => DirtyStruc_WriteZero ,
                Index                 => DP_Address(10 downto 4),
                --                      =>
                Bit_Out               =>  Cache_BlockDirty
            );
    
    
    DataStruc: cache_DataStruc port map
           ( 
                clk                    =>    clk,
                CacheIndex             =>    DP_Address(10 downto 2),
                                  --     => 
                CPU_DP_Data_In         =>    CPU_DP_Data_In,
                Mem_Data_In            =>    Mem_Data_In,
                                --       => 
                DataStruc_writeBlock   =>     DataStruc_writeBlock,
                DataStruc_WE           =>     DataStruc_WE,
                                 ---      => 
                DataStruc_DataOut      =>     Cache_DataOut
                
            );
      
      Cache_Hit <= '1' when (Tag = DP_Address(14 downto 11) ) else '0'; 
      WB_Address <= Tag & DP_Address(10 downto 0);
        
      with WB_Address_SEL  select Mem_Address <= 
            WB_Address when '1', 
            DP_Address when others;
            

end Behavioral;
