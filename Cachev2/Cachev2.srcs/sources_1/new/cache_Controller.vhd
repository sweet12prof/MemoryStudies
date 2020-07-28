----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.07.2020 23:13:05
-- Design Name: 
-- Module Name: cache_Controller - Behavioral
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

entity cache_Controller is
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
end cache_Controller;

architecture Behavioral of cache_Controller is
    type state_type is (CacheIdle, CacheCompare, CacheWrite,  CacheRead, CacheWriteBack, CacheAllocate );
    signal PS, NS : state_type;
begin
    
    sync_proc : process(clk, reset, PS)
                    begin
                        if(reset = '1') then 
                            PS <= CacheIdle;
                        elsif(rising_edge(clk)) then 
                            PS <= NS;
                        end if;
                    end process;
                    
    async_proc : process(PS, DP_memOperation, DP_WE, mainMem_ready, Cache_BlockDirty, Cache_Hit)
                    begin 
                        TagStruc_WE                   <= '0';
                        ValidStruc_WE                 <= '0';
                        ValidStruc_WriteZero          <= '0';
                        DirtyStruc_WE                 <= '0';
                        DirtyStruc_WriteZero          <= '0';
                        DataStruc_writeBlock          <= '0';
                        DataStruc_WE                  <= '0';
                        WB_Address_SEL                <= '0';
                        Cache_mainMemOperation        <= '0';
                        Cache_mainMemWe               <= '0';  
                        CacheReady                    <= '0';      
                        
                        case PS is 
                            when CacheIdle => 
                                
                                if(DP_memOperation = '1') then 
                                    NS <= CacheCompare;
                                else 
                                    NS <= CacheIdle;
                                end if;
                                
                            when CacheCompare =>
                                if(Cache_Hit = '1' and DP_WE = '1') then 
                                    NS <= CacheWrite;
                                elsif(Cache_Hit = '1' and DP_WE = '0') then 
                                    NS <= CacheRead;
                                elsif(Cache_Hit = '0' and Cache_BlockDirty = '0') then 
                                    NS <= CacheAllocate;
                                elsif(Cache_Hit = '0' and Cache_BlockDirty = '1') then 
                                    NS <= CacheWriteBack;
                                else 
                                    NS <= CacheCompare;
                                end if;
                                
                            when CacheRead =>                                 
                                    CacheReady  <= '1';                               
                                    NS <=  CacheIdle;
                            
                           
                            when CacheWrite =>
                                ValidStruc_WE                 <= '1';
                                ValidStruc_WriteZero          <= '0';
                                DirtyStruc_WE                 <= '1';
                                DirtyStruc_WriteZero          <= '0';
                                DataStruc_writeBlock          <= '0';
                                DataStruc_WE                  <= '1';
                                CacheReady    <= '1';
                                NS <= CacheIdle;
                                
                           when CacheWriteBack => 
                                WB_Address_SEL                <= '1';
                                Cache_mainMemOperation        <= '1';
                                Cache_mainMemWe               <= '1';
                                DirtyStruc_WE                 <= '1';
                                DirtyStruc_WriteZero          <= '1';
                                ValidStruc_WE                 <= '1';
                                ValidStruc_WriteZero          <= '0';
                                if(mainMem_ready = '0') then 
                                    NS <= CacheWriteBack;
                                else 
                                    Cache_mainMemOperation        <= '0';
                                    NS <= CacheAllocate;
                                end if;
                                
                            when CacheAllocate => 
                                Cache_mainMemOperation        <= '1';
                                Cache_mainMemWe               <= '0';
                                TagStruc_WE                   <= '1';
                                ValidStruc_WE                 <= '1';
                                ValidStruc_WriteZero          <= '0';
                                DirtyStruc_WE                 <= '1';
                                DirtyStruc_WriteZero          <= '1';
                                DataStruc_writeBlock          <= '1';
                                DataStruc_WE                  <= '1';                               
                                if(mainMem_ready = '0') then 
                                    NS <= CacheAllocate;
                                else 
                                Cache_mainMemOperation        <= '0';
                                    if(DP_WE = '1') then 
                                        NS <= CacheWrite;
                                     else 
                                        NS <= CacheRead;
                                    end if;
                                end if;
                                
                        end case;
                    end process;
    
end Behavioral;
