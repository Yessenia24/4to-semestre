# services/gestion_service.py

def obtener_tramites(mysql):
    cur = mysql.connection.cursor()
    cur.execute("SELECT id_tramite, tipo_tramite, cedula_ciudadano, estado FROM tramite")
    datos = cur.fetchall()
    cur.close()
    return datos

def eliminar_tramite_db(mysql, id_tramite):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM tramite WHERE id_tramite = %s", (id_tramite,))
    mysql.connection.commit()
    cur.close()