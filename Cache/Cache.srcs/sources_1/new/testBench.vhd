----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.07.2020 16:18:05
-- Design Name: 
-- Module Name: testBench - Behavioral
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

entity testBench is
  Port ( 
                clk     : inout std_logic;
                RData   : out std_logic_vector(127 downto 0);
                rDataSE : out std_logic_vector(31 downto 0)
        );
end testBench;

architecture Behavioral of testBench is
    use work.arch_TestBench.all;
--    signal cnt_value : std_logic_vector(10 downto 0);
    
begin
    MAINmEMORY_MAP : mainMemory port map (
                                                clk => clk,
                                                WE        =>   WE,    
                                                Adr       =>   Adr,   
                                                RData     =>   RData ,
                                                WriteBlock     =>   WData,
                                                RDataSingleElement => rDataSE
                                             );
                                             
                                             
   process 
     begin
        clk <= '0';
            wait for 5 ns;
        clk <= '1';
            wait for 5ns;
     end process;   
   
   
   process
        begin 
            WE <= '0';
                wait for 20 ns;
            WE <= '1';
                wait for 8 ns;
            We <= '0';
                wait for 15 ns;
            We <= '1';
                wait for 8ns;
            We <= '0';
                wait;
                 
        end process;
   
   process
        begin 
            for  i in 0 to 2047 loop
                    Adr <= std_logic_vector(TO_UNSIGNED(i, Adr'length));
                    wait for 10 ns;
            end loop;
                
        end process;
        
   
   process
    begin 
        for  a in 20 to 2006743448 loop
                     WData  <= std_logic_vector(TO_UNSIGNED(a,  WData'length));
                    wait for 10 ns;
            end loop;
    end process;

end Behavioral;
