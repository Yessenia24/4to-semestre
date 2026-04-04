from flask_mysqldb import MySQL

def configurar_db(app):
    # Configuración para conectar Flask con XAMPP (MySQL)
    app.config['MYSQL_HOST'] = 'localhost'
    app.config['MYSQL_USER'] = 'root'
    app.config['MYSQL_PASSWORD'] = ''  
    app.config['MYSQL_DB'] = 'gad_parroquial' 
    
    mysql = MySQL(app)
    return mysql