module reg_16 (
           // Outputs
           read_data,
           // Inputs
           clk, rst, writedata, write
           );
   input clk, rst;
   input [15:0] writedata;
   input        write;

   output [15:0] read_data;

   wire [15:0] out, in;

   dff d0(.q(out[0]), .d(in[0]), .clk(clk), .rst(rst));
   dff d1(.q(out[1]), .d(in[1]), .clk(clk), .rst(rst));
   dff d2(.q(out[2]), .d(in[2]), .clk(clk), .rst(rst));
   dff d3(.q(out[3]), .d(in[3]), .clk(clk), .rst(rst));
   dff d4(.q(out[4]), .d(in[4]), .clk(clk), .rst(rst));
   dff d5(.q(out[5]), .d(in[5]), .clk(clk), .rst(rst));
   dff d6(.q(out[6]), .d(in[6]), .clk(clk), .rst(rst));
   dff d7(.q(out[7]), .d(in[7]), .clk(clk), .rst(rst));
   dff d8(.q(out[8]), .d(in[8]), .clk(clk), .rst(rst));
   dff d9(.q(out[9]), .d(in[9]), .clk(clk), .rst(rst));
   dff d10(.q(out[10]), .d(in[10]), .clk(clk), .rst(rst));
   dff d11(.q(out[11]), .d(in[11]), .clk(clk), .rst(rst));
   dff d12(.q(out[12]), .d(in[12]), .clk(clk), .rst(rst));
   dff d13(.q(out[13]), .d(in[13]), .clk(clk), .rst(rst));
   dff d14(.q(out[14]), .d(in[14]), .clk(clk), .rst(rst));
   dff d15(.q(out[15]), .d(in[15]), .clk(clk), .rst(rst));

   assign in[0] = (write) ? writedata[0] : out[0];
   assign in[1] = (write) ? writedata[1] : out[1];
   assign in[2] = (write) ? writedata[2] : out[2];
   assign in[3] = (write) ? writedata[3] : out[3];
   assign in[4] = (write) ? writedata[4] : out[4];
   assign in[5] = (write) ? writedata[5] : out[5];
   assign in[6] = (write) ? writedata[6] : out[6];
   assign in[7] = (write) ? writedata[7] : out[7];
   assign in[8] = (write) ? writedata[8] : out[8];
   assign in[9] = (write) ? writedata[9] : out[9];
   assign in[10] = (write) ? writedata[10] : out[10];
   assign in[11] = (write) ? writedata[11] : out[11];
   assign in[12] = (write) ? writedata[12] : out[12];
   assign in[13] = (write) ? writedata[13] : out[13];
   assign in[14] = (write) ? writedata[14] : out[14];
   assign in[15] = (write) ? writedata[15] : out[15];

   assign read_data = out;

endmodule
// DUMMY LINE FOR REV CONTROL :1:
