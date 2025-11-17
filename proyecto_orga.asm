.data
display: .space 1024
paleta_colores:
    .word 0xFF000000  # Índice 0: Negro (Camino)
    .word 0xFF0000FF  # Índice 1: Azul (Pared)
    .word 0xFFFFFFFF  # Índice 2: Blanco (El punto)

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

    # --- CÓDIGO NUEVO (Bucle de búsqueda de 0) ---
    # Este bucle se repetirá hasta que encuentre un
    # índice aleatorio (18-239) que contenga un 0.
find_spot_loop:
    # 1. Generar índice aleatorio (18-239)
    li   $v0, 42           # $v0 = 42 (syscall Random Int Range)
    li   $a1, 222          # $a1 = El TAMAÑO del rango (240 - 18 = 222)
    syscall                # $a0 ahora tiene el índice aleatorio (0-221)
    addi $a0, $a0, 18    # $a0 = (resultado 0-221) + 18 = 18-239

    # 2. Obtener la dirección y el valor en ese índice
    #    $t6 = &mapa_pacman[índice_aleatorio]
    add  $t6, $t0, $a0     
    lb   $t5, 0($t6)       # $t5 = valor en esa celda (0 o 1)

    # 3. Comprobar si NO es negro (0)
    #    Si $t5 no es igual a 0, vuelve a intentarlo
    bne  $t5, $zero, find_spot_loop 

# --- FIN DEL BUCLE: Hemos encontrado un 0 ---
# $t6 todavía tiene la dirección del '0' que encontramos

    # 4. Colocar el punto blanco (2)
    li   $t5, 2            # $t5 = 2 (el índice para Blanco)
    sb   $t5, 0($t6)       # Guardar 2 en esa dirección
    # --- FIN CÓDIGO NUEVO ---


    # --- Configuración del Bucle ---
    li   $t3, 0                # $t3 = i (contador de 0 a 255)
    li   $t4, 256              # $t4 = Límite (total de unidades 16x16)

draw_loop:
    # Salir del bucle si (i >= 256)
    bge  $t3, $t4, done

    # 1. Obtener el tipo de celda (0, 1, o 2) del mapa
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