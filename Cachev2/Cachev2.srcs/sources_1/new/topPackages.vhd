----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.07.2020 02:48:44
-- Design Name: 
-- Module Name: topPackages - Behavioral
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

package topPackages is
    component Cache is
      Port     
       ( 
            clk                         : in std_logic;
            reset                       : in std_logic;          
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
    end Component;
    
    component mainMemory is
     Port ( 
                clk           : in std_logic;
                reset         : in std_logic;
                
                Cache_DataAddress               : in std_logic_vector(12 downto 0); -- Address FromCache
                Cache_Write_BlockData           : in std_logic_vector(127 downto 0);      ---WriteData From Cache
                Cache_mainMEm_WE                : in std_logic;     
                Cache_mainMemOperation          : in std_logic;                      
                
                mainMem_Read_BlockData          : out std_logic_vector(127 downto 0); ----To Cache
                   ----From Cache 
                mainMem_ready                   : out std_logic                       ----To Cache
                
            );
    end component;
    
end topPackages;

