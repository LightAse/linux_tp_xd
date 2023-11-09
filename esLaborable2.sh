#!/bin/bash

# Función para determinar si una fecha es un día laborable o no
esLaborable() {
    fecha="$1"
    lista_feriados=("$2")

    dia_semana=$(date -d "$fecha" +%u)

    # Verifica si la fecha es un día no laborable (fin de semana)
    if [ $dia_semana -ge 6 ]; then
        echo "La fecha $fecha es un día no laborable (fin de semana)."
        return
    fi

    # Resto de tu función esLaborable (modificado para Bash)
    fecha_obj=$(date -d "$fecha" +"%Y-%m-%d")

    if [[ " ${lista_feriados[@]} " =~ " $fecha_obj " ]]; then
        echo "La fecha $fecha es un día no laborable (feriado)."
    else
        echo "La fecha $fecha es un día laborable."
    fi
}

# Descarga la lista de feriados desde la URL proporcionada
url_feriados='http://servicios.infoleg.gob.ar/infolegInternet/anexos/170000-174999/174389/norma.htm'
lista_feriados=($(curl -s "$url_feriados" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}'))

# Ejemplo de uso
esLaborable "2023-11-07" "${lista_feriados[@]}"
