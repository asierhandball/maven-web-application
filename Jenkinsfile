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
    post {
        always {
            recordIssues enabledForFailure: true, tool: mavenConsole(), referenceJobName: 'Docker_Image_Control'
            recordIssues enabledForFailure: true, tools: [java(), javaDoc()], sourceCodeEncoding: 'UTF-8', referenceJobName: 'Docker_Image_Control'
            recordIssues enabledForFailure: true, tool: checkStyle(), sourceCodeEncoding: 'UTF-8', referenceJobName: 'Docker_Image_Control'
            recordIssues enabledForFailure: true, tool: cpd(), sourceCodeEncoding: 'UTF-8', referenceJobName: 'Docker_Image_Control'
            recordIssues enabledForFailure: true, tool: pmdParser(), sourceCodeEncoding: 'UTF-8', referenceJobName: 'Docker_Image_Control'
            recordIssues enabledForFailure: true, tool: spotBugs(), sourceCodeEncoding: 'UTF-8', referenceJobName: 'Docker_Image_Control'
            recordIssues enabledForFailure: true, tool: taskScanner(includePattern:'**/*.java', excludePattern:'target/**/*', highTags:'FIXME', normalTags:'TODO'), sourceCodeEncoding: 'UTF-8', referenceJobName: 'Docker_Image_Control'
            dependencyCheckPublisher ""
        }
    }
}

