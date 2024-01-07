pipeline{
    agent any
    environment {
        ABC_URL = "test.google.com"
        XYZ_URL = "xyz.google.com"
    }
    stages{
        stage("A"){
            steps {
                sh "env"
                sh "echo ========executing A======== "
                sh "echo value of ABC_URL is ${ABC_URL}"
                // sh "echo value of XYZ_URL is ${XYZ_URL}"
            }
        }
        stage("B"){
            steps {
                
                script {
                    if(env.XYZ_URL == null || env.XYZ_URL == "") {
                        sh "echo If condition"
                        sh "echo XYZ_URL is null or empty"
                    } else {
                        sh "echo Else Condition"
                        sh "echo value is not empty : and XYZ_URL is ${XYZ_URL}"
                        }

                    }
                }
            }
        }
    }


// We cannot print a environment variable that is null.