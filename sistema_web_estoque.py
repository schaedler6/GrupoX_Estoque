from flask import Flask, render_template, request, redirect, url_for, session
import mysql.connector

# Configuração do Flask
app = Flask(__name__)
app.secret_key = 'chave_secreta_super_segura'

# Conexão com o banco de dados
def conectar_bd():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="",  # Insira sua senha aqui
        database="superstock_solutions"
    )

# Página inicial (Login)
@app.route('/', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        senha = request.form['senha']

        conn = conectar_bd()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM usuarios WHERE email = %s AND senha_hash = SHA2(%s, 256)", (email, senha))
        usuario = cursor.fetchone()
        conn.close()

        if usuario:
            session['usuario'] = usuario
            return redirect(url_for('dashboard'))
        else:
            return render_template('login.html', erro="Credenciais inválidas!")

    return render_template('login.html')

# Página principal (Dashboard)
@app.route('/dashboard')
def dashboard():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    return render_template('dashboard.html', usuario=session['usuario'])

# Página de usuários
@app.route('/usuarios')
def usuarios():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    conn = conectar_bd()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM usuarios")
    lista_usuarios = cursor.fetchall()
    conn.close()

    return render_template('usuarios.html', usuarios=lista_usuarios)

# Página de estoque
@app.route('/estoque')
def estoque():
    if 'usuario' not in session:
        return redirect(url_for('login'))

    conn = conectar_bd()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM inventario")
    lista_estoque = cursor.fetchall()
    conn.close()

    return render_template('estoque.html', estoque=lista_estoque)

# Logout
@app.route('/logout')
def logout():
    session.pop('usuario', None)
    return redirect(url_for('login'))

# Rodar o sistema
if __name__ == '__main__':
    app.run(debug=True)
