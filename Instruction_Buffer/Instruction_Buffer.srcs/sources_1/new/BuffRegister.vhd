----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2020 07:53:22 AM
-- Design Name: 
-- Module Name: BuffRegister - Behavioral
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

entity BuffRegister is
  Port ( 
            Clk : in std_logic;
            d   : in std_logic_vector(31 downto 0);
            q   : out std_logic_vector(31 downto 0)
         );
end BuffRegister;

architecture Behavioral of BuffRegister is

begin


end Behavioral;
