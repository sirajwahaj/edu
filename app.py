from flask import Flask, render_template, request, redirect, url_for
from flask_wtf import FlaskForm
from wtforms import StringField, DateField, BooleanField, SubmitField
from wtforms.validators import DataRequired
from datetime import date
import psycopg2
from config import config

app = Flask(__name__)
app.config['SECRET_KEY'] = 'AbC'


class SignupForm(FlaskForm):
    fname = StringField('First Name', validators=[DataRequired()])
    lname = StringField('Last Name', validators=[DataRequired()])
    birth_date = DateField(
        'Date of Birth', format='%Y-%m-%d', validators=[DataRequired()])
    submit = SubmitField('Register')


class SearchForm(FlaskForm):
    student_name = StringField('Enter Student Name')
    submit = SubmitField('Search')


params = config()
conn = psycopg2.connect(**params)


@app.route('/search', methods=['POST', 'GET'], endpoint="search")
def inject():
    form = SearchForm()
    if form.validate_on_submit():
        student = form.student_name.data
        cursor = conn.cursor()
        parts = [
            "SELECT * FROM person WHERE CONCAT(prs_name,prs_lastname) ILIKE '%", student, "%';"]
        query = ''.join(parts)
        cursor.execute(query)
        rows = cursor.fetchall()
        conn.commit()
        cursor.close()
        return render_template('students.html', students=rows)
    return render_template('inject.html', form=form)


@app.route('/students', methods=['GET'])
def students():
    # Check if it's a GET request
    if request.method == 'GET':
        cursor = conn.cursor()
        cursor.execute("""
            SELECT * from basic_information
        """)
        rows = cursor.fetchall()
        cursor.close()
        return render_template('students.html', students=rows)


@app.route('/', methods=['GET', 'POST'])
def register():
    form = SignupForm()

    if form.validate_on_submit():
        fname = form.fname.data
        lname = form.lname.data
        birth_date = form.birth_date.data

        cursor = conn.cursor()

        # Use parameterized query to avoid SQL injection
        cursor.execute("""
            INSERT INTO person (prs_name, prs_lastname, prs_birth_date)
            VALUES (%s, %s, %s)
            RETURNING person_id
        """, (fname, lname, birth_date))

        registration_id = cursor.fetchone()[0]

        conn.commit()
        cursor.close()

        return f'Registration successful! Person ID: {registration_id}'

    return render_template('registration_form.html', form=form)


if __name__ == '__main__':
    app.run(debug=True)
