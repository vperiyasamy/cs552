library verilog;
use verilog.vl_types.all;
entity rf_hier is
    port(
        read1data       : out    vl_logic_vector(15 downto 0);
        read2data       : out    vl_logic_vector(15 downto 0);
        read1regsel     : in     vl_logic_vector(2 downto 0);
        read2regsel     : in     vl_logic_vector(2 downto 0);
        writeregsel     : in     vl_logic_vector(2 downto 0);
        writedata       : in     vl_logic_vector(15 downto 0);
        write           : in     vl_logic
    );
end rf_hier;
