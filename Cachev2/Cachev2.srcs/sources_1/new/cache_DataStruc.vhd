----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.07.2020 23:13:05
-- Design Name: 
-- Module Name: cache_DataStruc - Behavioral
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

entity cache_DataStruc is
  Port ( 
            clk                 : in std_logic;
            CacheIndex          : in std_logic_vector(8 downto 0);
            
            CPU_DP_Data_In      : in std_logic_vector(31 downto 0);  ---Data Input From CPU Datapath
            Mem_Data_In         : in std_logic_vector(127 downto 0); ---Data Input(Block Data) from Main MEMORY
            
            DataStruc_writeBlock          : in std_logic;
            DataStruc_WE                  : in std_logic;
            
            DataStruc_DataOut             : out std_logic_vector(127 downto 0) --- Data Output
            
        );
end cache_DataStruc;

architecture Behavioral of cache_DataStruc is
    type mem_array1 is array (0 to 127) of std_logic_vector(31 downto 0);
    type mem_array2 is array (0 to 127) of std_logic_vector(31 downto 0);
    type mem_array3 is array (0 to 127) of std_logic_vector(31 downto 0);
    type mem_array4 is array (0 to 127) of std_logic_vector(31 downto 0);
    
    signal CACHE_MEM1 : MEM_ARRAY1 := (
--          x"210bc23c",
--          x"0afd22ea",
--          x"30ff571b",
--          x"0bb00865",
--          x"11f745b4",
--          x"01017749",
--          x"073e9bc9",
--          x"1f65ee7c",
--          x"1d0c60a5",
--          x"179d205c",
--          x"0cb7a4f3",
--          x"2cae95b1",
--          x"39e5cf34",
--          x"1e86be44",
--          x"2035b3aa",
--          x"25a6b011",
          others => (others => '0')
    );
    
    signal CACHE_MEM2 : MEM_ARRAY1:= 
    (
--        x"2271810d", 
--        x"09cfaef8", 
--        x"21e86276", 
--        x"1f988404", 
--        x"16037477", 
--        x"186dfdf7", 
--        x"1d3cb14f", 
--        x"3a9c73ef", 
--        x"357faf9f", 
--        x"11e32bfc", 
--        x"195cf837", 
--        x"26ac10b6", 
--        x"2a7d5162", 
--        x"096a505f", 
--        x"22c2d373", 
--        x"24c8767f", 
        others => (others => '0')
    
    );
    signal CACHE_MEM3 : MEM_ARRAY1:= (
--        x"24dbe05d", 
--        x"1f672d65", 
--        x"2ed593a4", 
--        x"07d04da8", 
--        x"00936630", 
--        x"0d19fa6e", 
--        x"24889420", 
--        x"02b51543", 
--        x"1a7d97aa", 
--        x"2b706922", 
--        x"21068f1c", 
--        x"359da907", 
--        x"01c446e4", 
--        x"2d14ffef", 
--        x"22e44753", 
--        x"3906ccdd", 
        others => (others => '0')
    
    );
    signal CACHE_MEM4 : MEM_ARRAY1 := (
--        x"2d73ff3d", 
--        x"1a7a56c1", 
--        x"15d5e822", 
--        x"0e7b3c34", 
--        x"2b7236a6", 
--        x"17620365", 
--        x"23cd2987", 
--        x"3261b214", 
--        x"2bf279b6", 
--        x"3b2ecaa4", 
--        x"0ead0e24", 
--        x"037ba6a9", 
--        x"2afae4ae", 
--        x"2df23a95", 
--        x"39e44496", 
--        x"39533331", 
        others => (others => '0')
    
    );
    
    signal ReadData1    : std_logic_vector(31 downto 0);
    signal ReadData2    : std_logic_vector(31 downto 0);
    signal ReadData3    : std_logic_vector(31 downto 0);
    signal ReadData4    : std_logic_vector(31 downto 0);
    
    signal MEM1_EN    : std_logic ;
    signal MEM2_EN    : std_logic;
    signal MEM3_EN    : std_logic;
    signal MEM4_EN    : std_logic;
    
    SIGNAL mem_en : std_logic_vector(3 downto 0);
    
begin
    mem_proc : process(clk)
                    begin 
                        if(rising_edge(clk)) then 
                            if(DataStruc_WE = '1') then 
                                if(DataStruc_writeBlock = '1') then 
                                    ReadData1 <= Mem_Data_In(127 downto 96);
                                    ReadData2 <= Mem_Data_In(95 downto 64);
                                    ReadData3 <= Mem_Data_In(63 downto 32);
                                    ReadData4 <= Mem_Data_In(31 downto 0);
                                    
                                    CACHE_MEM1(to_integer(unsigned(CacheIndex(8 downto 2)))) <= Mem_Data_In(127 downto 96);
                                    CACHE_MEM2(to_integer(unsigned(CacheIndex(8 downto 2)))) <= Mem_Data_In(95 downto 64);
                                    CACHE_MEM3(to_integer(unsigned(CacheIndex(8 downto 2)))) <= Mem_Data_In(63 downto 32);
                                    CACHE_MEM4(to_integer(unsigned(CacheIndex(8 downto 2)))) <= Mem_Data_In(31 downto 0);
                                 else 
                                    if(MEM1_EN = '1') then                                      
                                        CACHE_MEM1(to_integer(unsigned(CacheIndex(8 downto 2)))) <= CPU_DP_Data_In;
                                    
                                    elsif(MEM2_EN = '1') then                                      
                                        CACHE_MEM2(to_integer(unsigned(CacheIndex(8 downto 2)))) <= CPU_DP_Data_In;
                                    
                                    elsif(MEM3_EN = '1') then                                       
                                        CACHE_MEM3(to_integer(unsigned(CacheIndex(8 downto 2)))) <= CPU_DP_Data_In;
                                    
                                    elsif(MEM4_EN = '1') then                                       
                                        CACHE_MEM4(to_integer(unsigned(CacheIndex(8 downto 2)))) <= CPU_DP_Data_In;
                                    end if; 
                                end if;
                            end if;
                                    ReadData1 <= CACHE_MEM1(to_integer(unsigned(CacheIndex(8 downto 2))));
                                    ReadData2 <= CACHE_MEM2(to_integer(unsigned(CacheIndex(8 downto 2))));
                                    ReadData3 <= CACHE_MEM3(to_integer(unsigned(CacheIndex(8 downto 2))));
                                    ReadData4 <= CACHE_MEM4(to_integer(unsigned(CacheIndex(8 downto 2))));
                        end if;
                    end process;
                    
                    
 DataStruc_DataOut <= ReadData1 & ReadData2 & ReadData3 & ReadData4;
                    
 with CacheIndex(1 downto 0) select 
    mem_en <= "1000" when "00",
              "0100" when "01",
              "0010" when "10", 
              "0001" when others;
 
 MEM1_EN  <= mem_en(3);
 MEM2_EN  <= mem_en(2);
 MEM3_EN  <= mem_en(1);
 MEM4_EN  <= mem_en(0);
        

end Behavioral;
