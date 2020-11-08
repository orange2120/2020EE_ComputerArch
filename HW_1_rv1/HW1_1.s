#----------------------------------------------------Do not modify below text----------------------------------------------------
.data
  str1: .string	"This is HW1_1:\nBefore sorting: \n"
  str2: .string	"\nAfter sorting:\n"
  str3: .string	"  "
  stri: .string "i="
  strj: .string "j="
  strn: .string "\n"
  num: .dword  -1, 3, -5, 7, -9, 2, -4, 6, -8, 10 
  # num: .dword  343, -64, -32768, 30, 12324, 9999, -5555, 2, -8, 10 

.globl main

.text
main:
  # Print initiate
  li a7, 4
  la a0, str1
  ecall
  
  # a2 stores the num address, a3 stores the length of  num
  la a2, num
  li a3, 10
  jal prints
  
  # sorting procedure
  la a2, num
  li a3, 10
  jal sort
  
  # Print result
  li a7, 4
  la a0, str2
  ecall

  la a2, num
  li a3, 10
  jal prints
  
  # End the program
  li a7, 10
  ecall
#----------------------------------------------------Do not modify above text----------------------------------------------------
sort:
### Start your code here ###
  
  mv t1, zero # i = 0

loopi:
  bge t1, a3, exit_i # if i > n jump out loop

  addi t2, t1, 0 # j = i

loopj:
  addi t2, t2, 1 # j++
  bge t2, a3, exit_j # if (j > n) exit loop j
  
  slli t3, t1, 3 # i * 8
  slli t4, t2, 3 # j * 8
  add t3, t3, a2 # num + i * 8
  add t4, t4, a2 # num + j * 8
  lw t5, 0(t3) # t5 = num[i]
  lw t6, 0(t4) # t6 = num[j]

  blt t5, t6, loopj # if (num[i] < num[j]) continue

  # swap
  mv t0, t5 # tmp = num[i]
  sw t6 0(t3) # num[i] = num[j]
  sw t0, 0(t4) # num[j] = tmp
  
  j loopj

exit_j:
  addi t1, t1, 1 # i++
  j loopi

exit_i:
  jr ra

#----------------------------------------------------Do not modify below text----------------------------------------------------
# Print function	
prints:
  mv t0, zero # for(i=0)
  # a2 stores the num address, a3 stores the length of  num
  mv t1, a2 # num
  mv t2, a3 # len
printloop:
  bge t0, t2, printexit # if ( i>=length of num ) jump to printexit 
  slli t4, t0, 3 # t4 = offset (i * 8)
  add t5, t1, t4 # t5 = &num[i] =  &num + offset
  lw t3, 0(t5) # load num[i]
  li a7, 1 # print_int
  mv a0, t3
  ecall
	
  li a7, 4
  la a0, str3
  ecall 
	
  addi t0, t0, 1 # i = i + 1
  j printloop
printexit:
  jr ra
#----------------------------------------------------Do not modify above text----------------------------------------------------
