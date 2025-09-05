# Notes for Task1-Networking Deployment for GCP Armageddon Test

1. I used 3 of my own projects.
   - Invictus 65 (aka Invictus Inc.): "us-central1"
   - Service Project 1 (aka Member 1): "europe-west1"
   - Service Project 2 (aka Member 2): "asia-southeast1"

2. Task1-Networking is it's own separate file from the main "Test" folder.
   - In order to begin deploying this Task, cd into this folder by typing "cd task1-network" into your Terminal

3. After Applying Terraform, there will be an error because the peering services are going to take a little longer to apply. Just wait a minute or two and redo terraform apply.

4. When you do terraform destroy the same thing will happen. It will take a second for the peering to breakdown. 

5. Make sure you provide your own "Shared Secret". Mine is up there but I will change it later. 

6. If you are going to use your own other projects make sure that "Compute Engine" is enabled in their own IAM Policies. Then make sure that "Compute Engine API" is enabled as well.

Pics:
* Check the folder