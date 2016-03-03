library verilog;
use verilog.vl_types.all;
entity sc_hier is
    port(
        \out\           : out    vl_logic_vector(2 downto 0);
        ctr_rst         : in     vl_logic
    );
end sc_hier;
