----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.07.2020 02:48:04
-- Design Name: 
-- Module Name: Top_For_Test - Behavioral
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

entity Top_For_Test is
  Port ( 
            clk                          : in std_logic;
            reset                        : in std_logic;
            CPU_DP_Data_In                : in std_logic_vector(31 downto 0);  ---Data Input From CPU Datapath
                
            DP_memOperation              : in std_logic;     --- Datapath uses this to inititate a Cache Operation
            DP_WE                        : IN std_logic;     --- Datapath uses this to indicate a Write or Read Operation to Cache
            DP_Address                   : in std_logic_vector(14 downto 0);  --- Address from CPU datapath 
            Cache_DataOut                : out std_logic_vector(127 downto 0); --- Data Output From Cache
            CacheReady                   : out std_logic         
        );
end Top_For_Test;

architecture Behavioral of Top_For_Test is
    use work.topPackages.all;
    signal Mem_Data_In                   :  std_logic_vector(127 downto 0); --  BlockDataInput from memory   
    signal Cache_DataOutSig              :  std_logic_vector(127 downto 0); --- Data Output From Cache 
    signal Cache_mainMemOperation        :  std_logic;   --- Cache uses this to inform main memory for an Operation
    signal Cache_mainMemWe               :  std_logic;    ---Cache uses this to inform main memory for a write or Read       
    signal mainMem_ready                 :  std_logic;    ---- Main memory uses this to inform memory of successful completion of assigned work, active LOW 
    signal Mem_Address                   :  std_logic_vector(14 downto 0); --Memory Address To main memory
begin
    Cache_1: Cache 
      Port map    
       ( 
            clk                        =>  CLK,
            reset                      =>  reset,       
            CPU_DP_Data_In             =>  CPU_DP_Data_In,---Data Input From CPU Datapath
            Mem_Data_In                =>  Mem_Data_In, --  BlockDataInput from memory       
            DP_memOperation            =>  DP_memOperation,   --- Datapath uses this to inititate a Cache Operation
            DP_WE                      =>  DP_WE,   --- Datapath uses this to indicate a Write or Read Operation to Cache
            DP_Address                 =>  DP_Address,--- Address from CPU datapath          
            Mem_Address                =>  Mem_Address,--Memory Address To main memory
            Cache_DataOut              =>  Cache_DataOutSig ,--- Data Output From Cache
            Cache_mainMemOperation     =>  Cache_mainMemOperation,  --- Cache uses this to inform main memory for an Operation
            Cache_mainMemWe            =>  Cache_mainMemWe,   ---Cache uses this to inform main memory for a write or Read       
            mainMem_ready              =>  mainMem_ready,  ---- Main memory uses this to inform memory of successful completion of assigned work, active LOW 
            CacheReady                 => CacheReady
            
       );
    
    mainMemory_1: mainMemory port map
             ( 
                clk                           =>   clk,
                reset                         =>   reset,    
                Cache_DataAddress             =>   Mem_Address(14 downto 2),
                Cache_Write_BlockData         =>   Cache_DataOutSig,
                Cache_mainMEm_WE              =>   Cache_mainMemWe,
                Cache_mainMemOperation        =>   Cache_mainMemOperation,          
                mainMem_Read_BlockData        =>   Mem_Data_In,
                mainMem_ready                 =>   mainMem_ready
                
            );
   
   Cache_DataOut <= Cache_DataOutSig;

end Behavioral;
