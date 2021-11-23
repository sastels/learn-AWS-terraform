import time
from locust import HttpUser, task, constant

class QuickstartUser(HttpUser):
    wait_time = constant(60)
    @task
    def hello_world(self):
        self.client.get("/")

