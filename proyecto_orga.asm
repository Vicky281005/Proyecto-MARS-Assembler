.data
# --- IMPORTANTE: LA PANTALLA DEBE IR PRIMERO ---
# Al poner esto al inicio, aseguramos que 'display' esté en la dirección 0x10010000
# Esto hace que coincida con la configuración por defecto del Bitmap Display.
display: .space 1024   

# Paleta de colores (inmediatamente después para mantener alineación)
paleta_colores:
    .word 0xFF000000  # 0: Negro
    .word 0xFF0000FF  # 1: Azul
    .word 0xFFFFFFFF  # 2: Blanco (Pac-Man)
    .word 0xFFFF00FF  # 3: Fucsia (Meta)
    .word 0xFF800080  # 4: Morado (Teleport)
    .word 0xFFFFFF00  # 5: Amarillo (Moneda)
    .word 0xFFFF0000  # 6: Rojo (Fantasma / Game Over)
    .word 0xFF00FF00  # 7: Verde (Color de Victoria)

# --- VARIABLES Y TEXTOS (Ahora van después) ---
player_score: .word 0
msg_score:    .asciiz "\nPuntos: "
msg_hex:      .asciiz "Hex: 0x" 
newline:      .asciiz "\n"

# --- MATRIZ DE GAME OVER ---
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

# --- MATRIZ DE VICTORIA ---
you_win_map:
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,0,7,0,7,0,7,7,7,0,7,0,7,0,0,0
    .byte 0,0,7,0,7,0,7,0,7,0,7,0,7,0,0,0
    .byte 0,0,7,0,7,0,7,0,7,0,7,0,7,0,0,0
    .byte 0,0,0,7,0,0,7,0,7,0,7,0,7,0,0,0
    .byte 0,0,0,7,0,0,7,7,7,0,7,7,7,0,0,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,7,0,7,0,7,7,7,0,7,0,7,0,7,0,0
    .byte 0,7,0,7,0,0,7,0,0,7,7,7,0,7,0,0
    .byte 0,7,7,7,0,0,7,0,0,7,0,7,0,7,0,0
    .byte 0,7,0,7,0,7,7,7,0,7,0,7,0,7,0,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

# Almacenamiento para los Fantasmas
num_red_dots: .word 0
red_dot_positions: .space 16  
red_dot_underneath: .space 4   

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
    la   $t0, mapa_pacman

    # --- 1. BUSCAR LUGAR PARA PUNTO BLANCO ---
find_spot_blanco:
    li   $v0, 42
    li   $a1, 222
    syscall
    addi $a0, $a0, 18
    add  $t6, $t0, $a0      
    lb   $t5, 0($t6)        
    bne  $t5, $zero, find_spot_blanco 
    move $s0, $a0          
    li   $t5, 2
    sb   $t5, 0($t6)

    # --- 2. BUSCAR LUGAR PARA PUNTO FUCSIA ---
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

    # --- 3. BUSCAR LUGAR PARA PUNTO MORADO ---
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

    # --- 4. GENERAR PUNTOS AMARILLOS ---
    li   $v0, 42
    li   $a1, 4             
    syscall
    addi $s1, $a0, 3       
    li   $s2, 0            
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

    # --- 5. GENERAR PUNTOS ROJOS ---
    li   $v0, 42
    li   $a1, 3             
    syscall
    addi $s1, $a0, 2       
    la   $s3, num_red_dots
    sw   $s1, 0($s3)
    li   $s2, 0            
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

    li   $s2, 0        # Reset Score

# --- BUCLE PRINCIPAL DEL JUEGO ---
game_loop:
    # --- DIBUJAR LA PANTALLA ---
    la   $t0, mapa_pacman
    
    # AQUI ESTA EL TRUCO: Al mover display al inicio del .data,
    # 'la $t2, display' ahora apuntará a 0x10010000
    la   $t2, display       
    
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

    # --- IMPRIMIR PUNTUACIÓN ---
    la   $a0, msg_score
    li   $v0, 4
    syscall
    
    move $a0, $s2
    li   $v0, 1
    syscall
    
    la   $a0, newline
    li   $v0, 4
    syscall
    
    la   $a0, msg_hex
    li   $v0, 4
    syscall
    
    # --- HEX LOOP 1 ---
    move $t8, $s2        
    li   $t9, 28         
hex_loop_1:
    srlv $a0, $t8, $t9   
    andi $a0, $a0, 0xF   
    
    slti $t1, $a0, 10      
    bne  $t1, $zero, print_digit_1 
    addi $a0, $a0, 7       

print_digit_1:
    addi $a0, $a0, 48      
    li   $v0, 11           
    syscall
    
    subi $t9, $t9, 4
    bge  $t9, $zero, hex_loop_1
    
    la   $a0, newline
    li   $v0, 4
    syscall

    # --- KEYBOARD INPUT ---
    li   $v0, 12
    syscall
    move $t4, $v0          

    # --- MOVEMENT LOGIC ---
    li   $t7, 119          # w
    beq  $t4, $t7, set_move_w
    li   $t7, 97           # a
    beq  $t4, $t7, set_move_a
    li   $t7, 115          # s
    beq  $t4, $t7, set_move_s
    li   $t7, 100          # d
    beq  $t4, $t7, set_move_d
    j    move_ghosts       

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
    add  $t6, $s0, $t5         
    la   $t0, mapa_pacman
    add  $t7, $t0, $t6         
    lb   $t8, 0($t7)           
    
    li   $t9, 1
    beq  $t8, $t9, move_ghosts 
    
    li   $t9, 3
    beq  $t8, $t9, you_win     
    
    li   $t9, 4
    bne  $t8, $t9, check_coin 
    add  $t7, $t0, $s0         
    sb   $zero, 0($t7)
find_teleport_spot:
    li   $v0, 42
    li   $a1, 256
    syscall
    add  $t7, $t0, $a0         
    lb   $t9, 0($t7)           
    bne  $t9, $zero, find_teleport_spot 
    li   $t5, 2
    sb   $t5, 0($t7)
    move $s0, $a0             
    j    move_ghosts
    
check_coin:
    li   $t9, 5                
    bne  $t8, $t9, normal_move 
    
    li   $a0, 10
    li   $v0, 1
    syscall
    
    la   $a0, newline       
    li   $v0, 4
    syscall

    addi $s2, $s2, 10         
            
normal_move:
    la   $t0, mapa_pacman   
    add  $t7, $t0, $s0         
    sb   $zero, 0($t7)      
    li   $t5, 2
    add  $t7, $t0, $t6         
    sb   $t5, 0($t7)        
    move $s0, $t6           

    # --- PLAYER-GHOST COLLISION 1 ---
check_collision_after_player:
    la   $s3, num_red_dots
    lw   $s3, 0($s3)        
    li   $s5, 0             
    la   $s4, red_dot_positions
    
check_loop_1:
    bge  $s5, $s3, move_ghosts 
    
    sll  $t7, $s5, 2
    add  $t8, $s4, $t7
    lw   $s6, 0($t8)        
    beq  $s0, $s6, game_over 
    
    addi $s5, $s5, 1        
    j    check_loop_1

move_ghosts:
    la   $s3, num_red_dots
    lw   $s3, 0($s3)       
    li   $s5, 0            
    la   $s4, red_dot_positions
    la   $s7, red_dot_underneath
red_dot_outer_loop:
    bge  $s5, $s3, check_collisions_2 
    
    sll  $t7, $s5, 2        
    add  $t8, $s4, $t7      
    lw   $s6, 0($t8)       
    
    li   $s1, 0
    la   $t0, mapa_pacman
    
found_move:
red_dot_inner_loop:
    li   $v0, 42
    li   $a1, 4
    syscall
    
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
    add  $t6, $s6, $t5     
    la   $t0, mapa_pacman
    add  $t7, $t0, $t6     
    lb   $t9, 0($t7)       
    
    beq  $t9, $zero, do_ghost_move
    li   $t1, 2
    beq  $t9, $t1, do_ghost_move
    j    red_dot_inner_loop

do_ghost_move:
    add  $s1, $s7, $s5     
    lb   $t5, 0($s1)       
    add  $t7, $t0, $s6     
    sb   $t5, 0($t7)       
    
    sb   $t9, 0($s1)       
    li   $t5, 6
    add  $t7, $t0, $t6     
    sb   $t5, 0($t7)       
    sw   $t6, 0($t8)       
    
next_ghost:
    addi $s5, $s5, 1      
    j    red_dot_outer_loop
end_red_dot_loop:

    # --- PLAYER-GHOST COLLISION 2 ---
check_collisions_2:
    la   $s3, num_red_dots
    lw   $s3, 0($s3)       
    li   $s5, 0            
    la   $s4, red_dot_positions
check_collision_loop_2:
    bge  $s5, $s3, no_collision 
    
    sll  $t7, $s5, 2
    add  $t8, $s4, $t7
    lw   $s6, 0($t8)       
    beq  $s0, $s6, game_over 
    
    addi $s5, $s5, 1      
    j    check_collision_loop_2

no_collision:
    j    game_loop
    
# --- SECCIÓN DE GAME OVER ---
game_over:
    la   $t0, game_over_map
    la   $t2, display
    la   $t1, paleta_colores
    li   $t3, 0
    li   $t4, 256
game_over_draw_loop:
    bge  $t3, $t4, done
    lb   $t5, 0($t0)            
    sll  $t6, $t5, 2            
    add  $t6, $t6, $t1          
    lw   $t7, 0($t6)            
    sw   $t7, 0($t2)            
    addi $t0, $t0, 1            
    addi $t2, $t2, 4            
    addi $t3, $t3, 1            
    j    game_over_draw_loop

# --- SECCIÓN DE VICTORIA ---
you_win:
    la   $a0, msg_score
    li   $v0, 4
    syscall
    
    move $a0, $s2
    li   $v0, 1
    syscall
    
    la   $a0, newline
    li   $v0, 4
    syscall

    la   $a0, msg_hex
    li   $v0, 4
    syscall
    
    # --- HEX LOOP 2 ---
    move $t8, $s2
    li   $t9, 28
hex_loop_2:
    srlv $a0, $t8, $t9
    andi $a0, $a0, 0xF
    
    slti $t1, $a0, 10
    bne  $t1, $zero, print_digit_2
    addi $a0, $a0, 7

print_digit_2:
    addi $a0, $a0, 48
    li   $v0, 11
    syscall
    
    subi $t9, $t9, 4
    bge  $t9, $zero, hex_loop_2
    
    la   $a0, newline
    li   $v0, 4
    syscall

    la   $t0, you_win_map
    la   $t2, display
    la   $t1, paleta_colores
    li   $t3, 0
    li   $t4, 256
you_win_draw_loop:
    bge  $t3, $t4, done
    lb   $t5, 0($t0)            
    sll  $t6, $t5, 2            
    add  $t6, $t6, $t1          
    lw   $t7, 0($t6)            
    sw   $t7, 0($t2)            
    addi $t0, $t0, 1            
    addi $t2, $t2, 4            
    addi $t3, $t3, 1            
    j    you_win_draw_loop

done:
    li   $v0, 10
    syscall