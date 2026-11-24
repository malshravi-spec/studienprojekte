Library IEEE;
USE IEEE.Std_logic_1164.all;

Entity tb_n_sipo is
end tb_n_sipo;

architecture test of tb_n_sipo is

component n_sipo is
generic (n:integer:=4);
  port(CLK, CLR : IN Std_logic;
		 D : IN Std_logic;
		 Q : OUT Std_logic_vector(n-1 downto 0)
		  );
end component;
signal Qt : std_logic_vector(3 downto 0) := (others => '0');
signal clk, clr, Dt: std_logic := '0';
begin
 
 sipo_4: n_sipo
 generic map(n=>4)
 port map(clk,clr,Dt,Qt);
 
 taktstimuli:process
	begin
	 clk <= '1'; wait for 20 ns;
	 clk <= '0'; wait for 20 ns;
	end process;
	
	clearstimuli: process
	begin
	clr <= '1'; wait for 55 ns;
	clr <= '0'; wait for 800 ns;
	end process;

	d_stimuli: process
	begin
	Dt <= '1'; wait for 40 ns;
	Dt <= '0'; wait for 80 ns;
	end process;				

 
end test;