
--Create Entity:
--Library=project_EACN_SESI,Cell=SAR_control,View=entity
--Time:Tue Apr 14 12:04:35 2026
--By:galayko

LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY \SAR_control\ IS
    PORT(
        Vsw1 : OUT std_ulogic;
        Vsw2 : OUT std_ulogic;
        VswC : OUT std_ulogic;
        VswC0 : OUT std_ulogic;
        VswC1 : OUT std_ulogic;
        VswC2 : OUT std_ulogic;
        VswC3 : OUT std_ulogic;
		Cout   : OUT std_ulogic_vector(3 downto 0);
        CLK : IN std_ulogic;
        Comp : IN std_ulogic
    );
END \SAR_control\;


architecture Behavioral of \SAR_control\ is
    signal phase_count : integer range 0 to 5 :=0;
    signal 	Cout_s   : std_ulogic_vector(3 downto 0); -- le mot de sortie
    signal out_ready : std_ulogic; 
 
begin

   process (CLK) 
	begin
	if clk='1' then
         out_ready<='0';
		case phase_count is
			when 0 =>  -- sample
				vsw1 <= '1'; -- vcm
				vsw2 <= '0'; -- vin, position 1
				vswC3 <= '1'; -- position 2
				vswC2 <= '1'; -- position 2
				vswC1 <= '1'; -- position 2
				vswC0 <= '1'; -- position 2
				vswC <= '1'; -- position 2
				phase_count <= phase_count+1;
				out_ready <= '0';

			when 1 =>
				vsw1 <= '0';
				vsw2 <= '1'; -- vref
				vswC3 <= '1'; -- vref
				vswC2 <= '0'; -- gnd
				vswC1 <= '0'; -- gnd
				vswC0 <= '0'; -- gnd
				vswC <= '0'; -- gnd
				phase_count <= phase_count+1;
				
			when 2 =>
				vsw1 <= '0';
				vsw2 <= '1'; -- vref

				vswC3 <= not Comp;
				vswC2 <= '1'; -- vref
				Cout_s(3) <= not Comp; -- Bit 0

				phase_count <= phase_count+1;

			when 3 =>
				vsw1 <= '0';
				vsw2 <= '1'; -- vref

				vswC2 <= not Comp;
				vswC1 <= '1';
				Cout_s(2) <= not Comp; -- Bit 2

				phase_count <= phase_count+1;

			when 4 =>
				vsw1 <= '0';
				vsw2 <= '1'; -- vref

				vswC1 <= not Comp;
				vswC0 <= '1';
				Cout_s(1) <= not Comp; -- Bit 1

				phase_count <= phase_count+1;

			when 5 =>
				vsw1 <= '0';
				vsw2 <= '1'; -- vref

				vswC0 <= not Comp;
				vswC <= '1';
				Cout_s(0) <= not Comp; -- Bit 0

				phase_count <= 0;
				out_ready <= '1';

			when others =>
				null;				
		end case;
	end if;
	end process;

	process(out_ready) begin
		Cout <= Cout_s; -- connecte la sortie lorsqu'elle est prete
	end process;

	
end Behavioral;

