----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:08:02 07/30/2020 
-- Design Name: 
-- Module Name:    ps2Controller - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ps2Controller is
	port (
				clk		: in std_logic;
				reset		: in std_logic;
				
				
				clk_in1	: in std_logic;
				
				data_in	: in std_logic;
				
				LED		: out std_logic;
				LED2		: out std_logic		
				
				
			);
end ps2Controller;

architecture Behavioral of ps2Controller is
	type state_type is (Idle, ReadMakeStream, ReadBreak1, ReadBreak2 );
	signal PS, NS : state_type;
	
	signal StremCountNext, streamCountCurrent : integer;
	
	--signal clk_Out	:  std_logic;
	--signal data_Out :  std_logic;
	signal data_Stream : std_logic_vector(7 downto 0) ;
	signal data_Stream2 : std_logic_vector(7 downto 0) ;
	signal data_Stream3 : std_logic_vector(7 downto 0) ;
	signal clk_in	:  std_logic;
begin
	clk_in <= clk_in1;
	sync_proc : process(clk, reset, NS)
						begin 
							if(reset = '1') then 
								PS <= Idle;
								data_Stream 	<= (others => '0');
								data_Stream2 	<= (others => '0');
								data_Stream3	<= (others => '0');
								streamCountCurrent <= 0;
							elsif(rising_edge(clk)) then  
								PS <= NS;
								streamCountCurrent <= StremCountNext;
							end if;
						end process;
						
	async_proc	: process(PS, clk_in, data_in, streamCountCurrent)
						begin 
							StremCountNext <= streamCountCurrent + 1;					
							LED <= '0';
							data_Stream <= data_stream;
							data_Stream2 <= data_stream2;
							data_Stream3 <= data_stream3;
						case PS is
						
							when Idle =>							
								stremCountNext <= 0;
								data_Stream <= (others => '0');
								data_Stream2 <= (others => '0');
								data_Stream3 <= (others => '0');
							if(clk_in = '0') then 
								NS <= ReadMakeStream;
							else 
								NS <= Idle;
							end if;
							
							when ReadMakeStream =>
							
								if(streamCountCurrent < 9 or streamCountCurrent >= 0) then 
										
											data_Stream <= data_stream(6 downto 0) &  data_in;
										
											NS <= ReadMakeStream;
								elsif(streamCountCurrent = 10) then 
									LED <= data_in;
									NS <= ReadMakeStream;
								else 
									stremCountNext <= 0;
									NS <= ReadBreak1;
								end if;
								
							when ReadBreak1 => 
								if(streamCountCurrent < 9 or streamCountCurrent >= 0) then 
									
										data_Stream2 <= data_stream2(6 downto 0) &  data_in;
									
										NS <= ReadBreak1;
								elsif(streamCountCurrent = 10) then 
									
									LED <= data_in;
									NS <= ReadBreak1;
								else 
									stremCountNext <= 0;
									NS <= ReadBreak2;
								end if;
							
						when ReadBreak2 => 
								if(streamCountCurrent < 9 or streamCountCurrent >= 0) then 
									
										data_Stream3 <= data_stream3(6 downto 0) &  data_in;
							
										NS <= ReadBreak2;
								elsif(streamCountCurrent = 10) then 
									
									LED <=data_in;
									NS <= ReadBreak2;
								else 
									stremCountNext <= 0;
									NS <= Idle;
								end if;
								
							
						end case;
						end process;
						
						process(data_Stream)
							begin 
								if(data_stream = x"1c") then 
										LED2 <= '1';
								else 
										LED2 <= '0';
								end if;
							end process;
end Behavioral;

