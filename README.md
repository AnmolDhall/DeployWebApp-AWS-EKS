# Overview

Deployment of nodejs "Hello World" web application on Kubernetes cluster using AWS EKS

##### Steps
Create a simple web application using Node.js

Create a docker image of the web application

Push the created docker image to Docker hub registry

Create a Kubernetes Cluster using AWS EKS

Create Kubernetes workers(public and private workers)

Deploy web application on Kubernetes

# Prerequisites
Kubectl — communication tool we will use to communicate between our Kubernetes cluster and our machine. Installation instructions available on https://kubernetes.io/docs/tasks/tools/install-kubectl/

AWS CLI — AWS tool which we will use to issue commands related to AWS configurations. To install follow https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html

AWS IAM authenticator — Give permission with IAM roles to access our Kubernetes cluster. For installation https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html

Terraform — Infrastructure As Code tool. For installation https://www.terraform.io/downloads.html

# Create web application
Now, create a simple node.js web application that will print "Hello World"

Create a directory, named as "webapp".

Initialize the directory with npm by running below command:

-> npm init

Provide configuration information such as name,version etc. and run below command:

-> npm install express --save

Above commands will generate some modules and configuration files in the webapp directory. Along with these files, put "index.js" file and run below command:

-> node index.js

Now, the server is running, hit the browser with IP:3000

**Note**: use the already attached "index.js file".

# Dockerize the web application

Next,create a dockerfile and dockerize the web application.

**Note**: Use attached "Dockerfile".

Run the below command from the webapp directoy where dockerfile and index.js file exist.

*this will create the docker image and tag it with the name "webapp"*

-> docker build -t webapp .

 Run below command and verify the image:

-> docker images
webapp     latest              f9de35d95fee        About a minute ago   911MB


Now, tag and push the docker image to the repository on Docker hub

-> docker tag webapp anmoldhall/webapp:latest
-> docker push anmoldhall/webapp:latest

# Provision Kuberentes EKS Cluster using Terraform

Create an EKS Cluster using Terraform(IAC tool)

Check the attached directory *"Terraformed-EKS-Cluster"*, which contains various files to create an EKS cluster as well as the worker nodes.

Run below commands from the Terraformed-EKS-Cluster directory

-> terraform init

-> terraform plan

-> terraform apply

This will create an EKS cluster and also creates the worker node.

Run below command for verification:

-> kubectl get svc

-> kubectl get nodes

# Deploy application on to the K8s cluster

Now, deploy the web application

To deploy application, create a deployment in k8s cluster, which will deploy application on pods.

**Note:** Use the attached "deployment.yaml" file and run the below command:

-> kubectl apply -f deployment.yaml

Now, check the created deployment using below command:

-> kubectl get deployments

Next, create a service to access web application.

*There are multiple ways to expose service, we are using "NodePort" so that we can access the application from outside as well.*

 **Note:** Use the attached "service.yaml" file and run below command:
 
-> kubectl apply -f service.yaml

Verify the created service by running following command:

-> kubectl get services

Finally, access the web application using the node ip and the nodePort.
