from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Tramite(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    tipo = db.Column(db.String(100), nullable=False)  # Ejemplo: "Predios", "Agua"
    descripcion = db.Column(db.String(200))

    def __repr__(self):
        return f'<Tramite {self.nombre}>'
        