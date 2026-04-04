# models/entidades.py
from flask_login import UserMixin

class Usuario(UserMixin):
    def __init__(self, id, nombre, email):
        self.id = id
        self.nombre = nombre
        self.email = email

class Ciudadano:
    def __init__(self, cedula, nombre, apellido, direccion):
        self.cedula = cedula
        self.nombre = nombre
        self.apellido = apellido
        self.direccion = direccion