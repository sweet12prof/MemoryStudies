----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.07.2020 21:21:34
-- Design Name: 
-- Module Name: mainMemory_Controller - Behavioral
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

entity mainMemory_Controller is
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
end mainMemory_Controller;

architecture Behavioral of mainMemory_Controller is
    type state_type is (memIdle, memRead, memReady, memWrite);
    signal PS, NS : state_type;
    
    signal ReadCycleCountCurrent : integer;
    signal ReadCycleCountNext    : integer;
    
    signal writeCycleCountCurrent : integer;
    signal writeCycleCountNext    : integer;
begin
    
    async_proc : process(clk, NS, writeCycleCountNext, ReadCycleCountNext, reset)
                    begin 
                        if(reset = '1') then 
                            PS <= memIdle;
                            writeCycleCountCurrent  <= 0;
                            ReadCycleCountCurrent   <= 0;
                        elsif(rising_edge(clk)) then 
                            PS <= NS;
                            writeCycleCountCurrent  <= writeCycleCountNext;
                            ReadCycleCountCurrent   <= ReadCycleCountNext;
                        end if;
                    end process;
                    
    Sync_proc: process(PS, ReadCycleCountCurrent, writeCycleCountCurrent, Cache_mainMemOperation,Cache_mainMemWe )
                    begin 
                        mainMEm_WE    <= '0';
                        mainMem_ready <= '0';
                        writeCycleCountNext <= writeCycleCountCurrent;
                        ReadCycleCountNext <= ReadCycleCountCurrent ;
                        
                        case PS is 
                            when memIdle => 
                                 writeCycleCountNext <= 0;   
                                 ReadCycleCountNext <=  0;   
                                 if(Cache_mainMemOperation = '1') then 
                                        if(Cache_mainMemWe = '1') then 
                                            NS <= memWrite;
                                        else 
                                            NS <= memRead;
                                        end if;
                                 else 
                                    NS <= memIdle;
                                 end if;
                            
                            when memRead => 
                                 if(ReadCycleCountCurrent = readCycles) then 
                                    NS <= memReady;
                                 else 
                                    ReadCycleCountNext <= ReadCycleCountCurrent + 1;
                                    NS <= memRead;
                                 end if;
                           
                           when memReady =>
                                 mainMem_ready <= '1';
                                 if(Cache_mainMemOperation = '0') then 
                                    NS <= memIdle;
                                 else 
                                    NS <=  memReady;
                                 end if;  
                                 
                          when memWrite =>
                                 if(writeCycleCountCurrent = writeCycles) then
                                    mainMEm_WE    <= '1'; 
                                    NS <= memReady;
                                 else 
                                    writeCycleCountNext <= writeCycleCountCurrent + 1;
                                    NS <= memWrite;
                                 end if; 
                                 
                        end case;
                    end process;

end Behavioral;
