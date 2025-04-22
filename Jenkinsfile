pipeline {
    agent any

  

    environment {
        SONAR_URL = 'http://192.168.2.175:9000'
        SONAR_TOKEN = credentials('sonar-token')  // Add this in Jenkins credentials
        IMAGE_NAME = "javasonarqube"
        IMAGE_TAG = "saiteja"
        DOCKER_HUB_USER = credentials('docker-token')
        DOCKER_REPO = "saiteja562/mvnjavasonar"
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp')
        
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/ameda71/mvnsonardoc.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage("build & SonarQube analysis") {
            agent any
            steps {
              withSonarQubeEnv('sonar') {
                sh ''' 
                  
                  mvn clean verify sonar:sonar \
                      -Dsonar.projectKey=test_project \
                      -Dsonar.projectName='test_project' \
                      -Dsonar.host.url=http://192.168.2.175:9000 \
                      -Dsonar.token=squ_05aec9c20387119fe9ba85cbcbeb7c2ca75c556e
                  
                  '''
              }
            }
          }
          stage("Quality Gate") {
            steps {
              timeout(time: 10, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
          }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        // stage('Run Docker Container') {
        //     steps {
        //         sh 'docker run -d -p 8111:8081  ${IMAGE_NAME}'
        //     }
        // }
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    sh '''
                    echo "${DOCKER_HUB_USER_PSW}" | docker login -u "${DOCKER_HUB_USER_USR}" --password-stdin
                    docker tag ${IMAGE_NAME} ${DOCKER_REPO}:${BUILD_NUMBER}
                    docker push ${DOCKER_REPO}:${BUILD_NUMBER}
                    '''
                }
            }
        }

        stage("Terraform Create Instance") {
            steps {
                sh '''
                terraform init
                terraform plan
                terraform apply --auto-approve
                '''
            }
        }

        stage('Checking Connection') {
            steps {
                sh '''
                ansible-inventory --graph
                '''
            }
        }

        stage("Ping Ansible") {
            steps {
                sh '''
                sleep 10
                ansible all -m ping
                '''
            }
        }

        stage("Ansible Deployment") {
            steps {
                sh '''
                ansible-playbook deploy.yml -e build_number=$BUILD_NUMBER
                '''
            }
        }
        
     

    post {
        success {
            echo "Application successfully deployed in a Docker container!"
        }
        failure {
            echo "Build failed!"
        }
    }
}
