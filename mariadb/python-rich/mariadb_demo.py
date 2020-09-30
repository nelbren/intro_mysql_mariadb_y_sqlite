#!/usr/bin/python3
from peewee import *

base = 'devteam504'
tabla = 'speaker'
user = 'devteam504'
passwd = 'Sup3rP4ssw0rd'
nmax = 100
db = MySQLDatabase(base, user=user, passwd=passwd, host='localhost', port=3306)

class Speaker(Model):
    usuario = CharField(max_length=20,unique=True)
    clave = CharField(max_length=80)
    nombre = CharField(max_length=200)

    class Meta:
        database = db
def crear():
    MODELS = [ Speaker ]
    db.connect()
    db.create_tables(MODELS)

def insertar():
    print('Insertar registros en tabla %s de base de datos %s...' % (tabla, base), end='')
    count = Speaker.select().count()
    if count > nmax:
        print('Ya.')
        return
    n = 0
    while n < nmax:
        usuario = "USUARIO_%s" % n
        clave = "CLAVE_%s" % n
        nombre = "NOMBRE_%s" % n
        speaker = Speaker(usuario=usuario, clave=clave, nombre=nombre)
        speaker.save() 
        n += 1
        print('.', end='', flush=True)
    print('Hecho.')

def consultar():
    from rich.console import Console
    from rich.table import Table
    table = Table(title="Registros en tabla %s de base de datos %s" % (tabla, base))

    table.add_column("Id", justify="right", style="cyan", no_wrap=True)
    table.add_column("Usuario", style="magenta")
    table.add_column("Clave", justify="right", style="red")
    table.add_column("Nombre", justify="right", style="green")

    for speaker in Speaker.select():
        table.add_row(str(speaker.id), speaker.usuario, speaker.clave, speaker.nombre)
    console = Console()
    console.print(table)

def eliminar():
    print('Eliminar registros en tabla %s de base de datos %s...' % (tabla, base), end='')
    nmax = Speaker.select().count()
    if not nmax:
        print('Ya.')
        return
    n = 0
    while n < nmax:
        speaker = Speaker.select().first()
        speaker.delete_instance()
        n += 1
        print('.', end='', flush=True)
    print('Hecho.')

def destruir():
    import os
    if os.path.exists(base):
        os.remove(base)

#crear()
#insertar()
consultar()
#eliminar()
#destruir()
