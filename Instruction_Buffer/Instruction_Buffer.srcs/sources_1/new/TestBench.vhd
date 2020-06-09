----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/03/2020 11:06:42 AM
-- Design Name: 
-- Module Name: TestBench - Behavioral
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

entity TestBench is
  Port ( 
            clk, reset : inout std_logic;
            ReadData1             : out std_logic_vector(31 downto 0);
            ReadData2             : out std_logic_vector(31 downto 0)
            
        );
end TestBench;

architecture Behavioral of TestBench is
    component IBuff 
      Port (    
                clk, reset, SchedBit    : in std_logic;
                ReadData1             : out std_logic_vector(31 downto 0);
                ReadData2             : out std_logic_vector(31 downto 0);
                writeData1             : in std_logic_vector(31 downto 0);
                writeData2              : in std_logic_vector(31 downto 0)
                
             );
     end component;
     
     signal   writeData1Sig, writeData2Sig  : std_logic_vector(31 downto 0);
     signal SchedBitSig :  std_logic;
begin
    process
        begin
            clk <= '0';
                wait for 10ns;
            clk <= '1';
                wait for 10ns;
        end process;
       
        process
        begin
            reset <= '1';
                wait for 22ns;
            reset <= '0';
                wait;
        end process;
        
         process
            begin
               wait for 30ns;
               writeData1Sig <= x"A543_0123";
               writeData2Sig <= x"1003_0143";
               wait for 20ns;
               writeData1Sig <= x"1513_0123";
               writeData2Sig <= x"6003_0143";
               wait for 20ns;
               writeData2Sig <= x"2513_0123";
               writeData1Sig <= x"5003_0143";
               wait for 20ns;
               writeData1Sig <= x"3513_0123";
               writeData2Sig <= x"7003_0143";
               wait for 20ns;
               writeData2Sig <= x"2513_4123";
               writeData1Sig <= x"1003_0143";
               wait for 20ns;
                writeData1Sig <= x"3513_0123";
               writeData2Sig <= x"2003_0143";
               wait for 20ns;
            end process;
            
            
            process
                begin 
                    SchedBitSig <= '0';
                    wait for 50ns;
                    SchedBitSig <= '1';
                    wait for 20ns;
                    SchedBitSig <= '0';
                     wait for 20ns;
                    SchedBitSig <= '1';
                end process;
            
            
          IBuffmap:  IBuff Port map(    
                clk         => clk, 
                reset       => reset, 
                SchedBit    => SchedBitSig,
                ReadData1   =>  ReadData1,          
                ReadData2   =>  ReadData2,      
                writeData1  =>  writeData1Sig,   
                writeData2  => writeData2Sig        
                
             );
     

end Behavioral;
