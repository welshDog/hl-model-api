import yaml
p='docker-compose.yml'
try:
    yaml.safe_load(open(p))
    print('ok')
except Exception as e:
    print('ERROR',e)
