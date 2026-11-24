Library IEEE;
USE IEEE.Std_logic_1164.all;
  
  Entity n_sipo is
  generic (n:integer:=4);
  port(CLK, CLR : IN Std_logic;
		 D : IN Std_logic;
		 Q : OUT Std_logic_vector(n-1 downto 0)
		  );
  end n_sipo;
  
 Architecture behavior of n_sipo is
  SIGNAL Qi : STD_LOGIC_VECTOR ( n-1 downto 0 ) := (others => '0');
  Signal ct: INTEGER range 0 to n-1;
  
 begin
  sipo_in :PROCESS ( CLK , CLR )
  
  begin

  IF ( CLR = '1') THEN 
	  Qi <= (others => '0');
  ELSIF ( rising_edge ( CLK ) ) THEN 
		    Qi <= Qi(n-2 downto 0) & D; 
 END IF ; 
 END PROCESS sipo_in;
 
 cnt: process(CLK, CLR)
 begin
 if (CLR = '1') then
     ct <= n-1;
 elsif(rising_edge(CLK)) then
	 ct <= (ct + 1) mod n;
	 if (ct = 0) then
		 Q <= Qi;
	 end if;	
 end if;
 end process cnt;
 
END behavior ;
  