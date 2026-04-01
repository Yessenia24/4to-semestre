from flask import Flask, render_template, request, redirect, url_for
from logica import GestionInventario # Importamos tu clase POO

app = Flask(__name__)
gestion = GestionInventario() # Instanciamos el objeto

@app.route('/')
def index():
    return render_template('index.html')

# RUTA PARA MOSTRAR (READ)
@app.route('/servicios')
def servicios():
    datos = gestion.mostrar_todos() # Usamos el método de la clase
    return render_template('servicios.html', servicios=datos)

# RUTA PARA AÑADIR (CREATE)
@app.route('/crear_servicio', methods=['POST'])
def crear_servicio():
    nombre = request.form.get('nombre')
    costo = request.form.get('costo')
    estado = request.form.get('estado')
    gestion.añadir_producto(nombre, costo, estado)
    return redirect(url_for('servicios'))

# RUTA PARA ELIMINAR (DELETE)
@app.route('/eliminar/<int:id>')
def eliminar(id):
    gestion.eliminar_por_id(id)
    return redirect(url_for('servicios'))