from flask import Flask, render_template, request
from flask_mysqldb import MySQL


app = Flask(__name__)
app.debug = True

app.config['MYSQL_HOST'] = 'mysql'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'admin'
app.config['MYSQL_DB'] = 'flask_db'

mysql = MySQL(app)

@app.route('/')
@app.route('/Home')
def home():
    return render_template('home.html', title="Home")

@app.route('/About', methods=['GET', 'POST'])
def about():
    if request.method == "POST":
        details = request.form
        firstName = details['fname']
        lastName = details['lname']
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO MyUsers(firstName, lastName) VALUES (%s, %s)", (firstName, lastName))
        mysql.connection.commit()
        cur.close()
        return 'success'
    return render_template('about.html', title="About")

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)