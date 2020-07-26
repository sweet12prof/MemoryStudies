----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.07.2020 20:10:15
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
  Port ( 
            Clk         :   in std_logic;
            reset       :   in std_logic;
            
            ---From CPU Datapath to cache Controller
            DP_WE               : in std_logic;
            DP_Mem_Operation    : in std_logic;
            DP_Address          : in std_logic_vector(14 downto 0);
            DP_WordData         : in std_logic_vector(31 downto 0);
           
           ---From Memory to cache Datapath
            Mem_ready             : in std_logic;
            MEM_BlockData            : in std_logic_vector(127 downto 0);
            
            ---From cache Controller to memory
            Mem_memOperation      : out std_logic;
            Mem_WE_In             : out std_logic; 
            
            ----From Cache to CPU Datapath
            Cache_Ready            : out std_logic;
            CACHE_BlockData_Out    : out std_logic_vector(127 downto 0)
        );
end Cache;

architecture Behavioral of Cache is
    component Cache_Datapath is
          Port ( 
                    clk                        : in std_logic;
                    reset                      : in std_logic;
                    ----From Datapath To Cache
                    DP_Address                    : in std_logic_vector(14 downto 0);
                    DP_WordData                   : in std_logic_vector(31 downto 0);
                    -----From Cache to Datapath
                    CACHE_BlockData_Out           : out std_logic_vector(127 downto 0);
                    
                    ------From MainMemoryToCache    
                    MEM_BlockData            : in std_logic_vector(127 downto 0);
                    
                    ---From Cache_Controller
                    Tag_WE                  : in std_logic;
                    ValidStruc_WE           : in std_logic;
                    DirtyStruc_WE           : in std_logic;
                    DataStruc_WE            : in std_logic;
                    DataStruc_WriteBlock    : in std_logic;
                    
                    ----To Cache Controller
                    Hit                : out std_logic;
                    Dirty              : out std_logic
 
                );
     end component;
     
     
     component CacheController 
      Port ( 
                clk         : in std_logic;
                reset       : in std_logic;
                
                ---From CPU Datapath to cache Controller
                DP_WE            : in std_logic;
                DP_Mem_Operation    : in std_logic;
                ----- From Cache Controller To Cache Datapath
                Tag_WE                  : out std_logic;
                ValidStruc_WE           : out std_logic;
                DirtyStruc_WE           : out std_logic;
                DataStruc_WE            : out std_logic;
                DataStruc_WriteBlock    : out std_logic;
                
                ----From Cache Datapath to Cache Controller
                Hit                     : in std_logic;
                Dirty                   : in std_logic;
                
                ----From Memory To Cache Controller
                Mem_ready                   : in std_logic;
                
                ---From Cache Controller to Memory Controller
                Mem_memOperation     : out std_logic;
                Mem_WE_In             : out std_logic;
                
                ----From Cache Controller to datapath
                Cache_Ready            : out std_logic
            );
    end component;
    
    signal Tag_WE                  :  std_logic; 
    signal ValidStruc_WE           :  std_logic; 
    signal DirtyStruc_WE           :  std_logic; 
    signal DataStruc_WE            :  std_logic; 
    signal DataStruc_WriteBlock    :  std_logic; 
    
    signal Hit                     :  std_logic; 
    signal Dirty                   :  std_logic; 
    
    
    
    

begin
        CacheDP_map : Cache_Datapath Port map ( 
                                                clk                            => clk,
                                                reset                          => reset,
                                                ----From Datapath To C         =
                                                DP_Address                     => DP_Address  ,
                                                DP_WordData                    => DP_WordData ,
                                                -----From Cache to Data        =>
                                                CACHE_BlockData_Out            => CACHE_BlockData_Out,
                                                --                               =>
                                                ------From MainMemoryToCache   =>
                                                MEM_BlockData                  => MEM_BlockData,
                                                --                               =>
                                                ---From Cache_Contro           =>
                                                Tag_WE                         =>   Tag_WE                  ,  
                                                ValidStruc_WE                  =>   ValidStruc_WE           ,
                                                DirtyStruc_WE                  =>   DirtyStruc_WE           ,
                                                DataStruc_WE                   =>   DataStruc_WE            ,
                                                DataStruc_WriteBlock           =>   DataStruc_WriteBlock    ,
                                                                             --  =>
                                                ----To Cache Contro            =>
                                                Hit                            =>    Hit  ,
                                                Dirty                          =>    Dirty
 
                );
     
     Cache_Controller : CacheController Port map ( 
                clk         => clk,
                reset       => reset,
                
                ---From CPU Datapath to cache Controller
                DP_WE               =>     DP_WE           ,
                DP_Mem_Operation    =>     DP_Mem_Operation,
                ----- From Cache Controller To Cache Datapath
                Tag_WE                  => Tag_WE              ,
                ValidStruc_WE           => ValidStruc_WE       ,
                DirtyStruc_WE           => DirtyStruc_WE       ,
                DataStruc_WE            => DataStruc_WE        ,
                DataStruc_WriteBlock    => DataStruc_WriteBlock,
                
                ----From Cache Datapath to Cache Controller
                Hit                     => Hit,
                Dirty                   => Dirty,
                
                ----From Memory To Cache Controller
                Mem_ready               => Mem_ready,
                
                ---From Cache Controller to Memory Controller
                Mem_memOperation     => Mem_memOperation ,
                Mem_WE_In            => Mem_WE_In        ,
                
                ----From Cache Controller to datapath
                Cache_Ready            => Cache_Ready
            );
    

end Behavioral;
