import requests
import time

route = "https://api.staging.notification.cdssandbox.xyz"

route_lambda = "https://api-lambda.staging.notification.cdssandbox.xyz"
route_k8s = "https://api-k8s.staging.notification.cdssandbox.xyz"

hits = {}


lambda_text = requests.get(route_lambda).text
k8s_text = requests.get(route_k8s).text

text_mapping = {lambda_text: 'lambda', k8s_text: 'k8s'}
values = {'lambda': 0, 'k8s': 0}
total = 0

while (1):
    response = requests.get(route).text
    total += 1
    values[text_mapping[response]] += 1
    lambda_percent = values['lambda'] * 100.0 / total
    k8s_percent =  values['k8s'] * 100.0 / total
    print(f"{total:3d} :  lambda: {lambda_percent:.1f} %     k8s: {k8s_percent:.1f} %")
    time.sleep(0.5)
