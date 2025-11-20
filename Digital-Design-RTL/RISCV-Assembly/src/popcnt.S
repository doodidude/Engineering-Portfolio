# uint8_t popcnt(uint32_t a);
# Takes in a 32 bit integer and returns the number of 1s in it
.global popcnt
popcnt:
	mv t0, a0
	li t1, 0
loop: 
	beqz t0, done
	andi t2, t0, 1 
	add t1, t1, t2 
	srli t0,t0,1
	j loop 
done: 
	mv a0, t1
    ret

# uint8_t popcnt_secure(uint32_t a);
# Takes in a 32 bit integer and returns the number of 1s in it. A more secure
# version of `popcnt` which is roughly constant time for any input `a`
.global popcnt_secure
popcnt_secure:
    mv t0, a0
    li t1, 0
    li t3, 0
    li t4, 32

loopsecure:  
    andi t2, t0, 1
    add t1, t1, t2
    srli t0, t0, 1
    addi t3, t3, 1

    blt t3, t4, loopsecure

donesecure:  
    mv a0, t1 
    ret
