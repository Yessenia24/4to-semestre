from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    # Cambiamos el mensaje para que cumpla con el nombre de tu negocio
    return '<h1>Bienvenido a Granja Los Potrillos Aley</h1><p>Terneros de genética, pollitos y huevos frescos.</p>'

if __name__ == '__main__':
    app.run(debug=True)