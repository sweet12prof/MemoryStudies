----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.07.2020 19:03:50
-- Design Name: 
-- Module Name: CacheController - Behavioral
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

entity CacheController is
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
end CacheController;

architecture Behavioral of CacheController is
    type state_type is (Idle, Compare, Read, Write, Allocate, WriteBack, Extra);
    signal PS, NS : state_type;
begin
    sync_proc : process(clk, reset, NS)
                    begin 
                        if(reset = '1') then 
                            PS <= idle;
                        else 
                            if(rising_edge(clk)) then 
                                PS <= NS;
                            end if;
                        end if;
                    end process;
                    
    async_proc: process(PS, Hit , Dirty, Mem_ready, DP_WE, DP_Mem_Operation)
                    begin 
                        
                        Tag_WE                  <= '0';
                        ValidStruc_WE           <= '0';
                        DirtyStruc_WE           <= '0';
                        DataStruc_WE            <= '0';
                        DataStruc_WriteBlock    <= '0';
                        
                        Mem_memOperation        <= '0';
                        Mem_WE_In               <= '0';
                        Cache_Ready <= '0';                        
                    
                        case Ps is
                            when idle =>
                                Cache_Ready <= '1';
                                if(DP_Mem_Operation = '1') then 
                                    NS <= Compare;
                                else 
                                    NS <= idle;
                                end if;
                            
                            when Compare =>
                                
                                if(Hit = '1' and  DP_WE = '1') then 
                                    NS <= Write;
                                
                                elsif(Hit = '1' and DP_WE = '0') then 
                                    NS <= Read;
                                
                                elsif( Hit = '0' and Dirty = '0') then 
                                    NS <= Allocate;
                                
                                elsif(Hit = '0' and Dirty = '1') then 
                                    NS <= WriteBack;
                                
                                else 
                                    NS <= Compare;
                                
                                end if;
                            
                            when Write => 
                                DataStruc_WE         <= '1';
                                DataStruc_WriteBlock    <= '0';
                                DirtyStruc_WE           <= '1';
                                ValidStruc_WE           <= '1';
                                
                                NS <= idle;
                            
                            when Read =>
                                NS <= idle;
                                
                            
                            when Allocate =>
                                Mem_memOperation <= '1';
                                Mem_WE_In    <= '0';
                                DataStruc_WriteBlock <= '1';
                                DataStruc_WE         <= '1';
                                Tag_WE              <= '1';
                                NS <= Extra;
                                
                            when EXTRA => 
                                Mem_memOperation <= '1';
                                Mem_WE_In    <= '0';
                                DataStruc_WriteBlock <= '1';
                                DataStruc_WE         <= '1';
                               
                                
                                if( Mem_ready = '1') then 
                                     if(DP_WE = '0') then 
                                        NS <= read;
                                     else 
                                        NS <= write;   
                                     end if;
                                else 
                                    NS <= Extra;
                            
                                end if;
                                
                                
                            when WriTEBack =>
                                Mem_memOperation <= '1';
                                Mem_WE_In    <= '1';
                                
                                if(Mem_ready = '1') then 
                                    NS <= Allocate;
                                else 
                                    NS <= WriteBack;    
                                end if;
                                   
                        end case;
                    end process;
    

end Behavioral;
