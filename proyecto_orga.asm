.data
display: .space 1024
paleta_colores:
    .word 0xFF000000  # Índice 0: Negro (Camino)
    .word 0xFF0000FF  # Índice 1: Azul (Pared)
    .word 0xFFFFFFFF  # Índice 2: Blanco (Punto 1)
    .word 0xFFFF00FF  # Índice 3: Fucsia (Punto 2)
    .word 0xFF800080  # Índice 4: Morado (Punto 3)

# --- MAPA OPTIMIZADO (Y CORREGIDO) ---
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
    la   $t0, mapa_pacman      # $t0 = Puntero al inicio del mapa (.byte)
    la   $t1, paleta_colores   # $t1 = Puntero al inicio de la paleta (.word)
    li   $t2, 0x10010000       # $t2 = Puntero al inicio del display (.word)

    # --- CÓDIGO NUEVO (Búsqueda para 3 puntos) ---

    # --- 1. BUSCAR LUGAR PARA PUNTO BLANCO (Índice 2) ---
find_spot_blanco:
    li   $v0, 42
    li   $a1, 222          # Rango 0-221
    syscall
    addi $a0, $a0, 18    # Índice 18-239
    
    add  $t6, $t0, $a0     # $t6 = &mapa_pacman[índice_aleatorio]
    lb   $t5, 0($t6)       # $t5 = valor en esa celda (0, 1, etc.)
    
    # Si no es 0 (Negro), vuelve a intentarlo
    bne  $t5, $zero, find_spot_blanco 

    # Encontrado: Guardar 2 (Blanco)
    li   $t5, 2
    sb   $t5, 0($t6)

    # --- 2. BUSCAR LUGAR PARA PUNTO FUCSIA (Índice 3) ---
find_spot_fucsia:
    li   $v0, 42
    li   $a1, 222          # Rango 0-221
    syscall
    addi $a0, $a0, 18    # Índice 18-239
    
    add  $t6, $t0, $a0     # $t6 = &mapa_pacman[índice_aleatorio]
    lb   $t5, 0($t6)       # $t5 = valor en esa celda
    
    # Si no es 0 (Negro), vuelve a intentarlo
    # (Fallará si cae en Pared, o en el Punto Blanco)
    bne  $t5, $zero, find_spot_fucsia 

    # Encontrado: Guardar 3 (Fucsia)
    li   $t5, 3
    sb   $t5, 0($t6)

    # --- 3. BUSCAR LUGAR PARA PUNTO MORADO (Índice 4) ---
find_spot_morado:
    li   $v0, 42
    li   $a1, 222          # Rango 0-221
    syscall
    addi $a0, $a0, 18    # Índice 18-239
    
    add  $t6, $t0, $a0     # $t6 = &mapa_pacman[índice_aleatorio]
    lb   $t5, 0($t6)       # $t5 = valor en esa celda
    
    # Si no es 0 (Negro), vuelve a intentarlo
    # (Fallará en Paredes, Blanco, y Fucsia)
    bne  $t5, $zero, find_spot_morado 

    # Encontrado: Guardar 4 (Morado)
    li   $t5, 4
    sb   $t5, 0($t6)
    # --- FIN CÓDIGO NUEVO ---


    # --- Configuración del Bucle de Dibujo ---
    li   $t3, 0                # $t3 = i (contador de 0 a 255)
    li   $t4, 256              # $t4 = Límite (total de unidades 16x16)

draw_loop:
    # Salir del bucle si (i >= 256)
    bge  $t3, $t4, done

    # 1. Obtener el tipo de celda (0, 1, 2, 3, o 4) del mapa
    lb   $t5, 0($t0)           # Carga el byte desde la dirección en $t0

    # 2. Obtener el color de la paleta
    sll  $t6, $t5, 2           # $t6 = tipo * 4
    add  $t6, $t6, $t1         # $t6 = dirección de &paleta_colores[tipo]
    lw   $t7, 0($t6)           # $t7 = Carga el color (word)

    # 3. Escribir el color en el display
    sw   $t7, 0($t2)           # Guarda el color en la memoria del display

    # 4. Avanzar los punteros y el contador
    addi $t0, $t0, 1          # Avanza el puntero del mapa 1 byte
    addi $t2, $t2, 4          # Avanza el puntero del display 1 word (4 bytes)
    addi $t3, $t3, 1          # i++
    
    # Repetir
    j    draw_loop

done:
    # --- Fin del programa ---
    li   $v0, 10
    syscall