----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.07.2020 21:22:11
-- Design Name: 
-- Module Name: mainMemoryDatapath - Behavioral
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

entity mainMemoryDatapath is
  Port ( 
            clk                         : in std_logic;           
            
            mainMEm_WE                  : in std_logic;
            
            mainMEm_A                   : in std_logic_vector(12 downto 0);
            
            mainMem_Read_BlockData      : out std_logic_vector(127 downto 0);
            mainMem_Write_BlockData     : in std_logic_vector(127 downto 0)
            
        );
end mainMemoryDatapath;

architecture Behavioral of mainMemoryDatapath is
    type mem_array1 is array (0 to 2047) of std_logic_vector(31 downto 0);
    type mem_array2 is array (0 to 2047) of std_logic_vector(31 downto 0);
    type mem_array3 is array (0 to 2047) of std_logic_vector(31 downto 0);
    type mem_array4 is array (0 to 2047) of std_logic_vector(31 downto 0);
    
    signal mainMEM1 : mem_array1 := (
          x"210bc23c",
          x"0afd22ea",
          x"30ff571b",
          x"0bb00865",
          x"11f745b4",
          x"01017749",
          x"073e9bc9",
          x"1f65ee7c",
          x"1d0c60a5",
          x"179d205c",
          x"0cb7a4f3",
          x"2cae95b1",
          x"39e5cf34",
          x"1e86be44",
          x"2035b3aa",
          x"25a6b011",
          others => (others => '0')
    );
    signal mainMEM2 : mem_array2 := 
    (
        x"2271810d", 
        x"09cfaef8", 
        x"21e86276", 
        x"1f988404", 
        x"16037477", 
        x"186dfdf7", 
        x"1d3cb14f", 
        x"3a9c73ef", 
        x"357faf9f", 
        x"11e32bfc", 
        x"195cf837", 
        x"26ac10b6", 
        x"2a7d5162", 
        x"096a505f", 
        x"22c2d373", 
        x"24c8767f", 
        others => (others => '0')
    
    );
    signal mainMEM3 : mem_array3 := (
        x"24dbe05d", 
        x"1f672d65", 
        x"2ed593a4", 
        x"07d04da8", 
        x"00936630", 
        x"0d19fa6e", 
        x"24889420", 
        x"02b51543", 
        x"1a7d97aa", 
        x"2b706922", 
        x"21068f1c", 
        x"359da907", 
        x"01c446e4", 
        x"2d14ffef", 
        x"22e44753", 
        x"3906ccdd", 
        others => (others => '0')
    
    );
    signal mainMEM4 : mem_array4 := (
        x"2d73ff3d", 
        x"1a7a56c1", 
        x"15d5e822", 
        x"0e7b3c34", 
        x"2b7236a6", 
        x"17620365", 
        x"23cd2987", 
        x"3261b214", 
        x"2bf279b6", 
        x"3b2ecaa4", 
        x"0ead0e24", 
        x"037ba6a9", 
        x"2afae4ae", 
        x"2df23a95", 
        x"39e44496", 
        x"39533331", 
        others => (others => '0')
    
    );
    
    signal readData1 : std_logic_vector(31 downto 0);
    signal readData2 : std_logic_vector(31 downto 0);
    signal readData3 : std_logic_vector(31 downto 0);
    signal readData4 : std_logic_vector(31 downto 0);
    
    signal SinglReadData : std_logic_vector(31 downto 0);
begin
    
    readProc : process(clk)
                    begin 
                        if(rising_edge(clk)) then 
                            if(mainMEm_WE = '1') then 
                                readData1 <=  mainMem_Write_BlockData(127 downto 96);
                                readData2 <=  mainMem_Write_BlockData(95 downto 64);
                                readData3 <=  mainMem_Write_BlockData(63 downto 32);
                                readData4 <=  mainMem_Write_BlockData(31 downto 0);
                                
                                mainMEM1(to_integer(unsigned(mainMEm_A(12 downto 2)))) <= mainMem_Write_BlockData(127 downto 96);
                                mainMEM2(to_integer(unsigned(mainMEm_A(12 downto 2)))) <= mainMem_Write_BlockData(95 downto 64);
                                mainMEM3(to_integer(unsigned(mainMEm_A(12 downto 2)))) <= mainMem_Write_BlockData(63 downto 32);
                                mainMEM4(to_integer(unsigned(mainMEm_A(12 downto 2)))) <= mainMem_Write_BlockData(31 downto 0);
                                
                            else 
                                readData1 <=  mainMEM1(to_integer(unsigned(mainMEm_A(12 downto 2))));
                                readData2 <=  mainMEM2(to_integer(unsigned(mainMEm_A(12 downto 2))));
                                readData3 <=  mainMEM3(to_integer(unsigned(mainMEm_A(12 downto 2))));
                                readData4 <=  mainMEM4(to_integer(unsigned(mainMEm_A(12 downto 2))));
                            end if;
                        end if;
                    end process;
                    
                    mainMem_Read_BlockData  <= readData1 & readData2 & readData3 & readData4;
                    
                    with mainMEm_A(1 downto 0) select
                        SinglReadData <= readData1 when "00",
                                         readData2 when "01",
                                         readData3 when "10",
                                         readData4 when others; 

end Behavioral;
