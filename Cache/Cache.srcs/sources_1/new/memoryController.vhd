----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.07.2020 18:59:13
-- Design Name: 
-- Module Name: memoryController - Behavioral
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

entity memoryController is
  generic(
            ReadCycles  : integer := 4;
            WriteCycles : integer := 4
        );
  Port ( 
            clk     : in std_logic;
            reset   : in std_logic;
            
            Mem_Operation  : in std_logic;
            WE_In             : in std_logic;
           
            Adr_In               : in std_logic_vector(10 downto 0);
            
            BlockData_In       : in std_logic_vector(127 downto 0);
            BlockData_Out      : out std_logic_vector(127 downto 0);
           
            
            ready       : out std_logic
            
           
        );
end memoryController;

architecture Behavioral of memoryController is
    type state_type is (Idle, Read, Write,  MEMReady);
    signal PS, NS : state_type;
    
    signal ReadCurrentCount : integer;
    signal ReadNextCount : integer;
    
    signal WriteCurrentCount : integer;
    signal WriteNextCount : integer;
                
    signal WE_MEM                    : std_logic;                       
    signal Adr_MEM                   : std_logic_vector(10 downto 0);   
    signal RData_MEM                 : std_logic_vector(127 downto 0); 
    --signal RDataSingleElement    : std_logic_vector(31 downto 0);  
    signal WriteBlock_MEM            : std_logic_vector(127 downto 0);   
    use work.arch_TestBench.all;
    
    
    
begin

    MAINmEMORY_MAP : mainMemory port map (
                                                clk =>          clk,
                                                WE        =>   WE_MEM,    
                                                Adr       =>    Adr_MEM,   
                                                RData     =>   RData_MEM ,
                                                WriteBlock     =>   BlockData_In,
                                                RDataSingleElement => open
                                             );
    
    sync_proc : process(clk, reset, NS, ReadNextCount, WriteNextCount)
                 begin 
                    if(reset = '1') then 
                        PS <= Idle;
                        ReadCurrentCount <= 0;
                        WriteCurrentCount <= 0;
                    elsif(rising_edge(clk)) then 
                        PS <= NS;
                        ReadCurrentCount <= ReadNextCount;
                        WriteCurrentCount <= WriteNextCount;
                    end if;
                 end process;
                 
     async_proc : process(PS, ReadCurrentCount, WriteCurrentCount, Mem_Operation)
                    begin 
                    
                        ReadNextCount <= ReadCurrentCount;
                        WriteNextCount <= WriteCurrentCount;                        
                        ready             <= '0';
                        WE_MEM           <=  '0';
                        Adr_MEM          <= Adr_In;                                
                        WriteBlock_MEM       <= (OTHERS => '0');
                        BlockData_Out        <= (OTHERS => '0');
                        
                        
                         case PS is
                            when  idle =>
                                ReadNextCount  <= 0;
                                WriteNextCount <= 0;
                                ready             <= '0';
                                WE_MEM           <= '0';
                                Adr_MEM          <= (OTHERS => '0');                                
                                WriteBlock_MEM       <= (OTHERS => '0');
                                
                                 if(Mem_Operation = '0') then 
                                    NS <= idle;
                                 else 
                                    if(WE_In = '0') then 
                                        NS <= read;
                                    else 
                                        NS <= write;
                                    END IF;
                                 end if;
                            
                            when read => 
                                    
                                if(ReadCurrentCount = ReadCycles ) then
                                     NS <= MEMReady;
                                ELSE 
                                     ReadNextCount <= ReadCurrentCount + 1;
                                     NS <= read;
                                end if;
                                
                            when MEMReady => 
                                ready <= '1';
                                BlockData_Out <= RData_MEM;
                                NS <= idle;
                                
                            when write =>
                                
                                if(WriteCurrentCount = WriteCycles ) then
                                    WE_MEM           <= WE_In ;                                  
                                    NS <= MEMReady;                          
                                ELSE 
                                    WriteNextCount <= WriteCurrentCount + 1;
                                     NS <= Write;
                                end if;
                         end case;
                    END PROCESS;

end Behavioral;