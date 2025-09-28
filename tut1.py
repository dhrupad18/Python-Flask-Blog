from flask import Flask, render_template
app= Flask(__name__)
@app.route("/")

def hello():
    return render_template('index1.html')

@app.route("/dhrupad")

def dhrupad():
    name= "DHRUPAD"
    return render_template('about1.html', name=name)

app.run(debug=True)