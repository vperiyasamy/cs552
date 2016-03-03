library verilog;
use verilog.vl_types.all;
entity fifo is
    port(
        data_out        : out    vl_logic_vector(63 downto 0);
        fifo_empty      : out    vl_logic;
        fifo_full       : out    vl_logic;
        err             : out    vl_logic;
        data_in         : in     vl_logic_vector(63 downto 0);
        data_in_valid   : in     vl_logic;
        pop_fifo        : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic
    );
end fifo;
