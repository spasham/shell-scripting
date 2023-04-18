pipeline{
    agent any
    environment {
        ABC_URL = "test.google.com"
    }
    stages{
        stage("A"){
            steps{
                sh "echo ========executing A======== "
                sh "env"
            }
        stage("B"){
            steps{
                sh "echo ========executing b======== "
                sh "env"
                script {
                    if(env.ABC_URL != null) {
                        echo value of ABC_URL is ${ABC_URL}
                    } else {
                        echo value is empty : ${ABC_URL}
                        }

                    }
                }
            }
        }
    }
}