pipeline {
    agent any
    parameters {
        choice(name: 'TF_VAR_environment', choices: ['dev', 'prod'], description: 'Select Environment')
        choice(name: 'TERRAFORM_OPERATION', choices: ['plan', 'apply', 'destroy'], description: 'Select Terraform Operation')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Change directory to Task02/
                    dir('Task02/') {
                        withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                                         string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                            sh 'terraform init'
                        }
                    }
                }
            }
        }

        stage('Terraform Workspace') {
            steps {
                script {
                    // Change directory to Task02/
                    dir('Task02/') {
                        withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                                         string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                            def workspaceExists = sh(script: "terraform workspace select ${params.TF_VAR_environment} || true", returnStatus: true) == 0

                            if (!workspaceExists) {
                                sh "terraform workspace new ${params.TF_VAR_environment}"
                            }
                        }
                    }
                }
            }
        }

        stage('Terraform Operation') {
            steps {
                script {
                    dir('Task02/') {
                        withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                                         string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                            switch(params.TERRAFORM_OPERATION) {
                                case 'plan':
                                    sh "terraform plan -var-file='${params.TF_VAR_environment}.tfvars' -out=tfplan"
                                    break
                                case 'apply':
                                    sh "terraform plan -var-file='${params.TF_VAR_environment}.tfvars' -out=tfplan"
                                    sh 'terraform apply -auto-approve tfplan'
                                    break
                                case 'destroy':
                                    sh "terraform destroy -var-file='${params.TF_VAR_environment}.tfvars' -auto-approve"
                                    break
                                default:
                                    error "Invalid Terraform operation selected"
                            }
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            deleteDir()
        }
    }
}

