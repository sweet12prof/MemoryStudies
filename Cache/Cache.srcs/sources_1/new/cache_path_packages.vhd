----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.07.2020 22:45:00
-- Design Name: 
-- Module Name: cache_path_packages - Behavioral
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

package cache_path_packages is 
    component Struc 
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
    
    
    component Tag_struc is
      Port ( 
                clk : in std_logic;
                WE  : in std_logic;
                A   : in std_logic_vector(6 downto 0);
                RD  : out std_logic_vector(3 downto 0);
                WD  : in std_logic_vector(3 downto 0)
            );
    end component;
    
   component Valid_Struc is
      Port ( 
                clk   : std_logic; 
                reset : std_logic;
                WE    : std_logic;           
                someNum : in std_logic_vector(6 downto 0);
                Q     : out std_logic
            );
    end component;
    

end cache_path_packages;
