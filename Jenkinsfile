pipeline {
    agent any
    /*tools {
        Maven "M2_HOME"
        Java "JAVA_HOME"
    }*/
    stages {
        /*stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }*/
        stage('CI Phase') {
            steps {
                build 'Docker_Image_Control'
                dependencyCheckPublisher pattern: 'dependency-check-report.xml'
                
            }
        }
        stage ('Anchore Image Scanning') {
            steps {
                sh '''
                    echo "asaluena/simple-devops-image:latest" > anchore_images
                '''
                anchore bailOnFail: false, bailOnPluginFail: false, engineRetries: '600', name: 'anchore_images'
            }
        }
        stage('CD_Phase') {
            steps {
                build 'K8s_Deploying'
            }
        }
        
        
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }

}

