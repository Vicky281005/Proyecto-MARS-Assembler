.data
# --- IMPORTANTE: LA MEMORIA DE VIDEO DEBE IR PRIMERO ---
# Al poner esto al inicio, aseguramos que 'pantalla' esté en la dirección base (0x10010000)
pantalla: .space 1024   

# Paleta de colores que se utilizan en la interfaz
paleta_colores:
    .word 0xFF000000  # 0: Negro
    .word 0xFF0000FF  # 1: Azul
    .word 0xFFFFFFFF  # 2: Blanco (Jugador / Pac-Man)
    .word 0xFFFF00FF  # 3: Fucsia (Meta)
    .word 0xFF800080  # 4: Morado (Teletransporte)
    .word 0xFFFFFF00  # 5: Amarillo (Moneda)
    .word 0xFFFF0000  # 6: Rojo (Fantasma / Game Over)
    .word 0xFF00FF00  # 7: Verde (Color de Victoria)

# DATOS ESTÁTICOS Y CADENAS 
puntaje_jugador: .word 0 # Dirección de memoria inicializada en 0 para el puntaje 
msj_victoria:    .asciiz "\nYOU WIN\n"     # Mensaje solicitado del enunciado del proyecto
msj_fin_juego:   .asciiz "\nGAME OVER\n"   # Mensaje solicitado del enunciado del proyecto
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

# Palabra de memoria para almacenar la cantidad activa de enemigos (Contador N)
num_fantasmas:      .word 0

# Bloque de 16 bytes reservado para un vector de posiciones.
# Capacidad: 4 enteros de 32 bits (4 enemigos x 4 bytes cada uno).
pos_fantasmas:      .space 16  

# Bloque de 4 bytes reservado para buffer de restauración.
# Almacena el valor del mapa (1 byte) que está siendo cubierto temporalmente por cada enemigo.
item_bajo_fantasma: .space 4   


# MAPA DEL JUEGO
# 1=Pared, 0=Piso
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

.text  # Inicio del segmento de instrucciones (código ejecutable)
.globl main # Declara la etiqueta 'main' como global (punto de entrada del programa)

main:
    la   $t0, mapa_juego # Carga la dirección base (puntero) de la matriz 'mapa_juego' en el registro $t0.
                         # A partir de ahora, usaremos $t0 para acceder a las casillas del mapa.

    # 1. BUSCAR LUGAR PARA EL JUGADOR (Blanco - ID 2)
buscar_sitio_blanco: # Etiqueta de inicio del bucle
    li   $v0, 42    # Cargar servicio de Random Int
    li   $a1, 222   # Límite superior (0 a 221)
    syscall         # Ejecutar: El resultado queda en $a0
    addi $a0, $a0, 18   # Se aplica desplazamiento (offset) para evitar las paredes iniciales
    
    add  $t6, $t0, $a0    # Aritmética de punteros: Obtener la dirección de memoria de la casilla seleccionada  
    lb   $t5, 0($t6)      # # Lectura de memoria: Cargar el byte ubicado en la dirección efectiva ($t6)
    bne  $t5, $zero, buscar_sitio_blanco #Si el contenido no es 0 (ocupado), saltar y reintentar
    
    move $s0, $a0      # $s0 guarda la posición del jugador
    li   $t5, 2        # Cargar Inmediato: Preparar el identificador del jugador (ID 2)
    sb   $t5, 0($t6)   # Escritura en Memoria: Almacenar el ID del jugador en la dirección efectiva calculada


    # 2. BUSCAR LUGAR PARA LA META (Fucsia - ID 3) 
buscar_sitio_fucsia:   # Etiqueta de inicio del bucle
    li   $v0, 42       # Servicio: Generar entero aleatorio
    li   $a1, 222      # Argumento: Límite superior (0 a 221)
    syscall            # Ejecutar (Resultado en $a0)
    
    addi $a0, $a0, 18  # Ajustar offset: Sumar 18 para saltar las paredes iniciales
    add  $t6, $t0, $a0     # Dirección Efectiva = Base ($t0) + Random ($a0)
    
    lb   $t5, 0($t6)       # Leer byte: ¿Qué hay en esa casilla?
    bne  $t5, $zero, buscar_sitio_fucsia # Si NO es 0 (está ocupado), repetir
    
    li   $t5, 3        #  Cargamos el ID 3 (Fucsia)
    sb   $t5, 0($t6)   # Escribimos el 3 en la memoria


    # 3. BUSCAR LUGAR PARA EL TELETRANSPORTE (Morado - ID 4) 
buscar_sitio_morado:   # Etiqueta de inicio del bucle
    li   $v0, 42       # Servicio: Random Int
    li   $a1, 222      # Rango: 0 a 221
    syscall            # Resultado en $a0
    
    addi $a0, $a0, 18  # Ajuste de zona segura
    add  $t6, $t0, $a0 # Dirección Efectiva ($t6) = Base + Random     
    
    lb   $t5, 0($t6)        # Leer: ¿Qué hay aquí?
    bne  $t5, $zero, buscar_sitio_morado # Si NO es 0, repetir
    
    li   $t5, 4        # Cargar ID 4 (Morado)
    sb   $t5, 0($t6)   # Pintarlo en el mapa
    
    

    # --- 4. GENERAR PUNTOS AMARILLOS (Monedas - ID 5) ---
    li   $v0, 42       # Servicio: Random Int
    li   $a1, 4        # Genera: 0, 1, 2 o 3
    syscall            # El resultado queda en $a0
    addi $s1, $a0, 3   # Sumamos 3, $s1 guarda el limite de monedas
    li   $s2, 0        # Inicializar el contador (i = 0)
bucle_monedas:
    bge  $s2, $s1, fin_bucle_monedas  # Condición de Salida: Si i >= N, terminar.
buscar_sitio_amarillo:
    # --- Generación de Coordenada ---
    li   $v0, 42            # Preparar servicio: Generar entero aleatorio
    li   $a1, 222           # Argumento: Límite superior del rango
    syscall                 # Llamada al sistema (Resultado en $a0)
    
    addi $a0, $a0, 18       # Ajuste de Offset: Desplazar para evitar bordes no válidos
    add  $t6, $t0, $a0      # Aritmética de Punteros: Calcular dirección efectiva ($t6 = Base + Random)
      
    lb   $t5, 0($t6)        # Lectura de Memoria: Verificar contenido actual de la casilla
    bne  $t5, $zero, buscar_sitio_amarillo  # Condición: Si la casilla está ocupada (!= 0), reintentar posición 
    
    # Escritura en Memoria
    li   $t5, 5        # Cargar Inmediato: Identificador lógico de Moneda (Valor 5)
    sb   $t5, 0($t6)    # Almacenar Byte: Escribir el 5 en la dirección validada
    
    addi $s2, $s2, 1        # Incrementar el contador de monedas colocadas (i++)
    j    bucle_monedas      # Salto incondicional: Volver a la cabecera del bucle para verificar condición de parada
fin_bucle_monedas:


    # 5. GENERAR FANTASMAS (Rojos - ID 6) 

    #  PASO 1: DETERMINAR CANTIDAD (N) 
    li   $v0, 42            # Prepara servicio Random Int
    li   $a1, 3             # Rango [0, 1, 2]
    syscall                 # Ejecutar. Resultado en $a0
    addi $s1, $a0, 2        # Sumar 2. Rango Final: [2, 3, 4]. Esto es N ($s1).
    
    # Guardar N en memoria para que la IA lo use durante el juego
    la   $s3, num_fantasmas 
    sw   $s1, 0($s3)        # Guardar la cantidad total en la variable estática

    # PASO 2: INICIALIZAR PUNTEROS Y CONTADOR 
    li   $s2, 0             # Inicializ contador del bucle (i = 0)
    la   $s4, pos_fantasmas # Cargar Puntero Base del arreglo de Posiciones (Words)
    la   $s7, item_bajo_fantasma # Cargar Puntero Base del arreglo de Buffers (Bytes)

bucle_rojos:
    # Condición de parada: Si i ($s2) >= N ($s1), terminamos de crear fantasmas
    bge  $s2, $s1, fin_bucle_rojos

    # PASO 3: BUSCAR SITIO VACÍO (Generación y Validación) 
buscar_sitio_rojo:
    li   $v0, 42            # Random Int
    li   $a1, 222           # Límite superior
    syscall
    addi $a0, $a0, 18       # Offset de seguridad (evitar bordes)
    
    add  $t6, $t0, $a0      # Calcular Dirección Efectiva en el mapa ($t6 = BaseMapa + Random)
    lb   $t5, 0($t6)        # Leer contenido de esa casilla
    bne  $t5, $zero, buscar_sitio_rojo # Si ocupado (!= 0), intentar de nuevo
    
    # PASO 4: GUARDAR EN ARREGLO DE POSICIONES (Enteros/Words) 
    # Aquí se usa aritmética de punteros para Arrays de enteros (4 bytes)
    sll  $t7, $s2, 2        # Calcular Desplazamiento: i * 4 (usando shift left)
    add  $t8, $s4, $t7      # Dirección Destino = Base Arreglo ($s4) + Desplazamiento ($t7)
    sw   $a0, 0($t8)        # Guardar la coordenada ($a0) en la posición i del arreglo

    #  PASO 5: GUARDAR EN ARREGLO DE BUFFER (Bytes) 
    # Aquí use usa aritmética simple para Arrays de bytes (1 byte)
    add  $t8, $s7, $s2      # Dirección Destino = Base Arreglo ($s7) + i (sin multiplicar)
    sb   $zero, 0($t8)      # Inicializar el buffer del fantasma i con 0 (se asume suelo vacío)

    # PASO 6: PINTAR Y FINALIZAR ITERACIÓN 
    li   $t5, 6             # Cargar ID 6 (Rojo)
    sb   $t5, 0($t6)        # Escribir visualmente en el mapa (en la dirección $t6)
    
    addi $s2, $s2, 1        # Incrementar contador (i++)
    j    bucle_rojos        # Volver al inicio del bucle para el siguiente fantasma

fin_bucle_rojos:

    li   $s2, 0        # Reiniciar puntaje del jugador para empezar

# --- BUCLE PRINCIPAL DEL JUEGO (GAME LOOP) ---
bucle_juego:

    # FASE DE RENDERIZADO (DIBUJAR) 
    # Preparamos los 3 punteros base necesarios para traducir lógica a gráficos
    la   $t0, mapa_juego    # Puntero Base 1: Origen de datos lógicos (Array de Bytes)
    la   $t2, pantalla      # Puntero Base 2: Destino de video (Bitmap Display)
    la   $t1, paleta_colores # Puntero Base 3: Tabla de traducción (IDs -> Colores Hex)
    
    # Configuración del bucle iterador
    li   $t3, 0             # Inicializar contador i = 0
    li   $t4, 256           # Límite del bucle (16x16 casillas = 256 iteraciones)

bucle_dibujo:
    # Condición de salida: si i >= 256, terminamos de dibujar el frame
    bge  $t3, $t4, fin_bucle_dibujo
    
    # 1. LEER EL MAPA LÓGICO
    lb   $t5, 0($t0)        # Cargar Byte: Se obtiene el ID del objeto (0=Vacío, 1=Pared, etc.)
    
    # 2. TRADUCIR ID A DIRECCIÓN DE PALETA
    # Como la paleta es un array de Words (4 bytes), se multiplica el ID por 4
    sll  $t6, $t5, 2        # Desplazamiento lógico: $t6 = ID * 4
    add  $t6, $t6, $t1      # Dirección Efectiva en Paleta = Base Paleta + Offset calculado
    
    # 3. OBTENER COLOR REAL
    lw   $t7, 0($t6)        # Cargar Palabra: Traer el código de color HEX (ej: 0xFF0000FF)
    
    # 4. PINTAR EN PANTALLA
    sw   $t7, 0($t2)        # Almacenar Palabra: Escribir el color en la memoria de video
    
    # 5. ACTUALIZAR PUNTEROS E ÍNDICE
    addi $t0, $t0, 1        # Avanza 1 byte en el mapa lógico (Siguiente casilla)
    addi $t2, $t2, 4        # Avanza 4 bytes en la pantalla (Siguiente píxel en Bitmap)
    addi $t3, $t3, 1        # Incrementar contador (i++)
    
    j    bucle_dibujo       # Repetir para el siguiente píxel

fin_bucle_dibujo:

    # LECTURA DE ENTRADA (INPUT)
    li   $v0, 12            # Cargar servicio 12 (Read Char): Lectura bloqueante de un carácter
    syscall                 # Interrupción del sistema: Espera hasta que el usuario presione una tecla
    move $t4, $v0           # Respaldar el valor ASCII de la tecla ingresada en $t4 para su evaluación

    # DECODIFICACIÓN DE INSTRUCCIÓN
    # Se compara el input con las constantes ASCII de W,A,S,D
    
    li   $t7, 119           # Cargar constante ASCII 'w' (119)
    beq  $t4, $t7, mover_w  # Branch if Equal: Si tecla == 'w', saltar a rutina de movimiento ARRIBA
    
    li   $t7, 97            # Cargar constante ASCII 'a' (97)
    beq  $t4, $t7, mover_a  # Branch if Equal: Si tecla == 'a', saltar a rutina de movimiento IZQUIERDA
    
    li   $t7, 115           # Cargar constante ASCII 's' (115)
    beq  $t4, $t7, mover_s  # Branch if Equal: Si tecla == 's', saltar a rutina de movimiento ABAJO
    
    li   $t7, 100           # Cargar constante ASCII 'd' (100)
    beq  $t4, $t7, mover_d  # Branch if Equal: Si tecla == 'd', saltar a rutina de movimiento DERECHA
    
    # Si la tecla es inválida
    # Si no coincide con ninguna dirección, el jugador pierde el turno y la IA (fantasmas) se actualiza
    j    mover_fantasmas    

    # DEFINICIÓN DE VECTORES DE MOVIMIENTO 
    # $t5 almacenará el desplazamiento de memoria necesario para moverse en la matriz lineal

mover_w:
    li   $t5, -16           # Vector Arriba: Restar 16 (ancho del mapa) para retroceder una fila completa
    j    ejecutar_movimiento # Salto incondicional a la lógica de actualización física

mover_a:
    li   $t5, -1            # Vector Izquierda: Restar 1 byte para retroceder una columna
    j    ejecutar_movimiento

mover_s:
    li   $t5, 16            # Vector Abajo: Sumar 16 (ancho del mapa) para avanzar una fila completa
    j    ejecutar_movimiento

mover_d:
    li   $t5, 1             # Vector Derecha: Sumar 1 byte para avanzar una columna
    
    
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
