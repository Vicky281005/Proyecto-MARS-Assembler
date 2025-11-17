.data
display: .space 1024
paleta_colores:
    .word 0xFF000000  # Índice 0: Negro (Camino)
    .word 0xFF0000FF  # Índice 1: Azul (Pared)
    # .word 0xFFFFFF00  # (Descomenta esto si añades puntos '2')

# --- MAPA OPTIMIZADO ---
# Ahora usa .byte, ahorrando 768 bytes de espacio
mapa_pacman:
    .byte 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
     1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
     1,0,1,1,0,1,0,1,1,0,1,0,1,1,0,1,
     1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,
     1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1,
     1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
     1,0,1,1,1,1,0,1,1,0,1,1,1,1,0,1,
     1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
     1,1,1,1,1,1,0,1,1,0,1,1,1,1,1,1,
     1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
     1,0,1,1,0,1,1,1,1,1,1,0,1,1,0,1,
     1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
     1,0,1,1,0,1,0,1,1,0,1,0,1,1,0,1,
     1,0,1,1,0,1,0,1,1,0,1,0,1,1,0,1,
     1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,
     1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

.text
.globl main

main:
    # --- Cargar Direcciones Base ---
    la   $t0, mapa_pacman      # $t0 = Puntero al inicio del mapa (.byte)
    la   $t1, paleta_colores   # $t1 = Puntero al inicio de la paleta (.word)
    li   $t2, 0x10010000       # $t2 = Puntero al inicio del display (.word)
    # --- CÓDIGO NUEVO (Lógica Aleatoria - FORMA CORRECTA) ---
    # Reemplazar un byte ALEATORIO (18-239) a 0
    
    li   $v0, 42           # $v0 = 42 (syscall Random Int Range)
    li   $a1, 240          # $a1 = El TAMAÑO del rango (240 - 18 = 222)
                           # Esto nos da un número de 0 a 221
    syscall                # $a0 ahora tiene el índice aleatorio (0-221)
    
    # Desplazar el resultado sumando el límite inferior
    addi $a0, $a0, 18    # $a0 = (resultado 0-221) + 18 = 18-239
    
    # $t0 (base de mapa) + $a0 (índice 18-239)
    add  $t6, $t0, $a0     # $t6 = dirección de &mapa_pacman[índice_aleatorio]
    sb   $zero, 0($t6)     # Guardar 0 en esa dirección
    # --- FIN CÓDIGO NUEVO ---
    # --- Configuración del Bucle ---
    li   $t3, 0                # $t3 = i (contador de 0 a 255)
    li   $t4, 256              # $t4 = Límite (total de unidades 16x16)

draw_loop:
    # Salir del bucle si (i >= 256)
    bge  $t3, $t4, done

    # 1. Obtener el tipo de celda (0 o 1) del mapa
    #    ¡CAMBIO! Usamos lb (Load Byte) en lugar de lw
    lb   $t5, 0($t0)           # Carga el byte (0 o 1) desde la dirección en $t0

    # 2. Obtener el color de la paleta
    #    (Esta lógica no cambia, sigue funcionando)
    sll  $t6, $t5, 2           # $t6 = tipo * 4 (para el offset de la paleta)
    add  $t6, $t6, $t1         # $t6 = dirección de &paleta_colores[tipo]
    lw   $t7, 0($t6)           # $t7 = Carga el color (word) de la paleta

    # 3. Escribir el color en el display
    #    (Esto no cambia, seguimos escribiendo un word)
    sw   $t7, 0($t2)           # Guarda el color en la memoria del display

    # 4. Avanzar los punteros y el contador
    #    ¡CAMBIO! El puntero del mapa solo avanza 1
    addi $t0, $t0, 1          # Avanza el puntero del mapa 1 byte
    addi $t2, $t2, 4          # Avanza el puntero del display 1 word (4 bytes)
    addi $t3, $t3, 1          # i++
    
    # Repetir
    j    draw_loop

done:
    # --- Fin del programa ---
    li   $v0, 10
    syscall