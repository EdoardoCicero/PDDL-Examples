import requests, sys

data = {'domain': open(sys.argv[1], 'r').read(),
        'problem': open(sys.argv[2], 'r').read()}

resp = requests.post('http://solver.planning.domains/solve',
                     verify=False, json=data).json()

for i in resp['result']['plan']:
	print(i['name'])

def dumPlan(domain_path, problem_path, name):

	data = {'domain': open(domain_path, 'r').read(),
        'problem': open(problem_path, 'r').read()}

	resp = requests.post('http://solver.planning.domains/solve',verify=False, json=data).json()

	for i in resp['result']['plan']:
		print(i['name'])
