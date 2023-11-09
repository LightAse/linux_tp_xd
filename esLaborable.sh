#!/bin/sh

# Función para determinar si una fecha es un día laborable o no
esLaborable() {
    fecha="$1"
    dia_semana=$(date -d "$fecha" +%u)

    # Verifica si la fecha es un día no laborable (fin de semana)
    if [ $dia_semana -ge 6 ]; then
      echo "La fecha $fecha es un día no laborable (fin de semana)."
      return 1
    fi

    # Descarga la lista de feriados desde la URL proporcionada
    lista_feriados=$(python3 -c "
import requests

def descargar_feriados(url):
    response = requests.get(url)

    if response.status_code == 200:
        return response.text.splitlines()
    else:
        return []

url_feriados = 'http://servicios.infoleg.gob.ar/infolegInternet/anexos/170000-174999/174389/norma.htm'
lista_feriados = descargar_feriados(url_feriados)
print('\n'.join(lista_feriados))
")

    # Resto de tu función esLaborable (modificado para Python)
    fecha_obj=$(date -d "$fecha" +"%Y-%m-%d")
    resultado=$(echo "$lista_feriados" | python3 -c "
import datetime

def esLaborable(fecha, lista_feriados):
    fecha_obj = datetime.datetime.strptime(fecha, '%Y-%m-%d')
    dia_semana = fecha_obj.weekday()

    if dia_semana >= 5:
        return f'La fecha {fecha} es un día no laborable (fin de semana).'

    if fecha in lista_feriados:
        return f'La fecha {fecha} es un día no laborable (feriado).'

    return f'La fecha {fecha} es un día laborable.'

lista_feriados = '''$(cat)'''
fecha_ejemplo = '2023-11-07'
resultado = esLaborable(fecha_ejemplo, lista_feriados)
print(resultado)
")

    echo "$resultado"
    return 0
}

# Ejemplo de uso
esLaborable "2023-11-07"    
