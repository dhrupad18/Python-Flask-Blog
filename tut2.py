from flask import Flask, render_template
app= Flask(__name__)
@app.route("/")

def hello():
    return render_template('index1.html')

@app.route("/dhrupad")

def about1():
    name= "DHRUPAD"
    return render_template('about1.html', name=name)

@app.route("/bootstrap")
def bootstrap():
    return render_template('bootstrap.html')

app.run(debug=True)