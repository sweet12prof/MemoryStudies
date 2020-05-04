----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/04/2020 09:33:25 PM
-- Design Name: 
-- Module Name: Memory_Interleavin - Behavioral
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

entity Memory_Interleavin is
  Port ( 
            clk : in std_logic;
            we  : in std_logic;
            Adr      : in std_logic_vector(6 downto 0);
            writedata     : in std_logic_vector(31 downto 0);
            
            ReadData      : out  std_logic_vector(31 downto 0)
            
        );
end Memory_Interleavin;

architecture Behavioral of Memory_Interleavin is
    type mem_array is array (0 to 31) of std_logic_vector(127 downto 0);
    signal MEM : mem_array  := (
    
                x"0000000c_0000000f_0000000a_00000005",

                x"00000007_00000003_00000002_00000001",
                others => (others => '0')
    );
    
    signal ReadDataSig      :   std_logic_vector(127 downto 0);
    signal writeDataSig      :   std_logic_vector(127 downto 0);
    signal writeDataSig1      :   std_logic_vector(127 downto 0);
    signal writeDataSig2      :   std_logic_vector(127 downto 0);
    signal writeDataSig3      :   std_logic_vector(127 downto 0);
    signal writeDataSig4      :   std_logic_vector(127 downto 0);
begin
    
  
                        ReadDataSig <= MEM(to_integer(unsigned(ADr(6 downto 2))));
                        
                        with Adr(1 downto 0) select ReadData <= 
                          ReadDataSig(127 downto 96) when "00",
                          ReadDataSig(95 downto 64) when "01",
                          ReadDataSig(63 downto 32) when "10",
                          ReadDataSig(31 downto 0) when "11",
                          x"0000_0000" when others;
                          
                          Write_Mem_proc : process(clk)
                                            begin
                                                if(rising_edge(clk)) then 
                                                    if(we = '1') then 
                                                        MEM(to_integer(unsigned(ADr(6 downto 2)))) <= writeDataSig;
                                                    end if;
                                                end if;
                                            end process;  
                          
                          writeDataSig1  <= ReadDataSig(127 downto 32) & writeData;
                          writeDataSig2  <= ReadDataSig(127 downto 64) & writeData & ReadDataSig(31 downto 0);
                          writeDataSig3  <= ReadDataSig(127 downto 96) & writeData & ReadDataSig(63 downto 0);
                          writeDataSig4  <= writeData & ReadDataSig(95 downto 0);
                          
                          
                          with Adr(1 downto 0) select writeDataSig <= 
                                writeDataSig1 when "11",
                                writeDataSig2 when "10",
                                writeDataSig3 when "01",
                                writeDataSig4 when "00",
                                x"00000000_00000000_00000000_00000000" when others;
                        
                        
                        --W1_RD  <= MEM(to_integer(unsigned(W1_A)));
                    
end Behavioral;
