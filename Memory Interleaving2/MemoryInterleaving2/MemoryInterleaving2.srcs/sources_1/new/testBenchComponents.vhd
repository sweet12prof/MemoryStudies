library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package testBenchComponents is
  Component  Mem 
      Port ( 
                clk             : in std_logic;
                Adr             : in std_logic_vector(7 downto 0);
                Block_Rd        : out std_logic_vector(127 downto 0);
                SingleData_Rd   : out std_logic_vector(31 downto 0);
                writeData       : in std_logic_vector(31 downto 0);
                WE              : in std_logic
            );
   end component;
   signal Adr             :  std_logic_vector(7 downto 0);
   signal writeData       :  std_logic_vector(31 downto 0);
   signal WE              :  std_logic;

end testBenchComponents;

