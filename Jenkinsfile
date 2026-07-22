pipeline {
    agent any

    options {
        timestamps()
        ansiColor('xterm')
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
    }

    environment {
        APP_IMAGE = 'two-tier-devsecops-app'
        APP_IMAGE_TAG = "jenkins-${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Preflight') {
            steps {
                powershell '''
                    git --version
                    python --version
                    docker --version
                    docker compose version
                '''
            }
        }

        stage('Python Tests') {
            steps {
                powershell '''
                    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
                    .\\scripts\\verify-ci.ps1
                '''
            }
        }

        stage('Docker Build') {
            steps {
                powershell '''
                    docker build --tag "$env:APP_IMAGE`:$env:APP_IMAGE_TAG" .
                    docker image inspect "$env:APP_IMAGE`:$env:APP_IMAGE_TAG" --format "Image ID: {{.Id}}"
                '''
            }
        }

        stage('Secret Scan') {
            steps {
                powershell '''
                    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
                    .\\scripts\\verify-secrets.ps1
                '''
            }
        }

        stage('Vulnerability Scan') {
            steps {
                powershell '''
                    if (-not (Get-Command trivy -ErrorAction SilentlyContinue)) {
                        throw "Trivy is required on the Jenkins agent before vulnerability scanning can run."
                    }

                    trivy fs --severity HIGH,CRITICAL --exit-code 1 .
                    trivy image --severity HIGH,CRITICAL --exit-code 1 "$env:APP_IMAGE`:$env:APP_IMAGE_TAG"
                '''
            }
        }
    }

    post {
        always {
            powershell '''
                docker image ls "$env:APP_IMAGE" --format "table {{.Repository}}\\t{{.Tag}}\\t{{.ID}}\\t{{.Size}}"
            '''
        }
    }
}

