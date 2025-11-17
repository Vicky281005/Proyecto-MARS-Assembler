.data
display: .space 1024
paleta_colores:
    .word 0xFF000000  # 0: Negro
    .word 0xFF0000FF  # 1: Azul
    .word 0xFFFFFFFF  # 2: Blanco (Pac-Man)
    .word 0xFFFF00FF  # 3: Fucsia
    .word 0xFF800080  # 4: Morado
    .word 0xFFFFFF00  # 5: Amarillo
    .word 0xFFFF0000  # 6: Rojo

mapa_pacman:
    .byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    .byte 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
    .byte 1,0,1,1,0,1,0,1,1,0,1,0,1,1,0,1
    .byte 1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1
    .byte 1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1
    .byte 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
    .byte 1,0,1,1,1,1,0,1,1,0,1,1,1,1,0,1
    .byte 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
    .byte 1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1
    .byte 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
    .byte 1,0,1,1,0,1,1,1,1,1,1,0,1,1,0,1
    .byte 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
    .byte 1,0,1,1,0,1,0,1,1,0,1,0,1,1,0,1
    .byte 1,0,1,1,0,1,0,1,1,0,1,0,1,1,0,1
    .byte 1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1
    .byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

.text
.globl main

main:
    # --- Cargar Direcciones Base ---
    la   $t0, mapa_pacman
    la   $t1, paleta_colores
    li   $t2, 0x10010000

    # --- 1. BUSCAR LUGAR PARA PUNTO BLANCO (Índice 2) ---
find_spot_blanco:
    li   $v0, 42
    li   $a1, 222
    syscall
    addi $a0, $a0, 18
    add  $t6, $t0, $a0     
    lb   $t5, 0($t6)       
    bne  $t5, $zero, find_spot_blanco 
    move $s0, $a0         # $s0 = pacman_pos_index
    li   $t5, 2
    sb   $t5, 0($t6)

    # --- 2. BUSCAR LUGAR PARA PUNTO FUCSIA (Índice 3) ---
find_spot_fucsia:
    li   $v0, 42
    li   $a1, 222
    syscall
    addi $a0, $a0, 18
    add  $t6, $t0, $a0     
    lb   $t5, 0($t6)       
    bne  $t5, $zero, find_spot_fucsia 
    li   $t5, 3
    sb   $t5, 0($t6)

    # --- 3. BUSCAR LUGAR PARA PUNTO MORADO (Índice 4) ---
find_spot_morado:
    li   $v0, 42
    li   $a1, 222
    syscall
    addi $a0, $a0, 18
    add  $t6, $t0, $a0     
    lb   $t5, 0($t6)       
    bne  $t5, $zero, find_spot_morado 
    li   $t5, 4
    sb   $t5, 0($t6)

    # --- 4. GENERAR 3-6 PUNTOS AMARILLOS (Índice 5) ---
    li   $v0, 42
    li   $a1, 4            
    syscall
    addi $s1, $a0, 3      # $s1 = N (3-6)
    li   $s2, 0            # $s2 = i (contador)
bucle_monedas:
    bge  $s2, $s1, fin_bucle_monedas
find_spot_amarillo:
    li   $v0, 42
    li   $a1, 222
    syscall
    addi $a0, $a0, 18
    add  $t6, $t0, $a0     
    lb   $t5, 0($t6)       
    bne  $t5, $zero, find_spot_amarillo 
    li   $t5, 5
    sb   $t5, 0($t6)
    addi $s2, $s2, 1
    j    bucle_monedas
fin_bucle_monedas:

    # --- 5. GENERAR 2-4 PUNTOS ROJOS (Índice 6) ---
    li   $v0, 42
    li   $a1, 3            
    syscall
    addi $s1, $a0, 2      # $s1 = N (2-4)
    li   $s2, 0            # $s2 = i (contador)
bucle_rojos:
    bge  $s2, $s1, fin_bucle_rojos
find_spot_rojo:
    li   $v0, 42
    li   $a1, 222
    syscall
    addi $a0, $a0, 18
    add  $t6, $t0, $a0     
    lb   $t5, 0($t6)       
    bne  $t5, $zero, find_spot_rojo 
    li   $t5, 6
    sb   $t5, 0($t6)
    addi $s2, $s2, 1
    j    bucle_rojos
fin_bucle_rojos:
    # --- FIN DE LA CONFIGURACIÓN ---


# --- BUCLE PRINCIPAL DEL JUEGO ---
game_loop:

    # --- 1. DIBUJAR LA PANTALLA ---
    la   $t0, mapa_pacman
    li   $t2, 0x10010000
    la   $t1, paleta_colores
    li   $t3, 0                # i = 0
    li   $t4, 256              # Límite = 256
draw_loop_inner:
    bge  $t3, $t4, end_draw_loop_inner
    lb   $t5, 0($t0)           
    sll  $t6, $t5, 2           
    add  $t6, $t6, $t1         
    lw   $t7, 0($t6)           
    sw   $t7, 0($t2)           
    addi $t0, $t0, 1          
    addi $t2, $t2, 4          
    addi $t3, $t3, 1          
    j    draw_loop_inner
end_draw_loop_inner:

    # --- 2. REVISAR TECLADO (Syscall 12) ---
    li   $v0, 12           # Syscall: Leer Carácter
    syscall                # El programa SE DETIENE aquí
    move $t4, $v0          # $t4 = tecla

    # --- 3. ACTUALIZAR JUEGO (Comprobar W, A, S, D) ---
    # $t5 = el desplazamiento (offset) a usar
    
    li   $t7, 119          # ASCII 'w'
    beq  $t4, $t7, set_move_w
    
    li   $t7, 97           # ASCII 'a'
    beq  $t4, $t7, set_move_a
    
    li   $t7, 115          # ASCII 's'
    beq  $t4, $t7, set_move_s
    
    li   $t7, 100          # ASCII 'd'
    beq  $t4, $t7, set_move_d
    
    # Ninguna tecla válida, volver a dibujar
    j    no_input

set_move_w:
    li   $t5, -16          # Desplazamiento = -16 (Arriba)
    j    perform_move
set_move_a:
    li   $t5, -1           # Desplazamiento = -1 (Izquierda)
    j    perform_move
set_move_s:
    li   $t5, 16           # Desplazamiento = +16 (Abajo)
    j    perform_move
set_move_d:
    li   $t5, 1            # Desplazamiento = +1 (Derecha)
    j    perform_move

perform_move:
    # $s0 = pos_actual_indice
    # $t5 = desplazamiento
    add  $t6, $s0, $t5         # $t6 = nueva_pos = pos_actual + desplazamiento
    
    # Comprobar si la nueva_pos es negra (0)
    la   $t0, mapa_pacman      # Recargar base del mapa
    add  $t7, $t0, $t6         # $t7 = &mapa_pacman[nueva_pos]
    lb   $t8, 0($t7)           # $t8 = valor en mapa_pacman[nueva_pos]
    
    bne  $t8, $zero, no_input  # Si no es negro (0), choca con pared
    
    # --- Movimiento Válido ---
    # 1. Poner 0 (Negro) en la posición ANTIGUA
    add  $t7, $t0, $s0         # $t7 = &mapa_pacman[pos_actual]
    sb   $zero, 0($t7)
    
    # 2. Poner 2 (Blanco) en la posición NUEVA
    li   $t5, 2                # 2 = Blanco
    add  $t7, $t0, $t6         # $t7 = &mapa_pacman[nueva_pos]
    sb   $t5, 0($t7)
    
    # 3. Actualizar la posición guardada de Pac-Man
    move $s0, $t6

no_input:
    j    game_loop             # Repetir el bucle del juego
    
# --- Fin del programa (nunca se alcanza) ---
done:
    li   $v0, 10
    syscall