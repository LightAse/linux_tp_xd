#!/bin/bash

# Función para determinar el tipo de día (feriado, no laborable, laborable)
esTipoDia() {
    fecha="$1"
    lista_feriados=("$2")

    dia_semana=$(date -d "$fecha" +%u)

    # Verifica si la fecha es un día no laborable (fin de semana)
    if [ $dia_semana -ge 6 ]; then
        echo "La fecha $fecha es un día no laborable (fin de semana)."
        return
    fi

    # Resto de tu función esTipoDia (modificado para Bash)
    fecha_obj=$(date -d "$fecha" +"%Y-%m-%d")

    # Verifica si la fecha coincide con un feriado nacional
    if [[ " ${lista_feriados[@]} " =~ " $fecha_obj" ]]; then
        echo "La fecha $fecha es un día no laborable (feriado)."
    else
        echo "La fecha $fecha es un día laborable."
    fi
}

# Descarga la lista de feriados desde la URL proporcionada
url_feriados='http://servicios.infoleg.gob.ar/infolegInternet/anexos/170000-174999/174389/norma.htm'

# Extrae las fechas con nombres de meses y ajusta el formato a YYYY-MM-DD
lista_feriados=($(curl -s "$url_feriados" | grep -oP '(\d{1,2} de [^\s]+)' | sed 's/ de / /' | while read fecha; do date -d "$fecha" +"%Y-%m-%d"; done))

# Obtén la fecha como argumento de la consola
fecha_consola="$1"

# Ajusta el formato de la fecha para comparación
fecha_consola_ajustada=$(date -d "$fecha_consola" +"%Y-%m-%d")

# Llama a la función esTipoDia con el argumento de la consola
esTipoDia "$fecha_consola_ajustada" "${lista_feriados[@]}"#!/bin/bash

# Función para determinar el tipo de día (feriado, no laborable, laborable)
esTipoDia() {
    fecha="$1"
    lista_feriados=("$2")

    dia_semana=$(date -d "$fecha" +%u)

    # Verifica si la fecha es un día no laborable (fin de semana)
    if [ $dia_semana -ge 6 ]; then
        echo "La fecha $fecha es un día no laborable (fin de semana)."
        return
    fi

    # Resto de tu función esTipoDia (modificado para Bash)
    fecha_obj=$(date -d "$fecha" +"%Y-%m-%d")

    # Verifica si la fecha coincide con un feriado nacional
    if [[ " ${lista_feriados[@]} " =~ " $fecha_obj" ]]; then
        echo "La fecha $fecha es un día no laborable (feriado)."
    else
        echo "La fecha $fecha es un día laborable."
    fi
}

# Descarga la lista de feriados desde la URL proporcionada
url_feriados='http://servicios.infoleg.gob.ar/infolegInternet/anexos/170000-174999/174389/norma.htm'

# Extrae las fechas con nombres de meses y ajusta el formato a YYYY-MM-DD
lista_feriados=($(curl -s "$url_feriados" | grep -oP '(\d{1,2} de [^\s]+)' | sed 's/ de / /' | while read fecha; do date -d "$fecha" +"%Y-%m-%d"; done))

# Obtén la fecha como argumento de la consola
fecha_consola="$1"

# Ajusta el formato de la fecha para comparación
fecha_consola_ajustada=$(date -d "$fecha_consola" +"%Y-%m-%d")

# Llama a la función esTipoDia con el argumento de la consola
esTipoDia "$fecha_consola_ajustada" "${lista_feriados[@]}"
