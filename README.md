# Maven + SonarQube + Docker + GCP Kubernetes CI/CD Pipeline 🚀

This project demonstrates a complete CI/CD pipeline using Jenkins, Maven, SonarQube, Docker, Docker Hub, and Google Kubernetes Engine (GKE). It automates building a Java application, performing code quality checks, containerizing it, and deploying it to a Kubernetes cluster on GCP.

------------------------------------------------------------------

## 🔧 Tech Stack

- **Java + Maven** — Application build and dependency management
- **SonarQube** — Code quality analysis
- **Jenkins** — Orchestration of the pipeline
- **Docker** — Containerization of the application
- **Docker Hub** — Container registry to store and pull images
- **GCP (GKE)** — Kubernetes cluster for deployment
- **Terraform (optional)** — Infrastructure provisioning for GKE

------------------------------------------------------------------------

** CI/CD Workflow**

Jenkinsfile Highlights:

1) Clone Git Repo

2) Build with Maven

3) Run SonarQube Analysis

4) Build Docker Image

5) Push to Docker Hub

6) Authenticate to GCP

7) Update Kubernetes Deployment YAML

8) Deploy to GKE
-----------------------------------------

🔐 Jenkins Credentials Required

Make sure you have the following credentials set up in Jenkins:

sonar-token — SonarQube access token

docker-hub — Docker Hub username and password

gcp-key — GCP service account key file
--------------------------------------------------------

**How to Trigger the Pipeline**

You can trigger the Jenkins pipeline either manually or via webhook on commit.
-----------------------------------------------------------------


🎯 Outcome

Automatically builds your Java app

Runs SonarQube analysis for quality checks

Pushes production-ready Docker image to Docker Hub

Deploys the container on GKE via kubectl apply

------------------------------------------------------------------

🛠️ Improvements (Future Scope)

Add Quality Gate check stage for SonarQube

Add Slack notifications for success/failure

Use Helm instead of raw YAML for Kubernetes

Integrate Terraform fully for infra provisioning

-------------------------------------------------------
**Built with ❤️ using Jenkins, Docker, and Kubernetes**






