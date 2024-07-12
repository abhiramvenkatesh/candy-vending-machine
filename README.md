## Introduction
The Candy Vending Machine Verilog project aims to design and implement a \
digital vending machine using the Verilog. The vending machine is a digital \
system that simulates the behaviour of a simple vending machine, allowing \
users to insert money, make a selection, and receive a product along with any \
necessary change. \
# Problem statement
Design and implement a candy vending machine that allows users to select and \ 
purchase candies. The vending machine should offer a variety of candy options \
with different prices. Users should be able to make selections, view the total \
cost of their choices, and complete the purchase by inserting the appropriate \
amount of money. \
# Methodology
We first got the algorithm for the candy vending machine. We created a \
candy.txt a text document which has the candy flavors and then we created \
the price.txt text file where the Candy prices are stored. \
The created text file must be created in the simulation sources for the reading the text file in verilog. \
After reading the text file and we get the input from the user about the \
candy flavor and then the price will get calculated. \
The user will be given the option for to select the mode of payment so that \
the non cash payments can also be done. Even for the card payments we get \
different text files so that the payment is possible. \
The equation we used are: \
T otal = Candyprice × Quantity \
Changegenerated = Moneygiven by user − Total \
