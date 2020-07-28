----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.07.2020 21:49:51
-- Design Name: 
-- Module Name: Valid_Struc - Behavioral
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

entity Struc is
  Port ( 
            clk : in std_logic;
            WE  : in std_logic;
            
            WriteBlock : in std_logic; 
            
            A   : in std_logic_vector(8 downto 0);
            WD_WordData  : in std_logic_vector(31 downto 0 );
            
            WD_BlockData : in std_logic_vector(127 downto 0 );
            RD  : OUT std_logic_vector(127 downto 0)
  
        );
end Struc;

architecture Behavioral of Struc is
   
    type mem_array1 is array (0 to 127) of std_logic_vector(31 downto 0); 
    type mem_array2 is array (0 to 127) of std_logic_vector(31 downto 0);
    type mem_array3 is array (0 to 127) of std_logic_vector(31 downto 0);
    type mem_array4 is array (0 to 127) of std_logic_vector(31 downto 0);
    
    signal MEM1 : mem_array1 := ( others => (others => '0'));
    signal MEM2 : mem_array2 := ( others => (others => '0'));
    signal MEM3 : mem_array3 := ( others => (others => '0'));
    signal MEM4 : mem_array4 := ( others => (others => '0'));
    
    signal readData1 : std_logic_vector(31 downto 0);
    signal readData2 : std_logic_vector(31 downto 0);
    signal readData3 : std_logic_vector(31 downto 0);
    signal readData4 : std_logic_vector(31 downto 0);
    
    signal readData  : std_logic_vector(127 downto 0);
    
    signal MEM1_Wen : std_logic;
    signal MEM2_Wen : std_logic;
    signal MEM3_Wen : std_logic;
    signal MEM4_Wen : std_logic;
    
    signal MEM_Wen : std_logic_vector(3 downto 0);
    

begin
   --- read_proc1 : process(clk)
                ---    begin 
                      -- if(rising_edge(clk)) then 
                           readData1 <= MEM1(TO_INTEGER(unsigned(A(8 downto 2))));
                           readData2 <= MEM2(TO_INTEGER(unsigned(A(8 downto 2))));
                           readData3 <= MEM3(TO_INTEGER(unsigned(A(8 downto 2))));
                            readData4 <= MEM4(TO_INTEGER(unsigned(A(8 downto 2))));
                ---       end if; 
                ---    end process;
                    
--     read_proc2 : process(clk)
--                    begin 
--                        if(rising_edge(clk)) then 
                            
--                        end if;
--                    end process;
                    
--     read_proc3 : process(clk)
--                    begin
--                        if(rising_edge(clk)) then 
                            
--                        end if;
--                    end process;
                    
--      read_proc : process(clk)
--                    begin
--                        if(rising_edge(clk)) then 
                           
--                        end if;
--                    end process;
     
     
      readData  <= readData1 & readData2 & readData3 & readData4;    
      RD <= readData;
      
      
--      -----------------Writing Block Data -------------------------------------------------------------------------------------------------
      write_Block_Word1_proc : process(clk)
                            begin 
                                if(rising_edge(clk)) then 
                                    if(WE = '1') then
                                        if( WriteBlock = '1') then  
                                            MEM1(TO_INTEGER(unsigned(A(8 downto 2)))) <= WD_BlockData(127 downto 96);
                                        else
                                            if(MEM1_Wen = '1') then 
                                                MEM1(TO_INTEGER(unsigned(A(8 downto 2)))) <= WD_WordData;
                                            end if;
                                        end if;
                                    end if;
                                end if;
                            end process;
                            
      write_Block_Word2_proc : process(clk)
                            begin 
                                if(rising_edge(clk)) then 
                                    if(WE = '1') then
                                        if( WriteBlock = '1') then  
                                            MEM2(TO_INTEGER(unsigned(A(8 downto 2)))) <= WD_BlockData(95 downto 64);
                                        else 
                                            if(MEM2_Wen = '1') then 
                                                MEM2(TO_INTEGER(unsigned(A(8 downto 2)))) <= WD_WordData;
                                            end if;
                                        end if;
                                    end if;
                                end if;
                            end process;
                            
                                                      
      write_Block_Word3_proc : process(clk)
                            begin 
                                if(rising_edge(clk)) then 
                                    if(WE = '1') then
                                        if( WriteBlock = '1') then  
                                            MEM3(TO_INTEGER(unsigned(A(8 downto 2)))) <= WD_BlockData(63 downto 32);
                                        else 
                                            if(MEM3_Wen = '1') then 
                                                MEM3(TO_INTEGER(unsigned(A(8 downto 2)))) <= WD_WordData;
                                            end if;
                                        end if;
                                    end if;
                                end if;
                            end process;
                            
                            
        write_Block_Word4_proc : process(clk)
                            begin 
                                if(rising_edge(clk)) then 
                                    if(WE = '1') then
                                        if( WriteBlock = '1') then  
                                            MEM4(TO_INTEGER(unsigned(A(8 downto 2)))) <= WD_BlockData(31 downto 0);
                                        else
                                             if(MEM4_Wen = '1') then 
                                                MEM4(TO_INTEGER(unsigned(A(8 downto 2)))) <= WD_WordData;
                                             end if;
                                        end if;
                                    end if;
                                end if;
                            end process;
                            
--     --------------------------------------------------------------------------------------------------------------------------------------------------------- 
        
                        
      with A(1 downto 0) select MEM_Wen <= 
        "1000" when "00",
        "0100" when "01",
        "0010" when "10",
        "0001" when others;    
        
     MEM1_Wen <=  MEM_Wen(3);
     MEM2_Wen <=  MEM_Wen(2); 
     MEM3_Wen <=  MEM_Wen(1); 
     MEM4_Wen <=  MEM_Wen(0);            
end Behavioral;
