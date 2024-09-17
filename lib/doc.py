import requests
f='x+y'
url='https://3d7d8b0c-4e24-47a6-8778-aa1b83fd2932-00-3mctl2qlxcx1v.picard.replit.dev/grafico'
parametros={'function':f}
response=requests.get(url,params=parametros)
print (response.text)