 # **Get Even \ Odd App**:

The app consists of 2 web app microservices and a web app which acts as an api.
Both microservices are exposed to the world using ingress (nginx), and are accessible via http://ingress-domain/odd and http://ingress-domain/even. The api url is consumed via a url in a the ms chart configmap.

The app is deployed on a minikube cluster on ec2. To login:
ssh -i "kube-ec2.pem" ubuntu@ec2-18-159-111-76.eu-central-1.compute.amazonaws.com
Private key is attached in mail
Configmap content is not refreshed in existing pods, therefore I installed reloader to refresh pods with cm changes.

The apps are already deployed in cluster. To deploy new version - run CICD-MS workflow. A dropdown selection of ms to deploy is presented.
On a fresh cluster, CICD-API workflow should be installed executed first to install the api webapp

## **Notes**:

- In a real cluster with a cloud controller, i’d use a service of type LB to provision LB for the api, and use external-dns tool to create a persistent DNS route53 record that will dynamically point to the LB address. This will make sure I'll always reach the API without worrying about which namespace \ cluster its deployed at.
Also the ingress would receive and public endpoint instead of the 192 address.

- Simulate requests with ingress to ms:
Get public IP: kubectl get ingress, and get the ip in ADDRESS column  
curl --header 'Host: odd.com' http://192.168.49.2  
curl --header 'Host: odd.com' http://192.168.49.2/ready  
Kindly let me know once you’ve finished review so i can terminate the instance. I had to create an instance with 2vCPU which is not free-tier 🙂
