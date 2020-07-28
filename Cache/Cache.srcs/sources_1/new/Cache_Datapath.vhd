----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.07.2020 22:44:20
-- Design Name: 
-- Module Name: Cache_Datapath - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Cache_Datapath is
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
end Cache_Datapath;

architecture Behavioral of Cache_Datapath is
    use work.cache_path_packages.all;
    
    component Struc is
      Port ( 
                clk : in std_logic;
                WE  : in std_logic;
                
                WriteBlock : in std_logic; 
                
                A   : in std_logic_vector(8 downto 0);
                WD_WordData  : in std_logic_vector(31 downto 0 );
                
                WD_BlockData : in std_logic_vector(127 downto 0 );
                RD  : OUT std_logic_vector(127 downto 0)
      
            );
    end component;
    
    
    
    
    
    signal TagData  : std_logic_vector(3 downto 0);
    signal TagComparator_Out  : std_logic;
    signal Valid_Sig                : std_logic;
    --signal Dirty_Sig                : std_logic;
    signal DataStruc_BlockData      : std_logic_vector(127 downto 0);
begin
    TagStruc_map : Tag_struc Port map ( 
            clk => clk,
            WE  =>  Tag_WE,
            A   => DP_Address(10 downto 4),
            RD  => TagData,
            WD  => DP_Address(14 downto 11)
        );

    TagComparator_Out <= '1' when (TagData = DP_Address(14 downto 11)) else '0';
    
    
    Valid_port_map : Valid_Struc Port map ( 
                clk      =>  clk,
                reset    =>  reset,
                WE       =>   ValidStruc_WE, 
                someNum  =>  DP_Address(10 downto 4), 
                Q        =>  Valid_Sig
            );
    
    Hit <= Valid_Sig and  TagComparator_Out;
    
    Dirty_port_map : Valid_Struc Port map ( 
                clk      =>  clk,
                reset    =>  reset,
                WE       =>  DirtyStruc_WE, 
                someNum  =>  DP_Address(10 downto 4), 
                Q        =>  Dirty
            );
            
            
    D_map : Struc Port map ( 
            clk              => clk,
            WE               => DataStruc_WE,
            WriteBlock       => DataStruc_WriteBlock,
            A                => DP_Address(10 downto 2),
            WD_WordData      => DP_WordData,
            WD_BlockData     => MEM_BlockData,
            RD               => CACHE_BlockData_Out
  
        );

   

end Behavioral;
