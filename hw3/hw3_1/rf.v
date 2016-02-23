/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module rf (
           // Outputs
           read1data, read2data, err,
           // Inputs
           clk, rst, read1regsel, read2regsel, writeregsel, writedata, write
           );
   input clk, rst;
   input [2:0] read1regsel;
   input [2:0] read2regsel;
   input [2:0] writeregsel;
   input [15:0] writedata;
   input        write;

   output [15:0] read1data;
   output [15:0] read2data;
   output        err;

   wire [15:0] r0_out, r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out;
   wire [7:0] write_en;

   reg_16 r0(.read_data(r0_out), .clk(clk), .rst(rst),
             .writedata(writedata), .write(write_en[0]));
   reg_16 r1(.read_data(r1_out), .clk(clk), .rst(rst), 
             .writedata(writedata), .write(write_en[1]));
   reg_16 r2(.read_data(r2_out), .clk(clk), .rst(rst), 
             .writedata(writedata), .write(write_en[2]));
   reg_16 r3(.read_data(r3_out), .clk(clk), .rst(rst), 
             .writedata(writedata), .write(write_en[3]));
   reg_16 r4(.read_data(r4_out), .clk(clk), .rst(rst), 
             .writedata(writedata), .write(write_en[4]));
   reg_16 r5(.read_data(r5_out), .clk(clk), .rst(rst), 
             .writedata(writedata), .write(write_en[5]));
   reg_16 r6(.read_data(r6_out), .clk(clk), .rst(rst), 
             .writedata(writedata), .write(write_en[6]));
   reg_16 r7(.read_data(r7_out), .clk(clk), .rst(rst), 
             .writedata(writedata), .write(write_en[7]));

   assign write_en = (writeregsel == 3'b000) ? 8'h01 :
		     (writeregsel == 3'b001) ? 8'h02 :
                     (writeregsel == 3'b010) ? 8'h04 :
                     (writeregsel == 3'b011) ? 8'h08 :
                     (writeregsel == 3'b100) ? 8'h10 :
                     (writeregsel == 3'b101) ? 8'h20 :
                     (writeregsel == 3'b110) ? 8'h40 :
                     8'h80;

   assign read1data = (read1regsel == 3'b000) ? r0_out :
                      (read1regsel == 3'b001) ? r1_out :
                      (read1regsel == 3'b010) ? r2_out :
                      (read1regsel == 3'b011) ? r3_out :
                      (read1regsel == 3'b100) ? r4_out :
                      (read1regsel == 3'b101) ? r5_out :
                      (read1regsel == 3'b110) ? r6_out :
                      r7_out;

   assign read2data = (read2regsel == 3'b000) ? r0_out :
                      (read2regsel == 3'b001) ? r1_out :
                      (read2regsel == 3'b010) ? r2_out :
                      (read2regsel == 3'b011) ? r3_out :
                      (read2regsel == 3'b100) ? r4_out :
                      (read2regsel == 3'b101) ? r5_out :
                      (read2regsel == 3'b110) ? r6_out :
                      r7_out;


endmodule
// DUMMY LINE FOR REV CONTROL :1:
