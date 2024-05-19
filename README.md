CS 231 Lab  
*Each lab is worth 10 points. All lab work must be initiated before the lab hour.   
Subroutine And Parameter Passing – Groceries  
Write a program for a grocery store to calculate the total charge for customers 
following this  
algorithm:  
1. In the main:   
a) ask customer for the number of items that they are purchasing   
b) check to see it is less than or equal to 20 items   
c) pass than number to FillPriceArray subroutine and call FillPriceArray subroutine.  
2. FillPriceArray subroutine:  
a) fill the array and accumulate the prices sub total   
b) return the sub total to main.  
3. In the main:  
a) ask customer for the number of coupons (it should be the same as the number of  
items)   
b) pass the coupon number to FillCouponArray subroutine and call FillCouponArray  
subroutine to fill the CouponArray.   
4. FillCouponArray subroutine:  
a) fills the array and accumulate the discount total  
*get the coupon amount:  
The coupon should be less than item price and coupon should not be more than $10  
if the coupon is more than item price or exceed $10 then you place 0 in the  
CouponArray for that coupon.    
b) return coupon sum to main  
5. In the main:  
a) calculate the total charge by subtracting the total price from total discount 
coupons   
b) out put the total charge with a thank you massage on the screen.  
