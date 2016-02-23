library verilog;
use verilog.vl_types.all;
entity reg_16 is
    port(
        read_data       : out    vl_logic_vector(15 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        writedata       : in     vl_logic_vector(15 downto 0);
        write           : in     vl_logic
    );
end reg_16;
