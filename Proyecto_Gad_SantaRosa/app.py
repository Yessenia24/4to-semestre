import os
import json
import csv
from flask import Flask, render_template, request, redirect, url_for, flash
from Conexion.conexion import configurar_db 
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user
from werkzeug.security import generate_password_hash, check_password_hash
from models import Usuario

app = Flask(__name__)
app.secret_key = 'tu_clave_secreta_aqui' 

mysql = configurar_db(app)

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login' 

class Usuario(UserMixin):
    def __init__(self, id, nombre, email):
        self.id = id
        self.nombre = nombre
        self.email = email

@login_manager.user_loader
def load_user(user_id):
    cur = mysql.connection.cursor()
    cur.execute("SELECT id_usuario, nombre, mail FROM usuarios WHERE id_usuario = %s", (user_id,))
    user_data = cur.fetchone()
    cur.close()
    if user_data:
        # Aquí le agregamos str() al primer dato
        return Usuario(str(user_data[0]), user_data[1], user_data[2])
    return None

def guardar_en_archivos(datos_dict):
    try:
        ruta_data = os.path.join('inventario', 'data')
        if not os.path.exists(ruta_data):
            os.makedirs(ruta_data)

        with open(os.path.join(ruta_data, 'datos.txt'), 'a', encoding='utf-8') as f:
            f.write(f"{datos_dict['nombre']} - {datos_dict['cedula']} - {datos_dict['servicio']}\n")
        
        ruta_json = os.path.join(ruta_data, 'datos.json')
        lista_datos = []
        if os.path.exists(ruta_json):
            with open(ruta_json, 'r', encoding='utf-8') as f:
                try: lista_datos = json.load(f)
                except: lista_datos = []
        
        lista_datos.append(datos_dict)
        with open(ruta_json, 'w', encoding='utf-8') as f:
            json.dump(lista_datos, f, indent=4, ensure_ascii=False)

        ruta_csv = os.path.join(ruta_data, 'datos.csv')
        file_exists = os.path.isfile(ruta_csv)
        with open(ruta_csv, 'a', newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=['nombre', 'cedula', 'servicio'])
            if not file_exists: writer.writeheader()
            writer.writerow(datos_dict)
    except Exception as e:
        print(f"Error al guardar archivos: {e}")

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        pwd = request.form['password']
        print(f"Intentando entrar con: {email}") # Esto saldrá en la terminal

        cur = mysql.connection.cursor()
        cur.execute("SELECT id_usuario, nombre, mail, password FROM usuarios WHERE mail = %s", (email,))
        user_data = cur.fetchone()
        cur.close()

        if user_data:
            print(f"Usuario encontrado en BD: {user_data[1]}")
            if check_password_hash(user_data[3], pwd):
                print("¡La contraseña coincide!")
                user_obj = Usuario(str(user_data[0]), user_data[1], user_data[2])
                login_user(user_obj)
                return redirect(url_for('index'))
            else:
                print("La contraseña NO coincide (Hash incorrecto)")
        else:
            print("Correo no encontrado en la base de datos")
            
        flash("Error en los datos")
        return redirect(url_for('login'))
            
    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('login'))

# --- 5. RUTAS DEL SISTEMA (CON PROTECCIÓN @login_required) ---

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/ciudadanos')
@login_required # Protegido
def ciudadanos():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM ciudadano")
    data = cur.fetchall()
    cur.close()
    return render_template('ciudadanos.html', ciudadanos=data)

@app.route('/servicios')
@login_required # Protegido
def servicios():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM tramite")
    datos = cur.fetchall()
    cur.close()
    return render_template('servicios.html', lista_tramites=datos)

@app.route('/crear_servicio', methods=['POST'])
@login_required # Protegido
def crear_servicio():
    nombre = request.form.get('nombre')
    costo = request.form.get('costo') 
    estado = request.form.get('estado')

    cur = mysql.connection.cursor()
    cur.execute("""
        INSERT INTO tramite (tipo_tramite, cedula_ciudadano, estado, fecha_solicitud) 
        VALUES (%s, %s, %s, NOW())
    """, (nombre, costo, estado))
    mysql.connection.commit()
    cur.close()

    datos_dict = {'nombre': nombre, 'cedula': costo, 'servicio': estado}
    guardar_en_archivos(datos_dict)
    return redirect(url_for('servicios'))


@app.route('/usuarios')
@login_required 
def ver_usuarios():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM usuarios")
    data = cur.fetchall()
    cur.close()
    return render_template('usuarios.html', usuarios=data)

# AQUÍ VA EL PUNTO 2 ACTUALIZADO:
@app.route('/crear_usuario', methods=['POST'])
def crear_usuario():
    nombre = request.form.get('nombre')
    mail = request.form.get('mail')
    password = request.form.get('password')

    password_encriptada = generate_password_hash(password)

    cur = mysql.connection.cursor()
    # Importante: Guardamos 'password_encriptada', no 'password'
    cur.execute("INSERT INTO usuarios (nombre, mail, password) VALUES (%s, %s, %s)", 
                (nombre, mail, password_encriptada)) 
    mysql.connection.commit()
    cur.close()
    
    flash("Usuario creado correctamente") # Mensaje de confirmación
    return redirect(url_for('ver_usuarios'))

@app.route('/eliminar_tramite/<int:id>')
@login_required
def eliminar_tramite(id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM tramite WHERE id_tramite = %s", (id,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('servicios'))

@app.route('/editar_tramite/<int:id>')
@login_required
def editar_tramite(id):
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM tramite WHERE id_tramite = %s", (id,))
    data = cur.fetchone()
    cur.close()
    return render_template('editar_tramite.html', tramite=data)

@app.route('/actualizar_tramite/<int:id>', methods=['POST'])
@login_required
def actualizar_tramite(id):
    tipo = request.form['nombre']
    cedula = request.form['cedula']
    estado = request.form['estado']
    
    cur = mysql.connection.cursor()
    cur.execute("""
        UPDATE tramite 
        SET tipo_tramite = %s, cedula_ciudadano = %s, estado = %s 
        WHERE id_tramite = %s
    """, (tipo, cedula, estado, id))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('servicios'))
        
if __name__ == '__main__':
    app.run(debug=True)
    