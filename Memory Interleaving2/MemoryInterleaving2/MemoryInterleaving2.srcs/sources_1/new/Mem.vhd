----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2020 04:40:28 PM
-- Design Name: 
-- Module Name: Mem - Behavioral
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

entity Mem is
  Port ( 
            clk : in std_logic;
            Adr : in std_logic_vector(7 downto 0);
            Block_Rd  : out std_logic_vector(127 downto 0);
            SingleData_Rd   : out std_logic_vector(31 downto 0)
        );
end Mem;

architecture Behavioral of Mem is
    type mem_BANK1 is array (0 to 63) of std_logic_vector(31 downto 0);
    type mem_Bank2 is array (0 to 63) of std_logic_vector(31 downto 0);
    type mem_Bank3 is array (0 to 63) of std_logic_vector(31 downto 0);
    type mem_Bank4 is array (0 to 63) of std_logic_vector(31 downto 0);
    
   signal MEM1  : mem_BANK1 := (
                                     x"0000000c",
                                     x"0000000f",
                                     x"0000000a",
                                     x"00000005",
                                     others => (others => '0')
                                );
   signal MEM2  : mem_BANK2 :=  (
                                         x"00000001",
                                         x"00000003", 
                                         x"00000002", 
                                         x"00000001",
                                         others => (others => '0')
                                 );
                                 
    signal MEM3  : mem_BANK3 := (
                                     x"0000000c",
                                     x"0000000f",
                                     x"0000000a",
                                     x"00000025",
                                     others => (others => '0')
                                );                              
                                 
    signal MEM4  : mem_BANK4 :=  (
                                         x"00000007",
                                         x"00000003", 
                                         x"00000002", 
                                         x"00000001",
                                         others => (others => '0')
                                 );
   
   signal MEM1_Read, MEM2_Read, MEM3_Read, MEM4_Read  :  std_logic_vector(31 downto 0);
   signal  BankSEL : std_logic_vector(1 downto 0);
   signal  ReadSig :  std_logic_vector(31 downto 0);
   
begin
        
                            MEM1_Read <= mem1(to_integer(unsigned(Adr(7 downto 2))));                        
                            MEM2_Read <= mem2(to_integer(unsigned(Adr(7 downto 2))));
                            MEM3_Read <= mem3(to_integer(unsigned(Adr(7 downto 2))));
                            MEM4_Read <= mem4(to_integer(unsigned(Adr(7 downto 2))));
                           
                       
        
        BankSEL <= Adr(1 downto 0);
        
        with BankSEL select SingleData_Rd <= 
                MEM4_Read when "11",
                MEM3_Read when "10",
                MEM2_Read when "01",
                MEM1_Read when others;
                        
        Block_Rd  <= MEM1_Read & MEM2_Read & MEM3_Read & MEM4_Read ;
end Behavioral;
