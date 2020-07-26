----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.07.2020 17:33:22
-- Design Name: 
-- Module Name: arch_TestBench - Behavioral
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

package arch_TestBench is 
   component mainMemory
      Port ( 
                clk                 : in std_logic;
                WE                  : in std_logic;
                Adr                 : in std_logic_vector(12 downto 0);
                RData               : out std_logic_vector(127 downto 0);
                RDataSingleElement  : out std_logic_vector(31 downto 0);
                WriteBlock       : in std_logic_vector(127 downto 0)
                
            );
    end component;
    
    signal WE          :  std_logic;
    signal Adr         :  std_logic_vector(12 downto 0);
    signal WData       :  std_logic_vector(127 downto 0);

end arch_TestBench;