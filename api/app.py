from flask import Flask, request
import socket      

app = Flask(__name__)

@app.route('/')
@app.route('/index.html')
def hello_world():
    file = open("index.html")
    file_content = file.read()
    file.close()
    return file_content

@app.route('/get_ip')
def ip():
    hostname = socket.gethostname()    
    IPAddr = socket.gethostbyname(hostname)
    return IPAddr

@app.route('/echo')
def echo():
    user_str = request.args.get('str')
    return user_str

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
    
