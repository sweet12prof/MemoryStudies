----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.07.2020 12:16:03
-- Design Name: 
-- Module Name: mainMemory - Behavioral
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

entity mainMemory is
  Port ( 
            clk                 : in std_logic;
            WE                  : in std_logic;
            Adr                 : in std_logic_vector(10 downto 0);
            RData               : out std_logic_vector(127 downto 0);
            RDataSingleElement  : out std_logic_vector(31 downto 0);
            WriteBlock          : in std_logic_vector(127 downto 0)          
        );
end mainMemory;

architecture Behavioral of mainMemory is
    type mem_array1 is array (0 to 2047) of std_logic_vector(31 downto 0);
    type mem_array2 is array (0 to 2047) of std_logic_vector(31 downto 0);
    type mem_array3 is array (0 to 2047) of std_logic_vector(31 downto 0);
    type mem_array4 is array (0 to 2047) of std_logic_vector(31 downto 0); 
    
    signal MEM1 : mem_array1 := (
                                        x"1e08c049",
                                        x"05e7d183",
                                        x"13efcf7f",
                                        x"372892e8",
                                        x"0800415c",
                                        x"341b9c03",
                                        x"0947b53f",
                                        x"1a0318ec",
                                        x"310c0ec3",
                                        x"273eaf39",
                                        x"18e7f110",
                                        x"114cb7de",
                                        x"2efd35f7",
                                        x"22d06f65",
                                        x"0b25a287",
                                        x"05a14903",
                                        others => (others => '0')
    );
    signal MEM2 : mem_array2 := (
                                    x"1682_3b1a",
                                    x"16653b3f",
                                    x"2cd96d67",
                                    x"28a2540a",
                                    x"311cd0c0",
                                    x"2f02eb2f",
                                    x"0a53d6e2",
                                    x"2c23f9b0",
                                    x"2b7e5aad",
                                    x"0b0de14b",
                                    x"2a7172c4",
                                    x"18bc1407",
                                    x"1f7a9feb",
                                    x"3822ffd2",
                                    x"34a74999",
                                    x"072fba84", 
                                    others => (others => '0')
                                  );
    signal MEM3 : mem_array3 := (
                                    x"0db40404", 
                                    x"10f63c5a", 
                                    x"19414e67", 
                                    x"14ddd0c6", 
                                    x"35acfb71", 
                                    x"15e5a475", 
                                    x"2e4d16b8", 
                                    x"2593f3e1", 
                                    x"01a0ed41", 
                                    x"2475c419", 
                                    x"2e6352d2", 
                                    x"028a6f5d", 
                                    x"39dfde7b", 
                                    x"0b144047", 
                                    x"09fed0df", 
                                    x"247e82a5", 
                                    others => (others => '0')
    );
    signal MEM4 : mem_array4  := (
                                    x"35010d90",
                                    x"2faa350f",
                                    x"0b153321",
                                    x"1aba7208",
                                    x"02854901",
                                    x"07c81789",
                                    x"0f317f1f",
                                    x"0dfffe89",
                                    x"325f3e15",
                                    x"30580264",
                                    x"05c39fd2",
                                    x"31b22c89",
                                    x"0603f96c",
                                    x"08c54607",
                                    x"216a358f",
                                    x"1c01d219",
                                    others => ( others => '0')
                                    
                    
        );   
    
    signal readData1 : std_logic_vector( 31 downto 0);
    signal readData2 : std_logic_vector( 31 downto 0);
    signal readData3 : std_logic_vector( 31 downto 0);
    signal readData4 : std_logic_vector( 31 downto 0);

   
    begin
        
        readProcess1 : process(clk)
                        begin 
                            if(rising_edge(clk)) then 
                                readData1 <= MEM1(TO_INTEGER(unsigned(Adr(10 downto 2))));
                            end if;
                        end process;
                        
        readProcess2 : process(clk)
                        begin 
                            if(rising_edge(clk)) then 
                                readData2 <= MEM2(TO_INTEGER(unsigned(Adr(10 downto 2))));
                            end if;
                        end process;
                        
        readProcess3 : process(clk)
                        begin 
                            if(rising_edge(clk)) then 
                                readData3 <= MEM3(TO_INTEGER(unsigned(Adr(10 downto 2))));
                            end if;
                        end process;
        
        readProcess4 : process(clk)
                        begin 
                            if(rising_edge(clk)) then 
                                readData4 <= MEM4(TO_INTEGER(unsigned(Adr(10 downto 2))));
                            end if;
                        end process;
                        
        RData <= readData1 & readData2 & readData3 & readData4;
              
 
        writeproc1 : process(clk)
                       begin
                            if( rising_edge(clk)) then                              
                                    if( WE = '1') then                                      
                                             MEM1(TO_INTEGER(unsigned(Adr(10 downto 2)))) <= WriteBlock(127 downto 96);                                      
                                    end if;
                                 end if;                        
                       end process; 
                       
        writeproc2 : process(clk)
                       begin
                            if( rising_edge(clk)) then                               
                                        if( WE = '1') then                                            
                                                 MEM2(TO_INTEGER(unsigned(Adr(10 downto 2)))) <= WriteBlock(95 downto 64);                                         
                                        end if;                             
                            end if;
                       end process; 
        
        writeproc3 : process(clk)
                       begin
                            if( rising_edge(clk)) then                            
                                    if( WE = '1') then                                   
                                             MEM3(TO_INTEGER(unsigned(Adr(10 downto 2)))) <= WriteBlock(63 downto 32);                                      
                                    end if;
                             end if;
                       end process; 
        
        writeproc4 : process(clk)
                       begin
                            if( rising_edge(clk)) then                           
                                    if( WE = '1') then                                     
                                             MEM4(TO_INTEGER(unsigned(Adr(10 downto 2)))) <= WriteBlock(31 downto 0);                                       
                                    end if;
                             END IF;
                       end process; 
    
        with (Adr(1 downto 0)) select RDataSingleElement <= 
            readData1 when "00",
            readData2 when "01",
            readData3 when "10",
            readData4 when others;
           
    end Behavioral;
