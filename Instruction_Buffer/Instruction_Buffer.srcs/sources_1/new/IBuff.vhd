----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2020 07:49:18 AM
-- Design Name: 
-- Module Name: IBuff - Behavioral
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

entity IBuff is
  Port (    
            clk, reset, SchedBit  : in std_logic;
            ReadData1             : out std_logic_vector(31 downto 0);
            ReadData2             : out std_logic_vector(31 downto 0);
            writeData1             : in std_logic_vector(31 downto 0);
            writeData2              : in std_logic_vector(31 downto 0)
            
         );
end IBuff;

architecture Behavioral of IBuff is
    type mem_array is array (0 to 7) of std_logic_vector(31 downto 0);    
    signal Buff : mem_array := (
                                    others => (x"0000_0000")
                                );
    
    signal HeadPointerCurrent  : unsigned(2 downto 0);
    signal TailPointerCurrent  : unsigned(2 downto 0);
    signal HeadPointerNext  : unsigned(2 downto 0);
    signal TailPointerNext  : unsigned(2 downto 0);
    
    signal readAdr1  : unsigned(2 downto 0);
    signal readAdr2, writeAdr2  : unsigned(2 downto 0);
begin
  HeadPointer_Syncproc:  process(clk, reset) 
            begin 
                if(reset = '1') then 
                    HeadPointerCurrent <= "000";
                elsif(falling_edge(clk)) then 
                    HeadPointerCurrent <= HeadPointerNext;
                end if;
            end process;
            
   TaiLPointer_Syncproc:   process(clk, reset) 
            begin 
                if(reset = '1') then 
                    TailPointerCurrent <= "110";
                elsif(falling_edge(clk)) then 
                    TailPointerCurrent <= TailPointerNext;
                end if;
            end process;
            
     HeadPointer_Asyncproc: process(SchedBit, HeadPointerCurrent)
        begin 
            IF(SchedBit = '0') then 
                HeadPointerNext <= HeadPointerCurrent + 2;
            else 
                HeadPointerNext <= HeadPointerCurrent + 2;
            end if;
        end process;
        
       TailPointer_Asyncproc : process(SchedBit, TailPointerCurrent)
        begin 
            IF(SchedBit = '0') then 
                TailPointerNext <=  TailPointerCurrent +2;
            else 
                TailPointerNext <= TailPointerCurrent + 1;
            end if;
        end process;
        
        readAdr1 <= TailPointerCurrent;
        readAdr2 <=  TailPointerCurrent + 1;
   
       ReadData1 <= Buff(to_integer(readAdr1));
       ReadData2  <= Buff(to_integer(readAdr2));
       
       writeAdr2 <=  HeadPointerCurrent + 1;
       
       process(clk)
        begin 
            if(falling_edge(clk)) then 
                if(reset /= '1') then
                      Buff(to_integer(writeAdr2)) <= writeData2;
                      Buff(to_integer(HeadPointerCurrent)) <= writeData1;
                end if;
            end if;
        end process;

        
end Behavioral;
