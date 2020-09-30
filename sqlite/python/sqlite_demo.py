#!/usr/bin/python3
from peewee import *

base = 'devteam504.db'
tabla = 'speaker'
nmax = 100
db = SqliteDatabase(base)

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
    print('Consultar registros en tabla %s de base de datos %s...' % (tabla, base))
    for speaker in Speaker.select():
        print(speaker.id, speaker.usuario, speaker.clave, speaker.nombre)

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
        if input('Esta seguro? (Si=Aceptar): ') == 'Si':
            os.remove(base)

crear()
insertar()
consultar()
eliminar()
destruir()
