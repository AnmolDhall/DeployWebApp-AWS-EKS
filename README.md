# DeployWebApp-AWS-EKS
Deployment of nodejs "Hello World" web application on Kubernetes cluster using AWS EKS

Create a simple web application using Node.js

Create a docker image of the web application

Push the created docker image to Docker hub registry

Create a Kubernetes Cluster using AWS EKS

Create Kubernetes workers(public and private workers)

Deploy our web application on Kubernetes

# Prerequisites
Kubectl — communication tool we will use to communicate between our Kubernetes cluster and our machine. Installation instructions available on https://kubernetes.io/docs/tasks/tools/install-kubectl/
AWS CLI — AWS tool which we will use to issue commands related to AWS configurations. To install follow https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html
Aws iam authenticator — Give permission with IAM roles to access our Kubernetes cluster. For installation https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html
Terraform — Infrastructure As Code tool. For installation https://www.terraform.io/downloads.html

Now, we can create a simple node.js web application that will print "Hello World"

Firstly, create a directory, let's say "webapp"
Now, initialize the directory with npm by running below command:
-> npm init
now it will ask few configuration info, provide the same
next run below command:
// this is a framework to build web applocations
-> npm install express --save

Now, the webapp directory contains few folders and files basically some modules and configurations. Along with these files put "index.js" file and run below command:

-> node index.js
Now the server is running, hit the browser with IP:3000
Note: use the already attached "index.js file".

Next, we can create a dockerfile and dockerize our web application.
Please use attached "Dockerfile" for the same.

Now, run the below command, from the directoy where we have the dockerfile and index.js file

#this will create the docker image and tag it with the name "webapp"
-> docker build -t webapp .

Now, we can run below command and verify the image:
docker images
webapp     latest              f9de35d95fee        About a minute ago   911MB


Next, tag and push the docker image to the repository on Docker hub
-> docker tag webapp anmoldhall/webapp:latest
-> docker push anmoldhall/webapp:latest


Now, we need to create a EKS Cluster for which we will be using Terraform(IAC tool)

Please check the attached folder "Terraformed-EKS-Cluster", which contains various files to create an eks cluster as well as the worker nodes.
Now, we can run below commands from the directory
terraform init
terraform plan
terraform apply

This will create an eks cluster and also creates the worker node.

run below command for verification:
kubectl get svc
kubectl get nodes

Now, we are ready to deploy our application
To deploy application we need to create a deployment in k8s cluster, which will deploy application on pods.
Please use the attached, "deployment.yaml" file and run the below command:
kubectl apply -f deployment.yaml
Now, check the created deployment using below command:
kubectl get deployments

Next, we will create a service so that we can access our application.
There are multiple ways to expose service, we are using "NodePort" so that we can access the application from outside as well.

Please use the attached "service.yaml" file and run below command:
kubectl apply -f service.yaml

Now, we can verify the created service by running following command:
kubectl get services

Now, we can access our application using the node ip and the nodePort.
