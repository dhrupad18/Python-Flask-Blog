import requests
from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
from werkzeug.utils import secure_filename
import json
import os
import math
from datetime import datetime


with open('config.json', 'r') as c:
    params= json.load(c) ["params"]
    local_server=True

app= Flask(__name__)
app.secret_key= 'super-secret-key'
app.config['UPLOAD_FOLDER']= params['upload_location']
app.config.update(
    MAIL_SERVER= 'smtp.gmail.com',
    MAIL_PORT= 465,
    MAIL_USE_SSL=True,
    MAIL_USERNAME= params['gmail-user'],
    MAIL_PASSWORD= params['gmail-password']
)

mail= Mail(app)

if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

db= SQLAlchemy(app)

class Contacts(db.Model):
    s_no=db.Column(db.Integer, primary_key=True)
    name=db.Column(db.String(120), unique=False, nullable=False)
    email=db.Column(db.String(120), unique=True, nullable=False)
    phone_no=db.Column(db.String(12), unique=True, nullable=False)
    message=db.Column(db.String(120), nullable=True)
    date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)

class Posts(db.Model):
    s_no=db.Column(db.Integer, primary_key=True)
    Title=db.Column(db.String(110), unique=False, nullable=True)
    slug=db.Column(db.String(50), unique=True, nullable=False)
    Content=db.Column(db.String(11000), nullable=True)
    tagline = db.Column(db.String(50), nullable=True)
    Date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    img_file = db.Column(db.String(15), nullable=True)


@app.route("/")
def home():
    # Get the page number from the URL, default to 1 if not present
    page = request.args.get('page', 1, type=int)

    # Use paginate() to fetch only the posts for the current page
    posts = Posts.query.paginate(page=page, per_page=int(params['no_of_posts']))

    # Pass the entire pagination object to the template
    return render_template('index.html', params=params, posts=posts)

    if page==1:
        prev="#"
        next="/?page="+str(page+1)
    elif page==last:
        prev = "/?page=" + str(page - 1)
        next = "#"
    else:
        prev= "/?page=" + str(page - 1)
        next= "/?page="+str(page+1)

    # Send the list of posts to the template
    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)

@app.route("/post/<string:post_slug>", methods=['GET'])

def post_route(post_slug):
    post= Posts.query.filter_by(slug=post_slug).first()

    # FIRST, check if the post was found
    if not post:
        return "Post not found", 404  # Return a 404 error if it's not found

    # THEN, if it was found, render the template
    return render_template('post.html', params=params, post=post)

@app.route("/about")
def about():
    return render_template('about.html', params=params)

@app.route("/dashboard", methods=['GET','POST'])
def dashboard():
    if 'user' in session and session['user']==params['admin_user']:
        posts = Posts.query.all()
        return render_template("dashboard.html", params=params, posts=posts)

    if request.method=="POST":
        username = request.form.get("uname")
        userpass = request.form.get("upass")
        if username==params['admin_user'] and userpass==params['admin_password']:
            # set the session variable
            session['user']=username
            posts = Posts.query.all()
            return render_template("dashboard.html", params=params, posts=posts)
    return render_template("login.html", params=params)

@app.route("/edit/<string:s_no>", methods=['GET', 'POST'])
def edit(s_no):
    if 'user' in session and session['user']==params['admin_user']:
        if request.method=='POST':
            box_title= request.form.get('title')
            tline= request.form.get('tline')
            slug= request.form.get('slug')
            content= request.form.get('content')
            img_file= request.form.get('img_file')
            date= datetime.now()

            if s_no=='0':
                post= Posts(Title=box_title, slug=slug, Content=content, tagline=tline, img_file=img_file, Date=date)
                db.session.add(post)
                db.session.commit()
            else:
                post= Posts.query.filter_by(s_no=s_no).first()
                post.Title=box_title
                post.slug=slug
                post.Content=content
                post.tagline=tline
                post.img_file=img_file
                post.Date=date
                db.session.commit()
                return redirect('/edit/'+s_no)

        post = Posts.query.filter_by(s_no=s_no).first()
        return render_template('edit.html', params=params, post=post)

@app.route("/uploader", methods=['GET', 'POST'])
def uploader():
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "Uploaded Successfully"

@app.route("/delete/<string:s_no>", methods=['GET', 'POST'])
def delete(s_no):
    if 'user' in session and session['user']==params['admin_user']:
        post=Posts.query.filter_by(s_no=s_no).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')

@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/')

@app.route("/contact", methods=['GET', 'POST'])
def contact():
    if request.method == 'POST':
        '''Add entry to the database'''
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')

        entry = Contacts(name=name, email=email, phone_no=phone, message=message)
        db.session.add(entry)
        db.session.commit()
        mail.send_message ('New message from '+ name, sender=params['gmail-user'], recipients=[params['gmail-user']],
                           body= message+"\n"+phone
                           )
    return render_template('contact.html', params=params)

app.run(debug=True)