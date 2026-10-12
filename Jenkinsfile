pipeline {
    agent any

    parameters {
        choice(name: 'ENV', choices: ['dev', 'stg', 'prod'], description: 'Target environment')
    }

    environment {
        TF_IN_AUTOMATION      = 'true'
        AWS_ACCESS_KEY_ID     = 'test'
        AWS_SECRET_ACCESS_KEY = 'test'
        AWS_DEFAULT_REGION    = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps { checkout scm }
        }

        stage('Terraform Init') {
            steps { sh 'terraform init -input=false' }
        }

        stage('Workspace Select') {
            steps {
                sh "terraform workspace select ${params.ENV} || terraform workspace new ${params.ENV}"
            }
        }

        stage('Plan') {
            steps {
                sh "terraform plan -input=false -var-file=${params.ENV}.tfvars -out=tfplan"
            }
        }

        stage('Approve / Abort') {
            steps {
                // لو داس Abort الـ pipeline بيقف
                input message: "Apply to ${params.ENV}?", ok: 'Approve'
            }
        }

        stage('Apply') {
            steps { sh 'terraform apply -input=false tfplan' }
        }
    }

    post {
        success { echo "Deployed ${params.ENV} successfully" }
        failure {
            mail to: 'you@example.com',
                 subject: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "Check: ${env.BUILD_URL}"
        }
    }
}
