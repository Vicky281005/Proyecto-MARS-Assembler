.data
display: .space 1024
paleta_colores:
    .word 0xFF000000  # 0: Negro
    .word 0xFF0000FF  # 1: Azul
    .word 0xFFFFFFFF  # 2: Blanco (Pac-Man)
    .word 0xFFFF00FF  # 3: Fucsia
    .word 0xFF800080  # 4: Morado
    .word 0xFFFFFF00  # 5: Amarillo
    .word 0xFFFF0000  # 6: Rojo (Fantasma / Game Over)

# --- NUEVA MATRIZ PARA GAME OVER ---
# Dibuja "GAME OVER" con 6s (Rojo)
game_over_map:
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,6,6,6,0,6,6,6,0,6,6,6,0,6,6,0
    .byte 0,6,0,0,0,6,0,6,0,6,6,6,0,6,0,0
    .byte 0,6,0,0,0,6,6,6,0,6,0,6,0,6,6,0
    .byte 0,6,0,6,0,6,0,6,0,6,0,6,0,6,0,0
    .byte 0,6,6,6,0,6,0,6,0,6,0,6,0,6,6,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,6,6,6,0,6,0,6,0,6,6,0,6,6,6,0
    .byte 0,6,0,6,0,6,0,6,0,6,0,0,6,0,6,0
    .byte 0,6,0,6,0,6,0,6,0,6,6,0,6,6,6,0
    .byte 0,6,0,6,0,6,0,6,0,6,0,0,6,6,0,0
    .byte 0,6,6,6,0,0,6,0,0,6,6,0,6,0,6,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

# Almacenamiento para los Fantasmas
num_red_dots: .word 0
red_dot_positions: .space 16  # Max 4 fantasmas
red_dot_underneath: .space 4   # Max 4 fantasmas

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
    # --- Cargar Dirección Base ---
    la   $t0, mapa_pacman

    # --- 1. BUSCAR LUGAR PARA PUNTO BLANCO (Índice 2) ---
find_spot_blanco:
    # ... (código de setup para blanco) ...
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
    # ... (código para fucsia) ...
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
    # ... (código para morado) ...
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
    # ... (código para amarillos) ...
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
    # ... (código para rojos) ...
    li   $v0, 42
    li   $a1, 3            
    syscall
    addi $s1, $a0, 2      # $s1 = N (2-4)
    la   $s3, num_red_dots
    sw   $s1, 0($s3)
    li   $s2, 0            # $s2 = i (contador)
    la   $s4, red_dot_positions
    la   $s7, red_dot_underneath 
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
    
    sll  $t7, $s2, 2       
    add  $t8, $s4, $t7     
    sw   $a0, 0($t8)
    
    add  $t8, $s7, $s2     
    sb   $zero, 0($t8)     
    
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
    li   $t3, 0
    li   $t4, 256
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
    li   $v0, 12
    syscall
    move $t4, $v0          # $t4 = tecla

    # --- 3. MOVER FANTASMAS (PUNTOS ROJOS) ---
    la   $s3, num_red_dots
    lw   $s3, 0($s3)       # $s3 = N (número de fantasmas)
    li   $s5, 0            # $s5 = i (contador)
    la   $s4, red_dot_positions
    la   $s7, red_dot_underneath
red_dot_outer_loop:
    bge  $s5, $s3, end_red_dot_loop # Si (i >= N), terminar
    
    sll  $t7, $s5, 2       
    add  $t8, $s4, $t7     
    lw   $s6, 0($t8)       # $s6 = índice de pos_actual del fantasma

red_dot_inner_loop:
    li   $v0, 42
    li   $a1, 4
    syscall                # $a0 = 0, 1, 2, o 3
    
    beq  $a0, $zero, set_move_up_red
    li   $t7, 1
    beq  $a0, $t7, set_move_down_red
    li   $t7, 2
    beq  $a0, $t7, set_move_left_red
set_move_right_red:
    li   $t5, 1
    j    check_red_move
set_move_up_red:
    li   $t5, -16
    j    check_red_move
set_move_down_red:
    li   $t5, 16
    j    check_red_move
set_move_left_red:
    li   $t5, -1

check_red_move:
    add  $t6, $s6, $t5     # $t6 = nueva_pos
    
    la   $t0, mapa_pacman
    add  $t7, $t0, $t6     
    lb   $t9, 0($t7)       # $t9 = valor en mapa_pacman[nueva_pos]
    
    # --- ¡¡LÓGICA DE COLISIÓN DEL FANTASMA!! ---
    # Si choca con Pac-Man (2), GAME OVER
    li   $t7, 2
    beq  $t9, $t7, game_over
    
    # Si NO es negro (0), vuelve a intentarlo
    bne  $t9, $zero, red_dot_inner_loop

    # --- Movimiento Válido (a un '0') ---
    add  $s1, $s7, $s5     
    lb   $t5, 0($s1)       
    add  $t7, $t0, $s6     
    sb   $t5, 0($t7)       
    sb   $t9, 0($s1)       
    li   $t5, 6
    add  $t7, $t0, $t6     
    sb   $t5, 0($t7)
    sw   $t6, 0($t8)       
    
    addi $s5, $s5, 1      # i++
    j    red_dot_outer_loop
end_red_dot_loop:

    # --- 4. ACTUALIZAR JUEGO (Comprobar W, A, S, D) ---
    li   $t7, 119          # ASCII 'w'
    beq  $t4, $t7, set_move_w
    li   $t7, 97           # ASCII 'a'
    beq  $t4, $t7, set_move_a
    li   $t7, 115          # ASCII 's'
    beq  $t4, $t7, set_move_s
    li   $t7, 100          # ASCII 'd'
    beq  $t4, $t7, set_move_d
    j    no_input

set_move_w:
    li   $t5, -16
    j    perform_move
set_move_a:
    li   $t5, -1
    j    perform_move
set_move_s:
    li   $t5, 16
    j    perform_move
set_move_d:
    li   $t5, 1
    
perform_move:
    add  $t6, $s0, $t5         # $t6 = nueva_pos
    la   $t0, mapa_pacman
    add  $t7, $t0, $t6         # $t7 = &mapa_pacman[nueva_pos]
    lb   $t8, 0($t7)           # $t8 = valor en mapa_pacman[nueva_pos]
    
    # --- ¡¡LÓGICA DE COLISIÓN DEL JUGADOR!! ---
    li   $t9, 1
    beq  $t8, $t9, no_input    # Si es pared (1), chocar
    
    # Si choca con Fantasma (6), GAME OVER
    li   $t9, 6
    beq  $t8, $t9, game_over
    
    # --- Movimiento Válido del Jugador ---
    add  $t7, $t0, $s0         # $t7 = &mapa_pacman[pos_actual]
    sb   $zero, 0($t7)
    li   $t5, 2
    add  $t7, $t0, $t6         # $t7 = &mapa_pacman[nueva_pos]
    sb   $t5, 0($t7)
    move $s0, $t6

no_input:
    j    game_loop
    
# --- NUEVA SECCIÓN DE GAME OVER ---
game_over:
    # Dibuja la pantalla de "Game Over" una vez
    la   $t0, game_over_map
    li   $t2, 0x10010000
    la   $t1, paleta_colores
    li   $t3, 0                # i = 0
    li   $t4, 256              # Límite = 256
game_over_draw_loop:
    bge  $t3, $t4, done      # Ir a 'done' (salir) cuando termine
    lb   $t5, 0($t0)           
    sll  $t6, $t5, 2           
    add  $t6, $t6, $t1         
    lw   $t7, 0($t6)           
    sw   $t7, 0($t2)           
    addi $t0, $t0, 1          
    addi $t2, $t2, 4          
    addi $t3, $t3, 1          
    j    game_over_draw_loop

done:
    # --- Fin del programa ---
    li   $v0, 10
    syscall
