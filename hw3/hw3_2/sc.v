/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */

module sc( clk, rst, ctr_rst, out, err);
    input clk;
    input rst;
    input ctr_rst;
    output [2:0] out;
    output err;

    wire [2:0] counter;

    dff cnt_0(.q(out[0]), .d(counter[0]), .clk(clk), .rst(rst));
    dff cnt_1(.q(out[1]), .d(counter[1]), .clk(clk), .rst(rst));
    dff cnt_2(.q(out[2]), .d(counter[2]), .clk(clk), .rst(rst));

    assign counter = (rst | ctr_rst) ? 3'b000 :
		     (counter == 3'b101) ? 3'b101 :
		     (out + 1);
    
    assign err = (counter > 3'b101) ? 1'b1 :
		 1'b0;

endmodule

// DUMMY LINE FOR REV CONTROL :1:
