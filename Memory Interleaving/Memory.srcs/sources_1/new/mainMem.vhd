----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2020 11:00:13 AM
-- Design Name: 
-- Module Name: mainMem - Behavioral
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

entity mainMem is
  Port (
            clk         : in  std_logic;
            A           : in  std_logic_vector(12 downto 0);
            WE          : in  std_logic;
            WriteData   : in  std_logic_vector(127 downto 0);
            ReadData    : out std_logic_vector(127 downto 0)         
         );
end mainMem;

architecture Behavioral of mainMem is


     type mem_array1 is array (0 to 2047) of std_logic_vector(31 downto 0);
     type mem_array2 is array (0 to 2047) of std_logic_vector(31 downto 0);
     type mem_array3 is array (0 to 2047) of std_logic_vector(31 downto 0);
     type mem_array4 is array (0 to 2047) of std_logic_vector(31 downto 0);
     
     signal MEM1 : mem_array1;
     signal MEM2 : mem_array2;
     signal MEM3 : mem_array3;
     signal MEM4 : mem_array4;
     
     signal readData1 : std_logic_vector(31 downto 0);
     signal readData2 : std_logic_vector(31 downto 0);
     signal readData3 : std_logic_vector(31 downto 0);
     signal readData4 : std_logic_vector(31 downto 0);
   
begin
    Read_proc : process(clk)
                    begin 
                        if(clk'event and clk = '1') then 
                            readData1 <= MEM1(to_integer(unsigned(A(12 downto 2))));
                            readData2 <= MEM2(to_integer(unsigned(A(12 downto 2))));
                            readData3 <= MEM3(to_integer(unsigned(A(12 downto 2))));
                            readData4 <= MEM4(to_integer(unsigned(A(12 downto 2))));
                        end if;
                    end process;
    
    
    ReadData <= readData1 & readData2 & readData3 & readData4;
    
    
    Write_MEM1 : process(clk)
                    begin 
                        if( rising_edge(clk)) then 
                            if(WE = '1') THEN 
                                MEM1(to_integer(unsigned(A(12 downto 2)))) <= WriteData(127 downto 96);
                            end if;
                        end if;
                    end process;
    
     Write_MEM2 : process(clk)
                    begin 
                        if( rising_edge(clk)) then 
                            if(WE = '1') THEN 
                                MEM2(to_integer(unsigned(A(12 downto 2)))) <= WriteData(95 downto 64);
                            end if;
                        end if;
                    end process;
      
     
     Write_MEM3 : process(clk)
                    begin 
                        if( rising_edge(clk)) then 
                            if(WE = '1') THEN 
                                MEM3(to_integer(unsigned(A(12 downto 2)))) <= WriteData(63 downto 32);
                            end if;
                        end if;
                    end process;
                    
                    
      Write_MEM4 : process(clk)
                    begin 
                        if( rising_edge(clk)) then 
                            if(WE = '1') THEN 
                                MEM4(to_integer(unsigned(A(12 downto 2)))) <= WriteData(31 downto 0);
                            end if;
                        end if;
                    end process;

end Behavioral;
