.data
  str1: .string	"This is HW1_2: With size "
  str2: .string	" * "
  str3: .string	"\nBefore:\n"
  str4: .string	"Result:\n"
  str5: .string	"\t"
  str6: .string	"\n"
  data_i: .dword 208, 37, 181, 125, 192, 90, 20, 154, 28, 35
       .dword 231, 108, 9, 114, 66, 51, 14, 68, 246, 222
       .dword 33, 234, 71, 165, 130, 65, 136, 167, 2, 148
       .dword 233, 203, 12, 181, 179, 158, 199, 176, 198, 141
       .dword 162, 245, 25, 193, 228, 121, 239, 191, 209, 37
       .dword 25, 168, 210, 71, 245, 90, 34, 115, 222, 218
       .dword 72, 10, 178, 174, 140, 212, 146, 22, 22, 159
       .dword 140, 217, 81, 168, 36, 150, 120, 59, 102, 90
       .dword 245, 239, 243, 42, 39, 141, 4, 233, 67, 131
       .dword 247, 174, 9, 31, 66, 234, 86, 39, 205, 103
       .dword 41, 194, 112, 128, 215, 73, 42, 211, 111, 20
       .dword 248, 190, 98, 245, 65, 194, 203, 138, 233, 62
       .dword 245, 101, 196, 87, 208, 193, 80, 255, 47, 32
       .dword 124, 168, 203, 150, 63, 98, 135, 20, 68, 47
       .dword 205, 44, 48, 58, 237, 145, 43, 113, 38, 62
  data_o: .dword 0:104 #initiate 104 dwords with value 0
  data_size: .dword 15, 10
  buffer: .dword 0:9

.globl main

.text

#----------------------------------------------------Do not modify below text----------------------------------------------------
main:
  # Main function loop parameters setting
  la t0, data_size
  ld s2, 0(t0)				# rows
  ld s3, 8(t0)				# cols

  # Print initiate
  li a7, 4
  la a0, str1
  ecall
  li a7, 1
  mv a0, s2
  ecall
  li a7, 4
  la a0, str2
  ecall
  li a7, 1
  mv a0, s3
  ecall
  li a7, 4
  la a0, str3
  ecall

  # Print function
  # a1 stores print address, a2 stores the row length, and a3 stores the col length
  la a1, data_i
  mv a2, s2					# data_i rows
  mv a3, s3					# data_i cols
  jal prints				# print data
#----------------------------------------------------Do not modify above text----------------------------------------------------
### Start your code here ###

mv t0, zero # i = 0
addi a2, s2, -2 # a2 = rows - 2
addi a3, s3, -2 # a3 = cols - 2

la a4, data_o # addr of data_o
la s6, buffer # addr of buffer

li s7, 9 # size of buffer

mv s1, zero

filter_outer:
  bge t0, a2, exit_outer # for i < rows - 2

  li t1, 0 # t1 = j = 0

filter_inner:
  bge t1, a3, exit_inner # for j < cols - 2

  # load pixels into buffer

  mul s4, t0, s3  #  i * cols
  add s4, s4, t1 #  + j
  slli s4, s4, 3  # offset addr = index * 8
  add s4, s4, a1 # &data_i[i][j] = offset + data_i
  # s4 = address of elemtnts in data_i

  ld s5, 0(s4) # load element from array
  sd s5, 0(s6) # store data_i[i][j]

  ld s5, 8(s4)
  sd s5, 8(s6) # data_i[i][j + 1]

  ld s5, 16(s4)
  sd s5, 16(s6) # data_i[i][j + 2]

  mul s4, t0, s3  # i * col
  add s4, s4, s3 # + col
  add s4, s4, t1 # + j
  slli s4, s4, 3 
  add s4, s4, a1 # &data_i[i + 1][j]
  
  ld s5, 0(s4)
  sd s5, 24(s6) # data_i[i + 1][j]

  ld s5, 8(s4) 
  sd s5, 32(s6) # data_i[i + 1][j + 1]

  ld s5, 16(s4) 
  sd s5, 40(s6) # data_i[i + 1][j + 2]

  mul s4, t0, s3  # i * cols
  add s4, s4, s3 # + col
  add s4, s4, s3 # + col
  add s4, s4, t1 # + j
  slli s4, s4, 3 
  add s4, s4, a1 # &data_i[i + 2][j]
  
  ld s5, 0(s4)
  sd s5, 48(s6) # data_i[i + 2][j]

  ld s5, 8(s4) 
  sd s5, 56(s6) # data_i[i + 2][j + 1]

  ld s5, 16(s4) 
  sd s5, 64(s6) # data_i[i + 2][j + 2]
  
  jal sort

  mul s8, t0, a3  # i * col
  add s8, s8, t1 # + j
  slli s8, s8, 3 # offset = (i * col + j) << 3
  add s8, s8, a4  # &data_o[i][j]

  ld s9, 32(s6) # load buffer[4]
  sd s9, 0(s8) # data_o[i][j] = buffer[4]

  addi t1, t1, 1 # j++
  j filter_inner

exit_inner:
  addi t0, t0, 1 # i++
  j filter_outer

exit_outer:
  j ends

sort:
  mv t2, zero # t2 = m = 0

sort_outer:
  bge t2, s7, exit_i # if m > 9 jump out loop
  addi t3, t2, 0 # n = m

sort_inner:
  addi t3, t3, 1 # n++
  bge t3, s7, exit_j # if (j > 9) exit loop j
  
  slli t4, t2, 3 # m * 8
  slli t5, t3, 3 # n * 8
  add t4, t4, s6 # buffer + m * 8
  add t5, t5, s6 # buffer + n * 8
  lw s10, 0(t4) # s10 = buffer[m]
  lw s11, 0(t5) # s11 = buffer[n]

  blt s10, s11, sort_inner # if (buffer[m] < buffer[n]) continue

  # swap
  mv t6, s10 # tmp = num[m]
  sw s11, 0(t4) # num[m] = num[n]
  sw t6, 0(t5) # num[n] = tmp
  
  j sort_inner

exit_j:
  addi t2, t2, 1 # m++
  j sort_outer

exit_i:
  jr ra

#----------------------------------------------------Do not modify below text----------------------------------------------------
ends:
  # Print str4
  li a7, 4
  la a0, str4
  ecall
  # Print function
  # a1 stores print address, a2 stores the row length, and a3 stores the col length
  la a1, data_o
  addi a2, s2, -2			# data_o rows = rows - 2
  addi a3, s3, -2			# data_o cols = cols - 2
  jal prints				# print data

  # Done, terminate program
  li a7, 10				# terminate
  ecall					# system call

# Print function
prints:
  addi sp, sp, -32
  sd ra, 24(sp)
  sd s3, 16(sp)
  sd s2, 8(sp)
  sd s1, 0(sp)
  # a1 stores print address, a2 stores the row length, and a3 stores the col length
  mv s1, a1
  mv s2, a2
  mv s3, a3
  li t0, 0				# for(i=0)
printforloop1:
  bge t0, s2, printexit1		# if ( i>=row ) jump to printexit1
  li t1, 0				# for(j=0)
printforloop2:
  bge t1, s3, printexit2		# if ( j>=col ) jump to printexit2
  li a7, 1				# print_int
  ld t2, 0(s1)
  mv a0, t2
  ecall
  li a7 4
  la a0, str5
  ecall
  addi s1, s1, 8			# Move to next memory address(8 bytes)
  addi t1, t1, 1			# j = j + 1
  j printforloop2
printexit2:
  li a7, 4
  la a0, str6
  ecall
  addi t0, t0, 1			# i = i + 1
  j printforloop1
printexit1:
  ld s1, 0(sp)
  ld s2, 8(sp)
  ld s3, 16(sp)
  ld ra, 24(sp)
  addi sp, sp, 32
  jr ra
#----------------------------------------------------Do not modify above text----------------------------------------------------
