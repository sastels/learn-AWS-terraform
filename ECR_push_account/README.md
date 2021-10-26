## ECR user

* create two ECR repos
* create a user account that can be used to push to one of them but not the other
* store the user access key in Secrets Manager for later extraction

## Usage

Run
```
terraform init
terraform apply
```

Retrieve the `access_id` and `access_secret` from Secrets Manager, and use them in `aws configure`.

Then `docker tag` and `docker push` an image into the `demo` repo.

Note that you cannot push to the `very_private` repo.
