module datapath ( slow_clock, fast_clock, resetb,
                  load_pcard1, load_pcard2, load_pcard3,
                  load_dcard1, load_dcard2, load_dcard3,
                  pcard3_out,
                  pscore_out, dscore_out,
                  HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);

input slow_clock, fast_clock, resetb;
input load_pcard1, load_pcard2, load_pcard3;
input load_dcard1, load_dcard2, load_dcard3;
output [3:0] pcard3_out;
output [3:0] pscore_out, dscore_out;
output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

wire [3:0] new_card, pcard1, pcard2, pcard3, dcard1, dcard2, dcard3;


// The code describing your datapath will go here.  Your datapath 
// will hierarchically instantiate six card7seg blocks, two scorehand
// blocks, and a dealcard block.  The registers may either be instatiated
// or included as sequential always blocks directly in this file.
//
// Follow the block diagram in the Lab 1 handout closely as you write this code

reg4 PCard1(.inCard(new_card), .enable(load_pcard1), .reset(resetb), .slow_clock(slow_clock), .outCard(pcard1));
reg4 PCard2(.inCard(new_card), .enable(load_pcard2), .reset(resetb), .slow_clock(slow_clock), .outCard(pcard2));
reg4 PCard3(.inCard(new_card), .enable(load_pcard3), .reset(resetb), .slow_clock(slow_clock), .outCard(pcard3));
reg4 DCard1(.inCard(new_card), .enable(load_dcard1), .reset(resetb), .slow_clock(slow_clock), .outCard(dcard1));
reg4 DCard2(.inCard(new_card), .enable(load_dcard2), .reset(resetb), .slow_clock(slow_clock), .outCard(dcard2));
reg4 DCard3(.inCard(new_card), .enable(load_dcard3), .reset(resetb), .slow_clock(slow_clock), .outCard(dcard3));
card7seg card7seg1(.SW(pcard1), .HEX(HEX0));
card7seg card7seg2(.SW(pcard2), .HEX(HEX1));
card7seg card7seg3(.SW(pcard3), .HEX(HEX2));
card7seg card7seg4(.SW(dcard1), .HEX(HEX3));
card7seg card7seg5(.SW(dcard2), .HEX(HEX4));
card7seg card7seg6(.SW(dcard3), .HEX(HEX5));
scorehand scorehand1(.card1(pcard1), .card2(pcard2), .card3(pcard3), .score(pscore_out));
scorehand scorehand2(.card1(dcard1), .card2(dcard2), .card3(dcard3), .score(dscore_out));
dealcard dealCard(.clock(fast_clock), .resetb(resetb), .new_card(new_card));

endmodule
