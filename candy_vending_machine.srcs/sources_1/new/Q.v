`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2023 17:55:26
// Design Name: 
// Module Name: Q
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Q(
    input wire q,
    input wire clk,
    input wire [2:0]candy,
    input wire [3:0]qty,
    input wire [7:0]money,
    input wire mode,
    output [7:0]bal,
    output [3:0]num,
    output [7:0]change
    );
    // outputs
    reg [7:0]bal=0;
    reg [7:0]num;
    reg [7:0]change;
    //output ports connection
    reg [7:0]bal1=0;
    reg [7:0]num1;
    reg [7:0]change1;
    // parameters
    parameter a=1,b=2,c=3,d=4,e=5;
    integer ps=a;
    integer ns;
    // file reading
    reg [7:0]buffer[0:7];
    reg [7:0]buffer1[0:7];
    reg [7:0]buffer2[0:1];
    //integers
    integer j;
    integer i;
    // calculating parameters
    reg [7:0] selected;
    reg [7:0] total=0;
    // writing file parameter
    integer file;
    // for all reading taking place
    initial begin
        $readmemh("candy.txt",buffer);
        $readmemh("price.txt",buffer1);
        $readmemb("card.txt",buffer2);
    end
    // start of the processing
    always@(ps or q)begin
        case(ps)
            a:if(q)begin
                ns=b;
                change1=0;
                bal1=0;
                num1=0;
              end
              else
                ns=a;
            b:if(q)begin
                ns=c;
                for(j=0;j<7;j=j+1)begin
                    $display(buffer[j]);
                end
              end
              else begin
                if(i<20)
                    i=i+1;
                else begin
                    ns=a;
                    i=0;
                end
              end 
            c:if(q)begin
                ns=d;
                selected=buffer1[candy];
                bal1=selected*qty;
                $display(selected,bal1);
              end
              else begin
                if(i<20)
                    i=i+1;
                else begin
                    ns=a;
                    i=0;
                end
              end 
            d:if(q)begin
                if(mode)begin
                    total=money;
                    if(total>=bal)begin
                        change1=total-bal1;
                        num=qty;
                        ns=a;
                        
                    end
                    else begin
                        $display("insufficient balance");
                        change1=total;
                        ns=a;
                    end
                end 
                else begin
                    total=buffer2[0];
                    $display(total);
                    if(total>=bal)begin
                        change1=total-bal1;
                        num1=qty;
                        ns=a;
                    end
                    else begin
                        $display("insufficient balance");
                        change1=total;
                        ns=a;
                    end
                end 
               end
              else begin
                    if(i<20)
                        i=i+1;
                    else begin
                        ns=a;
                        i=0;
                    end
              end
        endcase
       end
    // changing of the state with the clock
    always@(posedge clk) begin
        //change of the state
        // writing into the file for the recipt and the record
        num<=num1;
        change<=change1;
        bal<=bal1;
        if(ps==d)begin
            file=$fopen("recipt.txt","a"); 
            $fwrite(file,"candy number%d\n",candy);
            $fwrite(file,"candy quantity%d\n",qty);
            $fwrite(file,"candy pric%d\n",selected);
            $fwrite(file,"total%d\n",bal1);
            $fwrite(file,"updated balance%d\n",change1);
            $fwrite(file,"\n");
            $fclose(file);
            $display(change1,total,bal);
        end
        ps<=ns;
    end
    // writing into the file initially as we move to the next costumer we will append the text file and get the information about the data which we recieve         
endmodule
