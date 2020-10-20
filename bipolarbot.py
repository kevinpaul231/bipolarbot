import requests
from random import randint

def getInsult():
	r = requests.get("https://evilinsult.com/generate_insult.php?lang=en&type=json")
	if r.status_code == 200:
		j = r.json()
		return j['insult']
	else:
		return "Something went wrong!"


def getCompliment():
	r = requests.get("https://complimentr.com/api")
	if r.status_code == 200:
		j = r.json()
		return j['compliment']
	else:
		return "Something went wrong!"

def getBiPolar():
	choice = randint(0,1)
	if choice == 0:
		return getInsult() + "\n"
	else:
		return getCompliment() + "\n"


def main():
	print(getBiPolar())

if __name__ == "__main__":
	main()

