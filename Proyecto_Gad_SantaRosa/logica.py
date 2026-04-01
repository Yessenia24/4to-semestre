import sqlite3

# Clase que representa un solo ítem (Tu "Producto")
class Tramite:
    def __init__(self, id, nombre, costo, estado):
        self.id = id
        self.nombre = nombre
        self.costo = costo
        self.estado = estado

# Clase que gestiona la colección y la base de datos
class GestionInventario:
    def __init__(self):
        self.db_name = "gad_santarosa.db"
        self.conectar_db()

    def conectar_db(self):
        conn = sqlite3.connect(self.db_name)
        cursor = conn.cursor()
        cursor.execute('''CREATE TABLE IF NOT EXISTS servicios 
                          (id INTEGER PRIMARY KEY AUTOINCREMENT, 
                           nombre TEXT, costo REAL, estado TEXT)''')
        conn.commit()
        conn.close()

    def añadir_producto(self, nombre, costo, estado):
        conn = sqlite3.connect(self.db_name)
        cursor = conn.cursor()
        cursor.execute("INSERT INTO servicios (nombre, costo, estado) VALUES (?, ?, ?)", 
                       (nombre, costo, estado))
        conn.commit()
        conn.close()

    def mostrar_todos(self):
        conn = sqlite3.connect(self.db_name)
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM servicios")
        filas = cursor.fetchall()
        conn.close()
        # Aquí usamos una LISTA de DICCIONARIOS (Colecciones)
        return [{"id": f[0], "nombre": f[1], "costo": f[2], "estado": f[3]} for f in filas]

    def eliminar_por_id(self, id):
        conn = sqlite3.connect(self.db_name)
        cursor = conn.cursor()
        cursor.execute("DELETE FROM servicios WHERE id = ?", (id,))
        conn.commit()
        conn.close()