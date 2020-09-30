#!/usr/bin/python3
from peewee import *
import os

path = os.getcwd()
if 'mariadb' in path:
   base = 'devteam504'
   user = 'devteam504'
   passwd = 'Sup3rP4ssw0rd'
   db = MySQLDatabase(base, user=user, passwd=passwd, host='localhost', port=3306)
else:
    base = 'devteam504.db'
    db = SqliteDatabase(base)
nmax = 25

class Speaker(Model):
    usuario = CharField(max_length=20,unique=True)
    clave = CharField(max_length=80)
    nombre = CharField(max_length=200)

    class Meta:
        database = db
        db_table = 'speakers'

def crear():
    MODELS = [ Speaker ]
    db.connect()
    db.create_tables(MODELS)

def insertar():
    print('Insertar registros en tabla speakers de base de datos %s...' % (base), end='')
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
    print('Consultar registros en tabla speakers de base de datos %s...' % (base))
    for speaker in Speaker.select():
        print(speaker.id, speaker.usuario, speaker.clave, speaker.nombre)

def eliminar():
    print('Eliminar registros en tabla speakers de base de datos %s...' % (base), end='')
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
    if 'sqlite' in path:
        import os
        if os.path.exists(base):
            os.remove(base)

crear()
insertar()
consultar()
eliminar()
destruir()
