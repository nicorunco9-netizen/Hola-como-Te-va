# prog.s — Ripes: experimento de hazards (RAW de carga + control hazard)
# Podés cargar este mismo código en Ripes y ver pipeline con/ sin forwarding.

    .data
arr: .word 4, 7, -3, 10, 1, 2, 3, 4
n:   .word 8
acc: .word 0

    .text
    .globl _start
_start:
    la   t1, arr
    li   t0, 0        # acc
    lw   t2, n        # len

loop:
    beqz t2, fin
    lw   t3, 0(t1)    # carga -> dependencia RAW con add siguiente
    add  t0, t0, t3   # dependiente (probá insertar NOP aquí)
    addi t1, t1, 4
    addi t2, t2, -1
    # branch opcional para controlar flushes:
    # beq  t3, zero, saltar
    j    loop
saltar:
    j    loop

fin:
    sw   t0, acc
hang:
    j hang
