#!/usr/bin/python3
from peewee import *
import os, random

path = os.getcwd()
if '/mariadb/' in path:
   base = 'devteam504'
   user = 'devteam504'
   passwd = 'Sup3rP4ssw0rd'
   db = MySQLDatabase(base, user=user, passwd=passwd, host='localhost', port=3306)
else:
    base = 'devteam504.db'
    # Ensure foreign-key constraints are enforced with pragmas
    db = SqliteDatabase(base, pragmas={'foreign_keys': 1})
nmax = 51

class BaseModel(Model):
    class Meta:
        database = db

class Speaker(BaseModel):
    usuario = CharField(max_length=20,unique=True)
    clave = CharField(max_length=80)
    nombre = CharField(max_length=200)
    correo = CharField(max_length=50, unique=True, null=True)
    activo = BooleanField(default=True)

    class Meta:
        db_table = 'speakers'

    def __str__(self):
       return self.usuario


class Webminar(BaseModel):
   titulo = CharField(max_length=250)
   speaker = ForeignKeyField(Speaker, backref='webminars', on_delete='CASCADE')

   class Meta:
       db_table = 'webminars'

   def __str__(self):
       return self.titulo


def crear():
    print("Crear tabla speakers en base de datos %s..." % base)
    MODELS = [ Speaker, Webminar ]
    db.connect()
    db.create_tables(MODELS)

def insertar():
    print('Insertar registros en tabla speakers de base de datos %s...' % (base), end='')
    count = Speaker.select().count()
    if count > nmax:
        print('Ya.')
        return
    n = 0
    r = random.randint(1, nmax)
    while n < nmax:
        if n == r:
            usuario = 'nelbren'
            clave = 'ultrasecret'
            nombre = 'Martin Cuellar'
            correo = usuario + '@gmail.com'
            TITULOS = ['Introducción a la Distribución Debian GNU/Linux 10.4', 'Introducción a MySQL, MariaDB y SQLite']
            for t in TITULOS:
                webminar = Webminar.create(titulo=t, speaker=speaker)
                if webminar.id:
                    print('w', end='')
            m = 'M'
        else:
           usuario = 'USUARIO_%s' % n
           clave = 'CLAVE_%s' % n
           nombre = 'NOMBRE_%s' % n
           correo = usuario.lower() + '@correo.com'
           m = 'S'
        speaker = Speaker(usuario=usuario, clave=clave, nombre=nombre, correo=correo)
        speaker.save() 
        print(m, end='', flush=True)
        n += 1
    print('Hecho.')

def consultar():
    print('Consultar registros en tabla speakers de base de datos %s...' % (base))
    for speaker in Speaker.select():
        print(speaker.id, speaker.usuario, speaker.clave, speaker.nombre, speaker.correo, speaker.activo)
        for w in speaker.webminars:
            print('  -', w.titulo)

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
    if not '/sqlite/' in path:
        if os.path.exists(base):
            os.remove(base)

crear()
insertar()
consultar()
eliminar()
destruir()
