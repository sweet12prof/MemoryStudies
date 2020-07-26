----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.07.2020 20:34:59
-- Design Name: 
-- Module Name: Mem_SubSys_ForTest - Behavioral
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

entity Mem_SubSys_ForTest is
    Port ( 
                    Clk         :   in std_logic;
                    reset       :   in std_logic;
                    
                    ---From CPU Datapath to cache Controller
                    DP_WE               : in std_logic;
                    DP_Mem_Operation    : in std_logic;
                    DP_Address          : in std_logic_vector(14 downto 0);
                    DP_WordData         : in std_logic_vector(31 downto 0);
                    ---From Cache To DP
                    Cache_Ready            : out std_logic;
                    CACHE_BlockData_Out    : out std_logic_vector(127 downto 0)
         );
end Mem_SubSys_ForTest;

architecture Behavioral of Mem_SubSys_ForTest is
    component memoryController is
    generic(
            ReadCycles  : integer ;
            WriteCycles : integer 
        );
      Port ( 
                clk     : in std_logic;
                reset   : in std_logic;
                
                -----From Cache Controller
                Mem_Operation     : in std_logic;
                WE_In             : in std_logic;
               
               ------ From Datapath/Cache
                Adr_In               : in std_logic_vector(12 downto 0);
                
                ------- From Datapath
                BlockData_In         : in std_logic_vector(127 downto 0);
                
                -----To Cache Datapath
                BlockData_Out      : out std_logic_vector(127 downto 0);
               
                -----To Cache Controller
                ready       : out std_logic
                
               
            );
      end component;
      
      component Cache is
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
    end component; 
    
      signal Mem_Operation             :  std_logic; 
      signal WE_In                     :  std_logic; 
      signal CACHE_BlockData_Out_Sig          :  std_logic_vector(127 downto 0);
      signal MEM_BlockData             :  std_logic_vector(127 downto 0);
      signal Mem_ready                 :   std_logic;
    
      
    
begin
    memoryController1 : memoryController 
      generic map (
            ReadCycles  => 4,
            WriteCycles => 4 
      )
      Port MAP( 
                clk                 =>  clk,
                reset               =>  reset,
                
                -----From Cache Controller
                Mem_Operation     =>  Mem_Operation ,
                WE_In             =>  WE_In         ,
               
               ------ From Datapath/Cache
                Adr_In            => DP_Address(14 downto 2), 
                
                ------- From Datapath
                BlockData_In      => CACHE_BlockData_Out_Sig,
                
                -----To Cache Datapath
                BlockData_Out    => MEM_BlockData,
               
                -----To Cache Controller
                ready           =>  Mem_ready 
                
               
            );
      
      
      
      Cache_map : Cache
          Port map( 
                    Clk                     => clk,
                    reset                   => reset,
                    
                    ---From CPU Datapath to cache Controller
                    DP_WE               =>  DP_WE            ,
                    DP_Mem_Operation    =>  DP_Mem_Operation ,
                    DP_Address          =>  DP_Address       ,
                    DP_WordData         =>  DP_WordData      ,
                   
                   ---From Memory to cache Datapath
                    Mem_ready          =>  Mem_ready ,
                    MEM_BlockData      => MEM_BlockData,
                    
                    ---From cache Controller to memory
                    Mem_memOperation   => Mem_Operation ,
                    Mem_WE_In          => WE_In         , 
                    
                    ----From Cache to CPU Datapath
                    Cache_Ready            => Cache_Ready,
                    CACHE_BlockData_Out    => CACHE_BlockData_Out_Sig
                );
    
      CACHE_BlockData_Out <= CACHE_BlockData_Out_Sig;
end Behavioral;
