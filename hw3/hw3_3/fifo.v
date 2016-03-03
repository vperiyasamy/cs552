/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module fifo(/*AUTOARG*/
   // Outputs
   data_out, fifo_empty, fifo_full, err,
   // Inputs
   data_in, data_in_valid, pop_fifo, clk, rst
   );
   input [63:0] data_in;
   input        data_in_valid;
   input        pop_fifo;

   input        clk;
   input        rst;
   output [63:0] data_out;
   output        fifo_empty;
   output        fifo_full;
   output        err;

   reg [63:0] slot_1_in, slot_2_in, slot_3_in, slot_4_in;
   wire [63:0] slot_1_out, slot_2_out, slot_3_out, slot_4_out;

   reg [2:0] open_slot;
   wire [2:0] open_slot_w;
   reg [63:0] data_out_r;
   reg fifo_empty_r, fifo_full_r, err_r;
   wire fifo_empty_out, reset_done;

   assign fifo_empty = (~reset_done) ? 1'b1 : fifo_empty_out;

   dff edge_detect (.q(reset_done), .d(1'b1), .clk(clk), .rst(rst));

   dff open_slots[2:0] (.q(open_slot_w), .d(open_slot), .clk(clk), .rst(rst));
   dff fifo_empty_reg (.q(fifo_empty_out), .d(fifo_empty_r), .clk(clk), .rst(rst));
   dff fifo_full_reg (.q(fifo_full), .d(fifo_full_r), .clk(clk), .rst(rst));
   dff err_reg (.q(err), .d(err_r), .clk(clk), .rst(rst));

   dff data_out_reg[63:0] (.q(data_out), .d(data_out_r), .clk(clk), .rst(rst));

   dff slot_1[63:0] (.q(slot_1_out), .d(slot_1_in), .clk(clk), .rst(rst));
   dff slot_2[63:0] (.q(slot_2_out), .d(slot_2_in), .clk(clk), .rst(rst));
   dff slot_3[63:0] (.q(slot_3_out), .d(slot_3_in), .clk(clk), .rst(rst));
   dff slot_4[63:0] (.q(slot_4_out), .d(slot_4_in), .clk(clk), .rst(rst));


   always@(*) begin
       data_out_r = 64'h0000000000000000;
       fifo_empty_r = 1'b1;
       fifo_full_r = 1'b0;
       err_r = 1'b0;
       open_slot = 3'b000;

       case(open_slot_w)
	   3'b000: begin
		//fifo_empty_r = 1'b1;
		if(data_in_valid) begin
			open_slot = 3'b001;
			fifo_empty_r = 1'b0;
			slot_1_in = data_in; 
                        slot_2_in = 64'h0000000000000000;
                        slot_3_in = 64'h0000000000000000;
                        slot_4_in = 64'h0000000000000000;
			data_out_r = data_in;
		end
		else begin
			fifo_empty_r = 1'b1;
			open_slot = 3'b000;
                        slot_1_in = 64'h0000000000000000;
                        slot_2_in = 64'h0000000000000000;
                        slot_3_in = 64'h0000000000000000;
                        slot_4_in = 64'h0000000000000000;

		end

	   end

	   3'b001: begin
                data_out_r = slot_1_out;
		fifo_empty_r = 1'b0;	
		if(data_in_valid && pop_fifo) begin
			open_slot = 3'b001;
			slot_1_in = data_in;
			data_out_r = data_in;
                        slot_2_in = 64'h0000000000000000;
                        slot_3_in = 64'h0000000000000000;
                        slot_4_in = 64'h0000000000000000;

		end

		else if(data_in_valid) begin
			open_slot = 3'b010;
			slot_1_in = slot_1_out;
			slot_2_in = data_in;
                        slot_3_in = 64'h0000000000000000;
                        slot_4_in = 64'h0000000000000000;

		end

		else if(pop_fifo) begin
			open_slot = 3'b000;
			data_out_r = slot_2_out;
			fifo_empty_r = 1'b1;
                        slot_1_in = 64'h0000000000000000;
                        slot_2_in = 64'h0000000000000000;
                        slot_3_in = 64'h0000000000000000;
                        slot_4_in = 64'h0000000000000000;

		end

		else begin
			open_slot = 3'b001;
			slot_1_in = slot_1_out;
			slot_2_in = slot_2_out;
			slot_3_in = slot_3_out;
			slot_4_in = slot_4_out;
		end
	   end

	   3'b010: begin
                data_out_r = slot_1_out;
		fifo_empty_r = 1'b0;
                if(data_in_valid && pop_fifo) begin
                        open_slot = 3'b010;
			data_out_r = slot_2_out;
                        slot_1_in = slot_2_out;
                        slot_2_in = data_in;
                        slot_3_in = 64'h0000000000000000;
                        slot_4_in = 64'h0000000000000000;

                end

                else if(data_in_valid) begin
                        open_slot = 3'b011;
                        slot_1_in = slot_1_out;
                        slot_2_in = slot_2_out;
                        slot_3_in = data_in;
                        slot_4_in = 64'h0000000000000000;

                end

                else if(pop_fifo) begin
                        open_slot = 3'b001;
			data_out_r = slot_2_out;
                        slot_1_in = slot_2_out;
                        slot_2_in = 64'h0000000000000000;
                        slot_3_in = 64'h0000000000000000;
                        slot_4_in = 64'h0000000000000000;

                end

                else begin
                        open_slot = 3'b010;
                        slot_1_in = slot_1_out;
                        slot_2_in = slot_2_out;
                        slot_3_in = slot_3_out;
                        slot_4_in = slot_4_out;
                end

	   end

           3'b011: begin
                data_out_r = slot_1_out;
                fifo_empty_r = 1'b0;
                if(data_in_valid && pop_fifo) begin
                        open_slot = 3'b011;
			data_out_r = slot_2_out;
                        slot_1_in = slot_2_out;
                        slot_2_in = slot_3_out;
                        slot_3_in = data_in;
                        slot_4_in = 64'h0000000000000000;

                end

                else if(data_in_valid) begin
                        open_slot = 3'b100;
			fifo_full_r = 1'b1;
                        slot_1_in = slot_1_out;
                        slot_2_in = slot_2_out;
                        slot_3_in = slot_3_out;
                        slot_4_in = data_in;

                end

                else if(pop_fifo) begin
                        open_slot = 3'b010;
			data_out_r = slot_2_out;
                        slot_1_in = slot_2_out;
                        slot_2_in = slot_3_out;
                        slot_3_in = 64'h0000000000000000;
                        slot_4_in = 64'h0000000000000000;

                end

                else begin
                        open_slot = 3'b011;
                        slot_1_in = slot_1_out;
                        slot_2_in = slot_2_out;
                        slot_3_in = slot_3_out;
                        slot_4_in = slot_4_out;
                end
           end

           3'b100: begin
                data_out_r = slot_1_out;
                fifo_empty_r = 1'b0;
                if(data_in_valid && pop_fifo) begin
                        open_slot = 3'b011;
			data_out_r = slot_2_out;
			fifo_full_r = 1'b0;
                        slot_1_in = slot_2_out;
                        slot_2_in = slot_3_out;
                        slot_3_in = slot_4_out;
                        slot_4_in = 64'h0000000000000000;

                end

                else if(data_in_valid) begin
                        open_slot = 3'b100;
			fifo_full_r = 1'b1;
                        slot_1_in = slot_1_out;
                        slot_2_in = slot_2_out;
                        slot_3_in = slot_3_out;
                        slot_4_in = slot_4_out;

                end

                else if(pop_fifo) begin
                        open_slot = 3'b011;
			data_out_r = slot_2_out;
                        slot_1_in = slot_2_out;
                        slot_2_in = slot_3_out;
                        slot_3_in = slot_4_out;
                        slot_4_in = 64'h0000000000000000;

                end

                else begin
                        open_slot = 3'b100;
                        slot_1_in = slot_1_out;
                        slot_2_in = slot_2_out;
                        slot_3_in = slot_3_out;
                        slot_4_in = slot_4_out;
   		        fifo_full_r = 1'b1;

                end
           end

           default: begin
		err_r = 1'b1;
	   end


       endcase

   end

endmodule
// DUMMY LINE FOR REV CONTROL :1:
