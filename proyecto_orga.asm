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
    j    ejecutar_movimiento  # Salto incondicional a la lógica de actualización fisica

mover_a:
    li   $t5, -1            # Vector Izquierda: Restar 1 byte para retroceder una columna
    j    ejecutar_movimiento

mover_s:
    li   $t5, 16            # Vector Abajo: Sumar 16 (ancho del mapa) para avanzar una fila completa
    j    ejecutar_movimiento

mover_d:
    li   $t5, 1             # Vector Derecha: Sumar 1 byte para avanzar una columna
    
    
ejecutar_movimiento:
    # Calculamos el índice de destino antes de movernos realmente para validar si es legal
    add  $t6, $s0, $t5      # Índice Destino ($t6) = Índice Actual ($s0) + Vector de Movimiento ($t5)
    
    la   $t0, mapa_juego    # Cargar puntero base del mapa
    add  $t7, $t0, $t6      # Calcular Dirección Efectiva de la casilla destino ($t7 = Base + Índice Destino)
    lb   $t8, 0($t7)        # Leer el contenido (ID del objeto) en la casilla destino
    
    # CASO A: COLISIÓN CON PARED
    li   $t9, 1             # Cargar ID Pared (1)
    beq  $t8, $t9, mover_fantasmas # Si es pared, no habra movimiento (el jugador se queda donde está)
    
    # CASO B: VICTORIA (META)
    li   $t9, 3             # Cargar ID Meta (3)
    beq  $t8, $t9, victoria # Si es meta saltar inmediatamente a la rutina de victoria
    
    # CASO C: TELETRANSPORTACIÓN (EXTRA)
    li   $t9, 4             # Cargar ID Teleport (4)
    bne  $t8, $t9, verificar_moneda # Si NO es teleport, saltar a verificar si es moneda o suelo
    
    # --- LÓGICA DE TELETRANSPORTE (Ejecución por Caída Libre) 
    # Si llegamos aquí, es porque bne fue falso (SÍ es teleport).
    # Borrar al jugador de la posición ACTUAL ($s0) antes de reubicarlo
    add  $t7, $t0, $s0      # Recalcular dirección de memoria de la posición *vieja, antes de querer moverse* ($s0)
    sb   $zero, 0($t7)      # Escribir 0 (Vacío) para limpiar el rastro del jugador
    
    
buscar_sitio_teleport:
    li   $v0, 42            # Cargar código de servicio 42 (Generar Entero Aleatorio) en $v0
    li   $a1, 256           # Cargar límite superior del rango (0-255) en argumento $a1
    syscall                 # Ejecutar llamada al sistema (el resultado queda en $a0)
    
    add  $t7, $t0, $a0      # Calcular dirección efectiva: Base del mapa ($t0) + Índice aleatorio ($a0)
    lb   $t9, 0($t7)        # Cargar byte desde memoria para verificar el contenido de la casilla
    
    bne  $t9, $zero, buscar_sitio_teleport # Si el contenido no es 0 (está ocupado), reiniciar búsqueda
    
    li   $t5, 2             # Cargar valor inmediato 2 (ID del Jugador) en registro temporal
    sb   $t5, 0($t7)        # Almacenar byte: Escribir el ID del jugador en la nueva dirección validada
    move $s0, $a0           # Actualizar registro persistente $s0 con la nueva posición del jugador
    
    j    mover_fantasmas    # Salto incondicional: Finalizar turno y proceder a la IA de los enemigos
    
verificar_moneda:
    li   $t9, 5             # Cargar Inmediato: Definir el ID de la Moneda (5) para comparación
    
    # Comparación lógica: Si el objeto en destino ($t8) NO es una moneda, 
    # saltar la bonificación y proceder al movimiento físico.
    bne  $t8, $t9, movimiento_normal 
    
    # Acumulación de Puntos (Solo se ejecuta si bne es falso):
    addi $s2, $s2, 10       # Sumar 10 unidades al registro de puntuación global ($s2)
            
movimiento_normal:
   # Borramos donde estaba antes
    la   $t0, mapa_juego    # Recargar puntero base del mapa 
    add  $t7, $t0, $s0      # Calcular dirección efectiva de la posición ACTUAL/VIEJA ($s0)
    sb   $zero, 0($t7)      # Sobrescribir memoria: Poner 0 (Vacío) donde estaba el jugador antes
    
    # Ocupar nueva casilla
    li   $t5, 2             # Cargar ID del Jugador (2)
    add  $t7, $t0, $t6      # Calcular dirección efectiva de la posición DESTINO ($t6)
                            # Nota: $t6 fue calculado previamente en 'ejecutar_movimiento'
    sb   $t5, 0($t7)        # Escritura en memoria: Poner 2 (Jugador) en la nueva casilla
    move $s0, $t6           # Actualizar la nueva posición ($t6) es ahora la actual ($s0)

    # --- VERIFICACIÓN DE COLISIÓN (JUGADOR -> ENEMIGO) ---
    # Fase de Inicialización del Bucle de Búsqueda
verificar_colision_1:
    la   $s3, num_fantasmas     # Cargar dirección de la variable de cantidad
    lw   $s3, 0($s3)            # Cargar valor N (Límite del bucle: Total de enemigos activos)
    
    li   $s5, 0                 # Inicializar índice iterador i = 0
    la   $s4, pos_fantasmas     # Cargar Puntero Base del arreglo de coordenadas de enemigos
    
bucle_chequeo_1:
    # Condición de Salida: Si i ($s5) >= N ($s3), no hubo colisión
    bge  $s5, $s3, mover_fantasmas 
    
    # Acceso al Arreglo
    sll  $t7, $s5, 2       # Calcular Offset: i * 4 (Alineación a palabra/word)
    add  $t8, $s4, $t7     # Calcular Dirección Efectiva del elemento i en el arreglo
    lw   $s6, 0($t8)       # Cargar coordenada del fantasma actual en $s6
    
    # Lógica de Colisión 
    # Comparar coordenada del Jugador ($s0) con la del Fantasma ($s6)
    beq  $s0, $s6, game_over    # Si coinciden, terminar el juego (Derrota)
    
    # Actualización del Bucle 
    addi $s5, $s5, 1            # Incrementar contador (i++)
    j    bucle_chequeo_1        # Salto incondicional al inicio del ciclo

mover_fantasmas:
                                # Obtener el Límite del Bucle (N)
    la   $s3, num_fantasmas     # Cargar la dirección de la variable estática
    lw   $s3, 0($s3)            # Cargar valor para obtener la cantidad N de enemigos activos
    
    li   $s5, 0                 # Inicializar índice del bucle (i = 0)
    
    la   $s4, pos_fantasmas     # Cargar dirección base del vector de coordenadas ($s4)
    la   $s7, item_bajo_fantasma # Cargar dirección base del vector de buffers de restauración ($s7)

bucle_fantasmas_ext:
    # Si el índice actual ($s5) alcanza el límite ($s3), salir del bucle
    bge  $s5, $s3, verificar_colision_2 
    
    # Acceso indexado al arreglo de posiciones
    sll  $t7, $s5, 2        # Calcular desplazamiento de memoria: Índice * 4 bytes
    add  $t8, $s4, $t7      # Calcular dirección efectiva: Base del arreglo ($s4) + Desplazamiento
    lw   $s6, 0($t8)        # Cargar la posición actual del fantasma 'i' desde la memoria
    
    # Preparación del entorno para la IA
    li   $s1, 0                 # Limpieza de registro auxiliar para cálculos internos
    la   $t0, mapa_juego        # Recargar el puntero base del mapa para garantizar referencias válidas

    # Inicialización del mecanismo de seguridad
    li   $t2, 0

# NÚCLEO DE DECISIÓN DE LA IA 
buscar_movimiento_fantasma:
bucle_fantasmas_int:
    # MECANISMO DE SEGURIDAD para evitar un bucle infinito si el fantasma no tiene a donde moverse
    li   $t3, 15     # Cargar límite de intentos 
    
    # Si intentos ($t2) >= límite ($t3), abortar movimiento para este turno (evitar congelamiento)
    bge  $t2, $t3, sig_fantasma 
    addi $t2, $t2, 1        # Incrementar contador de intentos fallidos
    
    # GENERACIÓN DE DIRECCIÓN ALEATORIA
    li   $v0, 42          # Servicio Random Int
    li   $a1, 4           # Rango [0, 3] (4 direcciones posibles)
    syscall               # Resultado en $a0 (0=Arriba, 1=Abajo, 2=Izq, 3=Der)
    
    # traducir el int aleatorio a un offset de memoria física
    beq  $a0, $zero, fantasma_arriba # Case 0: Ir Arriba
    
    li   $t7, 1             
    beq  $a0, $t7, fantasma_abajo    # Case 1: Ir Abajo
    
    li   $t7, 2
    beq  $a0, $t7, fantasma_izq      # Case 2: Ir Izquierda
    
    # Case 3 (Default): Ir Derecha
fantasma_der:
    li   $t5, 1             # Vector Derecha: +1 byte
    j    chequear_mov_fantasma

fantasma_arriba:
    li   $t5, -16           # Vector Arriba: -16 bytes (Retroceder una fila)
    j    chequear_mov_fantasma

fantasma_abajo:
    li   $t5, 16            # Vector Abajo: +16 bytes (Avanzar una fila)
    j    chequear_mov_fantasma

fantasma_izq:
    li   $t5, -1            # Vector Izquierda: -1 byte

chequear_mov_fantasma:
    # CÁLCULO DE COORDENADA POSIBLE
    add  $t6, $s6, $t5   # Índice Candidato = Posición Actual ($s6) + Vector de Desplazamiento ($t5)
    
    # LECTURA DE MEMORIA
    la   $t0, mapa_juego    # Cargar base del mapa
    add  $t7, $t0, $t6      # Calcular Dirección  de la celda destino
    lb   $t9, 0($t7)        # Obtener el ID del objeto en el destino
    
    # EVALUACIÓN DE RESTRICCIONES 
    # Caso A: Movimiento a Espacio Vacío
    beq  $t9, $zero, ejecutar_mov_fantasma # Si contenido == 0, el movimiento es válido -> Ejecutar
    
    # Caso B: Colisión con Jugador (Ataque)
    li   $t1, 2             # Cargar ID del Jugador (2)
    beq  $t9, $t1, ejecutar_mov_fantasma   # Si contenido == 2, colisión válida -> Ejecutar
    
    # RECHAZO DE MOVIMIENTO 
    # Si llegamos aquí, la celda contiene un obstáculo (Pared, Moneda, Meta, etc.)
    j    bucle_fantasmas_int # Salto incondicional: Retornar al selector aleatorio para probar otra dirección

ejecutar_mov_fantasma:
    # FASE 1: GESTIÓN DEL BUFFER (Memoria Temporal) 
    # Calcular la dirección del buffer individual para este fantasma (Base + Índice)
    add  $s1, $s7, $s5      # $s1 = Puntero al byte de respaldo del fantasma actual
    
    # FASE 2: RESTAURACIÓN (Borrar rastro anterior)
    lb   $t5, 0($s1)        # Cargar el ítem original (backup) desde el buffer
    
    add  $t7, $t0, $s6      # Calcular dirección efectiva de la posición VIEJA ($s6)
    sb   $t5, 0($t7)        # Restaurar: Escribir el ítem original en el mapa (despintar fantasma)
    
    # FASE 3: RESPALDO (Preparar siguiente estado)
    # $t9 contiene el objeto de la nueva casilla (leído previamente)
    sb   $t9, 0($s1)        # Actualizar buffer: Guardar el objeto que vamos a cubrir ahora
    
    # FASE 4: ACTUALIZACIÓN VISUAL Y LÓGICA 
    li   $t5, 6             # Cargar ID del Fantasma (6)
    
    add  $t7, $t0, $t6      # Calcular dirección efectiva de la posición NUEVA ($t6)
    sb   $t5, 0($t7)        # Escritura visual: Pintar al fantasma en la nueva casilla
    
    # Actualizar el arreglo de coordenadas (Array Persistence)
    # Nota: $t8 ya apuntaba a la dirección correcta en 'pos_fantasmas' desde el inicio del bucle
    sw   $t6, 0($t8)        # Guardar la nueva coordenada ($t6) en el arreglo de posiciones
    
sig_fantasma:
    # CONTROL DE BUCLE 
    addi $s5, $s5, 1        # Incrementar índice de iteración (Siguiente fantasma)
    j    bucle_fantasmas_ext # Retorno al inicio del ciclo de IA

fin_bucle_fantasmas:

   # VERIFICACIÓN DE COLISIÓN SECUNDARIA (ENEMIGO -> JUGADOR) 
   # Se ejecuta al finalizar el ciclo de movimiento de todos los enemigos
verificar_colision_2:
    # Fase de Inicialización del Bucle de Búsqueda
    la   $s3, num_fantasmas     # Cargar dirección de la variable de cantidad
    lw   $s3, 0($s3)            # Cargar N (Total de enemigos activos)
    
    li   $s5, 0                 # Inicializar índice iterador i = 0
    la   $s4, pos_fantasmas     # Cargar Puntero Base del arreglo de coordenadas
    
bucle_chequeo_2:
    # Condición de Salida: Si recorrimos toda la lista sin coincidencias, el jugador sobrevive
    bge  $s5, $s3, sin_colision 
    
    # Acceso al Arreglo 
    sll  $t7, $s5, 2            # Calcular Offset: i * 4 bytes
    add  $t8, $s4, $t7          # Calcular Dirección Efectiva del fantasma i
    lw   $s6, 0($t8)            # Cargar coordenada actual del fantasma en $s6
    
    # Comparación de Coordenadas 
    # Verificar si la posición del Jugador ($s0) coincide con la del Fantasma ($s6)
    beq  $s0, $s6, game_over    # Branch if Equal: Colisión detectada -> Derrota 
    
    # Iteración 
    addi $s5, $s5, 1            # Siguiente fantasma (i++)
    j    bucle_chequeo_2        # Repetir ciclo

sin_colision:
    # Si llegamos aquí, el jugador sobrevivió al turno de la IA.
    # Retornamos al inicio del Bucle Principal para renderizar el siguiente frame.
    j    bucle_juego
    
# RUTINA DE FIN DE JUEGO (DERROTA) 
game_over:
    #  CONSOLA 
    la   $a0, msj_fin_juego     # Cargar dirección del string "GAME OVER"
    li   $v0, 4                 # Servicio Syscall 4: Imprimir String
    syscall                     # Mostrar mensaje de estado en la terminal
    
    # PANTALLA DE MUERTE 
    # Configuración de punteros para dibujar la imagen estática 'mapa_game_over'
    la   $t0, mapa_game_over    # Origen: Puntero al array de píxeles de la imagen de derrota
    la   $t2, pantalla          # Destino: Puntero al inicio de la memoria de video
    la   $t1, paleta_colores    # Referencia: Puntero a la tabla de traducción de colores
    
    li   $t3, 0                 # Inicializar contador de píxeles (i = 0)
    li   $t4, 256               # Límite de iteraciones (Total píxeles: 16x16 = 256)

dibujar_game_over:
    # Condición de Salida: Si terminamos de dibujar toda la pantalla, cerrar programa
    bge  $t3, $t4, fin_programa 
    
    # Proceso de Traducción y Dibujo 
    lb   $t5, 0($t0)            # Leer ID de color desde la imagen de origen
    
    sll  $t6, $t5, 2            # Calcular Offset de Paleta: ID * 4 bytes
    add  $t6, $t6, $t1          # Calcular Dirección Efectiva del color real
    lw   $t7, 0($t6)            # Cargar valor hexadecimal del color (RGB)
    
    sw   $t7, 0($t2)            # Escribir píxel en la memoria de video (Bitmap Display)
    
    # Actualización de Punteros 
    addi $t0, $t0, 1            # Avanzar al siguiente byte en la imagen de origen
    addi $t2, $t2, 4            # Avanzar a la siguiente palabra en la memoria de video
    addi $t3, $t3, 1            # Incrementar contador de píxeles procesados
    
    j    dibujar_game_over      # Repetir para el siguiente píxel
    
# RUTINA DE VICTORIA Y REPORTE DE PUNTUACION
victoria:
    # Imprimir "YOU WIN"
    la   $a0, msj_victoria      # Cargar dirección del string de victoria en el registro de argumento
    li   $v0, 4                 # Cargar código de servicio 4 (Print String)
    syscall                     # Ejecutar llamada al sistema: Escribir mensaje en consola

    # FORMATO DE SALIDA (Imprimir Prefijo "Hex: 0x") 
    la   $a0, msj_hex           # Cargar dirección del string de etiqueta hexadecimal
    li   $v0, 4                 # Código de servicio 4 (Print String)
    syscall                     # Ejecutar: Mostrar "Hex: 0x"

    # INICIALIZACIÓN DEL ALGORITMO DE CONVERSIÓN HEX 
    move $t8, $s2               # Preservación de Datos: Copiar el puntaje ($s2) a un registro temporal ($t8)
                                # Usando una copia para manipular los bits sin perder el valor original del puntaje.

    li   $t9, 28                # Inicializar Contador de Desplazamiento (Shift Counter)
                                # Empezamos en 28 para aislar los 4 bits más significativos (bits 31-28).
bucle_hex_vic:
    # EXTRACCIÓN DE NIBBLE 
    srlv $a0, $t8, $t9      # Desplazamiento Lógico Variable: Mover los bits relevantes a la posición LSB (Least Significant Bit)
                            # Cantidad de shift definida por $t9 (empieza en 28, baja de 4 en 4)
                            
    andi $a0, $a0, 0xF      # Máscara de Bits (Bitwise AND): Aislar los últimos 4 bits.
                            # Esto limpia cualquier "basura" a la izquierda, dejando un valor puro entre 0 y 15.
    
    # CONVERSIÓN A ASCII 
    # Algoritmo: Si valor < 10, es número (0-9). Si valor >= 10, es letra (A-F).
    
    slti $t1, $a0, 10       # Comparación: ¿Es el valor menor que 10? ($t1 = 1 si es número, 0 si es letra)
    bne  $t1, $zero, imprimir_digito_hex # Si es número, saltar el ajuste de letras
    
    addi $a0, $a0, 7        # Ajuste Alfanumérico: Si es 10-15, sumar 7 extra para saltar los símbolos ASCII entre '9' y 'A'

imprimir_digito_hex:
    addi $a0, $a0, 48       # Offset Base ASCII: Sumar 48 para convertir el valor numérico al carácter '0'..'9'
                            # Ejemplo: 0 + 48 = '0', 10 + 7 + 48 = 65 ('A')
    
    # IMPRESIÓN 
    li   $v0, 11            # Servicio Print Character
    syscall                 # Imprimir el carácter hexadecimal resultante
    
    # CONTROL DE BUCLE 
    subi $t9, $t9, 4        # Decrementar el contador de desplazamiento en 4 bits (Siguiente Nibble)
    bge  $t9, $zero, bucle_hex_vic # Si el desplazamiento es >= 0, repetir para el siguiente dígito
    
    # FORMATO FINAL 
    la   $a0, salto_linea   # Cargar carácter de nueva línea
    li   $v0, 4             # Imprimir String
    syscall                 # Salto de línea para separar del siguiente tipo de dato (Decimal)


    #  PUNTAJE EN BASE DECIMAL 
    # IMPRESIÓN DE ETIQUETA
    la   $a0, msj_dec       # Cargar dirección del string "Dec: "
    li   $v0, 4             # Servicio 4: Print String
    syscall                 # Salida: "Dec: "
    
    # IMPRESIÓN DEL VALOR NUMÉRICO
    move $a0, $s2           #  Se copia el puntaje ($s2) al registro de argumento ($a0)
                            # Requisito obligatorio porque syscall lee siempre desde $a0
                            
    li   $v0, 1             # Servicio 1: Print Integer
                            # Este servicio realiza automáticamente la conversión de Binario a ASCII Decimal
    syscall                 

    # FORMATO DE SALIDA
    la   $a0, salto_linea   # Cargar dirección del carácter '\n'
    li   $v0, 4             # Servicio 4: Print String
    syscall                 # Salto de línea para separar del siguiente tipo de dato(Octal)
    
    
   # PUNTAJE EN BASE OCTAL 
    # ETIQUETA
    la   $a0, msj_oct       # Cargar prefijo "Oct: 0o"
    li   $v0, 4
    syscall

    # PREPARACIÓN DE ALGORITMO
    move $t8, $s2           # Copia de seguridad del puntaje en registro temporal
    li   $t9, 30            # Inicializar Shift: Empezamos en el bit 30. 
                            # (32 bits no es divisible por 3; el primer grupo son los bits 31-30)

bucle_oct_vic:
    # PREPARAR EL DÍGITO 
    srlv $a0, $t8, $t9      # Traer el grupo de bits que nos toca leer hacia la derecha (al final) para poder usarlo.
    andi $a0, $a0, 0x7      # Limpiar el registro: Borrar todo lo que sobra a la izquierda y dejar solo el número del 0 al 7.
    
    # TRADUCIR A TEXTO 
    # En Octal es fácil: como no hay letras, solo sumamos 48 para convertir el número en su "dibujo" (carácter).
    addi $a0, $a0, 48       # Convertir el valor matemático en un símbolo ASCII visible.
    
    # MOSTRAR 
    li   $v0, 11        # Decirle a la consola: "Escribe este carácter".
    syscall

    # SIGUIENTE GRUPO 
    subi $t9, $t9, 3        # Restar 3 al contador (porque en Octal leemos de 3 en 3 bits).
    bge  $t9, $zero, bucle_oct_vic # ¿Si quedan bits por leer repetimos el proceso.

    # SALTO DE LÍNEA 
    la   $a0, salto_linea
    li   $v0, 4
    syscall
    
    
    # PUNTUACION EN BINARIO
    
    # 1. ETIQUETA
    la   $a0, msj_bin       # Escribir "Bin: 0b" en la consola.
    li   $v0, 4
    syscall

    # 2. PREPARACIÓN
    move $t8, $s2           # Hacer una copia de seguridad del puntaje para no dañarlo.
    li   $t9, 31            # Poner el "dedo" en el bit 31 (el primero de la izquierda).

bucle_bin_vic:
    # AISLAR UN SOLO BIT 
    srlv $a0, $t8, $t9      # Mover el bit actual hasta el final de la fila.
    andi $a0, $a0, 1        # Filtrar: ¿Es un 0 o un 1? Borrar todo lo demás.
    
    # TRADUCIR A TEXTO 
    addi $a0, $a0, 48       # Convertir el 0 o 1 numérico en el carácter '0' o '1'.
    
    # MOSTRAR 
    li   $v0, 11            # Imprimir el bit en pantalla.
    syscall

    # SIGUIENTE BIT 
    subi $t9, $t9, 1        # Movernos una posición a la derecha (al siguiente bit).
    bge  $t9, $zero, bucle_bin_vic # Repetir hasta que hayamos impreso los 32 bits.

    # SALTO DE LÍNEA FINAL 
    la   $a0, salto_linea
    li   $v0, 4
    syscall

    # PANTALLA FINAL (DIBUJO)
    # --- CONFIGURACIÓN DEL CONTEXTO GRÁFICO ---
    # Inicializamos los punteros necesarios para la transferencia de datos visuales
    la   $t0, mapa_victoria     # Establecer el origen de datos: Matriz estática de la imagen de victoria
    la   $t2, pantalla          # Establecer el destino de escritura: Dirección base del Bitmap Display
    la   $t1, paleta_colores    # Cargar la tabla de referencia para la traducción de colores
    
    li   $t3, 0                 # Inicializar el contador de iteraciones en 0
    li   $t4, 256               # Definir la resolución total de la imagen (16x16 píxeles)

dibujar_victoria:
    # Verificar si se ha completado el renderizado de todos los píxeles para finalizar el programa
    bge  $t3, $t4, fin_programa
    
    # PIPELINE DE PROCESAMIENTO DE PÍXELES 
    lb   $t5, 0($t0)            # Extracción: Leer el ID lógico del color desde la imagen de origen
    
    sll  $t6, $t5, 2            # Cálculo de Offset: Alinear el ID al tamaño de palabra (4 bytes)
    add  $t6, $t6, $t1          # Direccionamiento: Calcular la dirección física del color en la paleta
    lw   $t7, 0($t6)            # Decodificación: Obtener el valor hexadecimal real (RGB) del color
    
    sw   $t7, 0($t2)            # Renderizado: Escribir el valor de color en la memoria de video activa
    
    # ACTUALIZACIÓN DE PUNTEROS 
    addi $t0, $t0, 1            # Desplazar el puntero de origen al siguiente byte
    addi $t2, $t2, 4            # Desplazar el puntero de video a la siguiente palabra
    addi $t3, $t3, 1            # Registrar el píxel procesado en el contador
    
    j    dibujar_victoria       # Ciclar para procesar el siguiente píxel

fin_programa:
    # --- CERRAR EL JUEGO ---
    li   $v0, 10                # Orden al sistema: "Termina la ejecución".
    syscall                     # ¡Adiós!
