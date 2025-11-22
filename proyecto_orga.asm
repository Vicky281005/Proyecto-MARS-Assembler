.data
# --- IMPORTANTE: LA MEMORIA DE VIDEO DEBE IR PRIMERO ---
# Al poner esto al inicio, aseguramos que 'pantalla' esté en la dirección base (0x10010000)
pantalla: .space 1024   

# Paleta de colores 
paleta_colores:
    .word 0xFF000000  # 0: Negro
    .word 0xFF0000FF  # 1: Azul
    .word 0xFFFFFFFF  # 2: Blanco (Jugador / Pac-Man)
    .word 0xFFFF00FF  # 3: Fucsia (Meta)
    .word 0xFF800080  # 4: Morado (Teletransporte)
    .word 0xFFFFFF00  # 5: Amarillo (Moneda)
    .word 0xFFFF0000  # 6: Rojo (Fantasma / Game Over)
    .word 0xFF00FF00  # 7: Verde (Color de Victoria)

# --- VARIABLES Y TEXTOS ---
puntaje_jugador: .word 0
msj_victoria:    .asciiz "\nYOU WIN\n"     # Mensaje solicitado
msj_fin_juego:   .asciiz "\nGAME OVER\n"   # Mensaje solicitado
msj_dec:         .asciiz "Dec: " 
msj_hex:         .asciiz "Hex: 0x" 
msj_oct:         .asciiz "Oct: 0o"
msj_bin:         .asciiz "Bin: 0b"
salto_linea:     .asciiz "\n"

# --- MATRIZ DE GAME OVER (Píxeles del dibujo de derrota) ---
mapa_game_over:
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
mapa_victoria:
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,0,7,0,7,0,7,7,7,0,7,0,7,0,0,0
    .byte 0,0,7,0,7,0,7,0,7,0,7,0,7,0,0,0
    .byte 0,0,7,0,7,0,7,0,7,0,7,0,7,0,0,0
    .byte 0,0,0,7,0,0,7,0,7,0,7,0,7,0,0,0
    .byte 0,0,0,7,0,0,7,7,7,0,7,7,7,0,0,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,7,0,7,0,7,7,7,0,7,0,0,7,0,0,0
    .byte 0,7,0,7,0,0,7,0,0,7,7,0,7,0,0,0
    .byte 0,7,0,7,0,0,7,0,0,7,0,7,7,0,0,0
    .byte 0,7,7,7,0,0,7,0,0,7,0,0,7,0,0,0
    .byte 0,7,7,7,0,7,7,7,0,7,0,0,7,0,0,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
# --- DATOS DE LOS FANTASMAS ---
num_fantasmas:      .word 0
pos_fantasmas:      .space 16  # Guarda la posición (índice) de hasta 4 fantasmas
item_bajo_fantasma: .space 4   # Guarda qué había debajo del fantasma (para restaurarlo al moverse)

# --- MAPA DEL NIVEL ---
# 1=Pared, 0=Camino
mapa_juego:
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
    la   $t0, mapa_juego

    # --- 1. BUSCAR LUGAR PARA EL JUGADOR (Blanco - ID 2) ---
buscar_sitio_blanco:
    li   $v0, 42            # Random int range
    li   $a1, 222
    syscall
    addi $a0, $a0, 18
    add  $t6, $t0, $a0      
    lb   $t5, 0($t6)        
    bne  $t5, $zero, buscar_sitio_blanco # Si no es 0 (camino libre), buscar otro
    move $s0, $a0           # $s0 guarda la posición del jugador
    li   $t5, 2
    sb   $t5, 0($t6)

    # --- 2. BUSCAR LUGAR PARA LA META (Fucsia - ID 3) ---
buscar_sitio_fucsia:
    li   $v0, 42
    li   $a1, 222
    syscall
    addi $a0, $a0, 18
    add  $t6, $t0, $a0      
    lb   $t5, 0($t6)        
    bne  $t5, $zero, buscar_sitio_fucsia 
    li   $t5, 3
    sb   $t5, 0($t6)

    # --- 3. BUSCAR LUGAR PARA EL TELETRANSPORTE (Morado - ID 4) ---
buscar_sitio_morado:
    li   $v0, 42
    li   $a1, 222
    syscall
    addi $a0, $a0, 18
    add  $t6, $t0, $a0      
    lb   $t5, 0($t6)        
    bne  $t5, $zero, buscar_sitio_morado 
    li   $t5, 4
    sb   $t5, 0($t6)

    # --- 4. GENERAR PUNTOS AMARILLOS (Monedas - ID 5) ---
    li   $v0, 42
    li   $a1, 4             
    syscall
    addi $s1, $a0, 3        # Generar entre 3 y 6 monedas
    li   $s2, 0             # Contador
bucle_monedas:
    bge  $s2, $s1, fin_bucle_monedas
buscar_sitio_amarillo:
    li   $v0, 42
    li   $a1, 222
    syscall
    addi $a0, $a0, 18
    add  $t6, $t0, $a0      
    lb   $t5, 0($t6)        
    bne  $t5, $zero, buscar_sitio_amarillo 
    li   $t5, 5
    sb   $t5, 0($t6)
    addi $s2, $s2, 1
    j    bucle_monedas
fin_bucle_monedas:

    # --- 5. GENERAR FANTASMAS (Rojos - ID 6) ---
    li   $v0, 42
    li   $a1, 3             
    syscall
    addi $s1, $a0, 2        # Generar entre 2 y 4 fantasmas
    la   $s3, num_fantasmas
    sw   $s1, 0($s3)
    li   $s2, 0             # Contador
    la   $s4, pos_fantasmas
    la   $s7, item_bajo_fantasma 
bucle_rojos:
    bge  $s2, $s1, fin_bucle_rojos
buscar_sitio_rojo:
    li   $v0, 42
    li   $a1, 222
    syscall
    addi $a0, $a0, 18
    add  $t6, $t0, $a0      
    lb   $t5, 0($t6)        
    bne  $t5, $zero, buscar_sitio_rojo 
    
    sll  $t7, $s2, 2        
    add  $t8, $s4, $t7      
    sw   $a0, 0($t8)        # Guardar posición en array
    
    add  $t8, $s7, $s2      
    sb   $zero, 0($t8)      # Inicializar "item debajo" como 0 (camino vacío)
    
    li   $t5, 6
    sb   $t5, 0($t6)        # Pintarlo en el mapa
    addi $s2, $s2, 1
    j    bucle_rojos
fin_bucle_rojos:

    li   $s2, 0        # Reiniciar puntaje del jugador para empezar

# --- BUCLE PRINCIPAL DEL JUEGO ---
bucle_juego:
    # --- DIBUJAR LA PANTALLA ---
    la   $t0, mapa_juego
    la   $t2, pantalla      # Dirección de memoria de video
    la   $t1, paleta_colores
    li   $t3, 0
    li   $t4, 256
bucle_dibujo:
    bge  $t3, $t4, fin_bucle_dibujo
    lb   $t5, 0($t0)            # Leer ID del mapa
    sll  $t6, $t5, 2            # Multiplicar por 4
    add  $t6, $t6, $t1          # Buscar color en paleta
    lw   $t7, 0($t6)            # Cargar color HEX
    sw   $t7, 0($t2)            # Pintar en pantalla
    addi $t0, $t0, 1            
    addi $t2, $t2, 4            
    addi $t3, $t3, 1            
    j    bucle_dibujo
fin_bucle_dibujo:

    # --- ENTRADA DE TECLADO ---
    li   $v0, 12            # Syscall leer char
    syscall
    move $t4, $v0           # Guardar tecla en $t4

    # --- LÓGICA DE MOVIMIENTO ---
    li   $t7, 119           # Tecla 'w'
    beq  $t4, $t7, mover_w
    li   $t7, 97            # Tecla 'a'
    beq  $t4, $t7, mover_a
    li   $t7, 115           # Tecla 's'
    beq  $t4, $t7, mover_s
    li   $t7, 100           # Tecla 'd'
    beq  $t4, $t7, mover_d
    j    mover_fantasmas    # Si no es WASD, saltar movimiento jugador

mover_w:
    li   $t5, -16
    j    ejecutar_movimiento
mover_a:
    li   $t5, -1
    j    ejecutar_movimiento
mover_s:
    li   $t5, 16
    j    ejecutar_movimiento
mover_d:
    li   $t5, 1
    
ejecutar_movimiento:
    add  $t6, $s0, $t5          # Calcular nueva posición
    la   $t0, mapa_juego
    add  $t7, $t0, $t6          # Dirección memoria nueva pos
    lb   $t8, 0($t7)            # Leer qué hay en la nueva posición
    
    li   $t9, 1
    beq  $t8, $t9, mover_fantasmas # Si es pared (1), choca y no se mueve
    
    li   $t9, 3
    beq  $t8, $t9, victoria     # Si es Meta (3), GANASTE
    
    li   $t9, 4
    bne  $t8, $t9, verificar_moneda 
    
    # Lógica de Teletransporte
    add  $t7, $t0, $s0         
    sb   $zero, 0($t7)          # Borrar jugador de posición actual
buscar_sitio_teleport:
    li   $v0, 42
    li   $a1, 256
    syscall
    add  $t7, $t0, $a0         
    lb   $t9, 0($t7)           
    bne  $t9, $zero, buscar_sitio_teleport 
    li   $t5, 2
    sb   $t5, 0($t7)            # Poner jugador en sitio random
    move $s0, $a0             
    j    mover_fantasmas
    
verificar_moneda:
    li   $t9, 5                 # 5 = Amarillo (Moneda)
    bne  $t8, $t9, movimiento_normal 
    
    addi $s2, $s2, 10           # Sumar 10 puntos (sin imprimir en consola aun)
            
movimiento_normal:
    la   $t0, mapa_juego    
    add  $t7, $t0, $s0         
    sb   $zero, 0($t7)          # Borrar posición anterior (poner 0)
    li   $t5, 2
    add  $t7, $t0, $t6         
    sb   $t5, 0($t7)            # Poner jugador en nueva posición (poner 2)
    move $s0, $t6               # Actualizar registro de posición

    # --- VERIFICAR COLISIÓN JUGADOR vs FANTASMA (Post-Movimiento) ---
verificar_colision_1:
    la   $s3, num_fantasmas
    lw   $s3, 0($s3)        
    li   $s5, 0             
    la   $s4, pos_fantasmas
    
bucle_chequeo_1:
    bge  $s5, $s3, mover_fantasmas 
    
    sll  $t7, $s5, 2
    add  $t8, $s4, $t7
    lw   $s6, 0($t8)            # Posición del fantasma actual
    beq  $s0, $s6, game_over    # Si jugador y fantasma están en el mismo sitio -> Fin
    
    addi $s5, $s5, 1        
    j    bucle_chequeo_1

mover_fantasmas:
    la   $s3, num_fantasmas
    lw   $s3, 0($s3)       
    li   $s5, 0             
    la   $s4, pos_fantasmas
    la   $s7, item_bajo_fantasma

bucle_fantasmas_ext:
    bge  $s5, $s3, verificar_colision_2 
    
    sll  $t7, $s5, 2        
    add  $t8, $s4, $t7      
    lw   $s6, 0($t8)            # Posición actual del fantasma
    
    li   $s1, 0
    la   $t0, mapa_juego

    li   $t2, 0                 # Contador de seguridad (anti bucle infinito)

buscar_movimiento_fantasma:
bucle_fantasmas_int:
    li   $t3, 15                
    bge  $t2, $t3, sig_fantasma # Si falla 15 veces, saltar este turno
    addi $t2, $t2, 1            

    li   $v0, 42                # Random 0-3
    li   $a1, 4
    syscall
    
    beq  $a0, $zero, fantasma_arriba
    li   $t7, 1
    beq  $a0, $t7, fantasma_abajo
    li   $t7, 2
    beq  $a0, $t7, fantasma_izq
fantasma_der:
    li   $t5, 1
    j    chequear_mov_fantasma
fantasma_arriba:
    li   $t5, -16
    j    chequear_mov_fantasma
fantasma_abajo:
    li   $t5, 16
    j    chequear_mov_fantasma
fantasma_izq:
    li   $t5, -1

chequear_mov_fantasma:
    add  $t6, $s6, $t5          # Nueva posición candidata
    la   $t0, mapa_juego
    add  $t7, $t0, $t6     
    lb   $t9, 0($t7)            # Qué hay ahí
    
    # Fantasma solo se mueve si es Camino (0) o Jugador (2)
    beq  $t9, $zero, ejecutar_mov_fantasma
    li   $t1, 2
    beq  $t9, $t1, ejecutar_mov_fantasma
    j    bucle_fantasmas_int    # Si no, intentar otra dirección

ejecutar_mov_fantasma:
    add  $s1, $s7, $s5     
    lb   $t5, 0($s1)            # Recuperar lo que había DEBAJO del fantasma
    add  $t7, $t0, $s6     
    sb   $t5, 0($t7)            # Restaurarlo en la posición vieja
    
    sb   $t9, 0($s1)            # Guardar lo que hay en la nueva (podría ser 0 o 2)
    li   $t5, 6
    add  $t7, $t0, $t6     
    sb   $t5, 0($t7)            # Poner fantasma en nueva posición
    sw   $t6, 0($t8)            # Actualizar coordenadas en array
    
sig_fantasma:
    addi $s5, $s5, 1      
    j    bucle_fantasmas_ext
fin_bucle_fantasmas:

    # --- VERIFICAR COLISIÓN 2 (Después de mover fantasmas) ---
verificar_colision_2:
    la   $s3, num_fantasmas
    lw   $s3, 0($s3)       
    li   $s5, 0            
    la   $s4, pos_fantasmas
bucle_chequeo_2:
    bge  $s5, $s3, sin_colision 
    
    sll  $t7, $s5, 2
    add  $t8, $s4, $t7
    lw   $s6, 0($t8)       
    beq  $s0, $s6, game_over 
    
    addi $s5, $s5, 1      
    j    bucle_chequeo_2

sin_colision:
    j    bucle_juego
    
# --- SECCIÓN DE DERROTA ---
game_over:
    # IMPRIMIR "GAME OVER"
    la   $a0, msj_fin_juego
    li   $v0, 4
    syscall

    la   $t0, mapa_game_over
    la   $t2, pantalla
    la   $t1, paleta_colores
    li   $t3, 0
    li   $t4, 256
dibujar_game_over:
    bge  $t3, $t4, fin_programa
    lb   $t5, 0($t0)            
    sll  $t6, $t5, 2            
    add  $t6, $t6, $t1          
    lw   $t7, 0($t6)            
    sw   $t7, 0($t2)            
    addi $t0, $t0, 1            
    addi $t2, $t2, 4            
    addi $t3, $t3, 1            
    j    dibujar_game_over

# --- SECCIÓN DE VICTORIA ---
victoria:
    # 0. IMPRIMIR "YOU WIN"
    la   $a0, msj_victoria
    li   $v0, 4
    syscall

    # 1. IMPRIMIR HEXADECIMAL
    la   $a0, msj_hex
    li   $v0, 4
    syscall
    
    move $t8, $s2
    li   $t9, 28
bucle_hex_vic:
    srlv $a0, $t8, $t9
    andi $a0, $a0, 0xF
    
    slti $t1, $a0, 10
    bne  $t1, $zero, imprimir_digito_hex
    addi $a0, $a0, 7

imprimir_digito_hex:
    addi $a0, $a0, 48
    li   $v0, 11
    syscall
    
    subi $t9, $t9, 4
    bge  $t9, $zero, bucle_hex_vic
    
    la   $a0, salto_linea
    li   $v0, 4
    syscall

    # 2. IMPRIMIR DECIMAL
    la   $a0, msj_dec
    li   $v0, 4
    syscall

    move $a0, $s2
    li   $v0, 1       
    syscall

    la   $a0, salto_linea
    li   $v0, 4
    syscall
    
    # 3. IMPRIMIR OCTAL
    la   $a0, msj_oct
    li   $v0, 4
    syscall

    move $t8, $s2
    li   $t9, 30
bucle_oct_vic:
    srlv $a0, $t8, $t9
    andi $a0, $a0, 0x7

    addi $a0, $a0, 48
    li   $v0, 11
    syscall

    subi $t9, $t9, 3
    bge  $t9, $zero, bucle_oct_vic

    la   $a0, salto_linea
    li   $v0, 4
    syscall
    
    # 4. IMPRIMIR BINARIO
    la   $a0, msj_bin
    li   $v0, 4
    syscall

    move $t8, $s2
    li   $t9, 31

bucle_bin_vic:
    srlv $a0, $t8, $t9
    andi $a0, $a0, 1
    
    addi $a0, $a0, 48
    li   $v0, 11
    syscall

    subi $t9, $t9, 1
    bge  $t9, $zero, bucle_bin_vic

    la   $a0, salto_linea
    li   $v0, 4
    syscall
    # ==============================

    # DIBUJAR PANTALLA DE VICTORIA
    la   $t0, mapa_victoria
    la   $t2, pantalla
    la   $t1, paleta_colores
    li   $t3, 0
    li   $t4, 256
dibujar_victoria:
    bge  $t3, $t4, fin_programa
    lb   $t5, 0($t0)            
    sll  $t6, $t5, 2            
    add  $t6, $t6, $t1          
    lw   $t7, 0($t6)            
    sw   $t7, 0($t2)            
    addi $t0, $t0, 1            
    addi $t2, $t2, 4            
    addi $t3, $t3, 1            
    j    dibujar_victoria

fin_programa:
    li   $v0, 10
    syscall