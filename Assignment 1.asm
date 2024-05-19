.data
itemprompt: .asciiz "How many items are you purchasing? "
greater: .asciiz "You have more than 20 items. This line is for less than 20.Try again"
less: .asciiz "You need atleast one item. Try again"
price: .asciiz "Enter the price of item "
howmanycoupons: .asciiz "How many coupons do you have? "
dontAccept: .asciiz "This coupon is not acceptable. \n"
CouponDisplay: .asciiz "Please enter the amount of coupon "
TooMany: .asciiz "Too many coupons! Please input the amount of coupons that you want to use. \n "
total: .asciiz "Your total charge is: "
thanks: .asciiz "Thank you for shopping with us! "
items: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
coupons: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
newline: .asciiz "\n"
semi: .asciiz ": "
space: .asciiz " "

.text


la $s1,items #address of items array
la $s4,coupons #address of coupons array

input:

li $v0,4
la $a0,itemprompt #to print item prompt
syscall


li $v0,5 #user input
syscall

add $s0,$s0,$v0 #moving input to s0


addi $s7,$s7,20 #loading 20 to s7



bgt $s0,$s7,greaterthan #checking if greater than 20



add $a0,$s0,$0 #moving how many items input


jal FillPriceArray #fill price array function
add $s2,$s2,$v1 #moving total return value to s2

InputCouponAmount:

li $v0,4
la $a0,howmanycoupons #printing how many coupons
syscall

li $v0,5 #getting users input
syscall

add $s3,$v0,$0 #how many coupons counter

bgt $s3,$s0,TooManyCoupons


add $a0,$s3,$0 #moving coupon counter to pass argument 0
jal FillCouponArray
add $s5,$v1,$0 #total of coupon

sub $s2,$s2,$s5 #subtracting the total items and the coupon amount

li $v0,4
la $a0,total #printing total prompt
syscall

li $v0,1
add $a0,$s2,$0 #printing total result
syscall

li $v0,4
la $a0,newline
syscall


li $v0,4
la $a0,thanks #print end prompt
syscall


li $v0,10 #end program
syscall


FillPriceArray:
add $t0,$a0,$0 # moving counter to t0 for function

addi $t6,$t6,1

fill:

beq $t0,$0,donefill #branch if counter is equal to 0

li $v0,4
la $a0,price #enter price prompt
syscall

li $v0,1
add $a0,$t6,$0 #print number of element
syscall 

addi $t6,$t6,1 #adding 1 to print display number

li $v0,4
la $a0,semi #semicolon print
syscall

li $v0,5 #getting user input
syscall


add $t1,$v0,$0 #input value moving to t1
add $t2,$t2,$t1#adding total to t2
sw $t1,0($s1) #storing input value to array


addi $s1,$s1,4 #moving to next element of array
sub $t0,$t0,1 #subtracting 1 from the counter

j fill #jump back to fill

donefill:
add $v1,$t2,$0 #passing total back to main
jr $ra #return address



FillCouponArray:
add $t0,$a0,$0 #coupon counter
la $s1,items #resetting address of items array
li $t5,10
li $t6,1
couponfill:

beq $t0,$0,DoneCouponFill #branch when coupon array is full


li $v0,4
la $a0,CouponDisplay #displaying coupon number
syscall

li $v0,1
add $a0,$t6,$0 #print number of coupon
syscall


li $v0,4
la $a0,semi #semicolon print
syscall

addi $t6,$t6,1 #adding 1 to number of coupon


li $v0,5 #getting user input
syscall

add $t1,$v0,$0 #moving user input to t1

lw $t2,0($s1) #loading from items array 

bgt $t1,$t2,toohigh #branch if coupon is higher than item

bgt $t1,$t5,coupontoomuch #branch if coupon is more than 10

sw $t1, 0($s4) #storing to array

add $t3,$t3,$t1 #adding coupon total to t3

addi $s4,$s4,4 #adding 4 to move to next coupon element

sub $t0,$t0,1 #subtracting 1 from the counter

j couponfill

doneCheck:
addi $s4,$s4,4 #adding 4 to move to next coupon element

addi $s1,$s1,4 #adding 4 to move to next item element

sub $t0,$t0,1 #subtracting 1 from the counter

j couponfill

DoneCouponFill:
add $v1,$t3,$0
jr $ra



toohigh:
li $v0,4
la $a0,dontAccept #printing to high coupon prompt
syscall

sw $0,0($s4) #loading 0 b/c coupon higher than item

j doneCheck


coupontoomuch:
li $v0,4
la $a0,dontAccept #print coupon over 10 prompt
syscall

sw $0,0($s4) #storing 0 b/c coupon over 10

j doneCheck

TooManyCoupons:
li $v0,4
la $a0,TooMany
syscall
j InputCouponAmount

greaterthan:
li $v0,4
la $a0,greater # printing greater than prompt
syscall
li $v0,4
la $a0,newline # endl
syscall
j input

