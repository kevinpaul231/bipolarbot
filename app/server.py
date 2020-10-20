from flask import Flask
import bipolarbot
app = Flask(__name__)

@app.route('/api/v1/poke')
def poke():
    return bipolarbot.getBiPolar()

if __name__ == "__main__":
	app.run(host="0.0.0.0", port="6666",debug=True)
