from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/ciudadanos')
def ciudadanos():
    lista_ciudadanos = [
        {'cedula': '1500123456', 'nombre': 'Keiko Yanacallo', 'contacto': '0987654321', 'direccion': 'San José'},
        {'cedula': '1500987654', 'nombre': 'Yessenia Rodriguez', 'contacto': '0982521271', 'direccion': 'El Chaco'}
    ]
    return render_template('ciudadanos.html', ciudadanos=lista_ciudadanos)

@app.route('/tramites')
def tramites():
    lista_tramites = [
        {'tipo': 'Uso de Suelo', 'estado': 'Completado', 'fecha': '2026-03-20'},
        {'tipo': 'Certificado', 'estado': 'Pendiente', 'fecha': '2026-03-25'}
    ]
    return render_template('tramites.html', tramites=lista_tramites)

# AGREGA ESTA PARTE PARA QUITAR EL ERROR
@app.route('/about')
def about():
    return render_template('about.html')

if __name__ == '__main__':
    app.run(debug=True)