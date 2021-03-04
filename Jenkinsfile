
pipeline {
     agent {label'nani1'}

    tools {
        
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven"
        }    
environment {
      DOCKER_TAG = getVersion()
    }
    stages {
        
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                 sh 'git clone https://github.com/anilkumarpuli/dockerjenkins.git'
                 sh'rm -rf dockerjenkins'

                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
            stage('docker build')
            {
                steps
                  {
                       sh "docker build -t  anilkumblepuli/firstpipe:${DOCKER_TAG}  ."
                  }
            }
         stage('docker push to hub')
         {
              steps
                   {
                    withCredentials([string(credentialsId: 'dockerhub_pwd', variable: 'docker_pwd')]) 
                       {
                            sh  "docker login -u anilkumblepuli -p ${docker_pwd}"
                            sh "docker push anilkumblepuli/fisrtpipe:${DOCKER_TAG}"
                        }
                      }
                 
            }        
         
                 stage('deploy to dev server')
                  {   
                       steps
                       {
                        sshagent(['nexus-cred12']) 
                       {
                        sh 'ssh nani@172.31.25.98'                         
                        sh "docker run --name mydockerimage103 -p 8084:8080 anilkumblepuli/firstpipe:${DOCKER_TAG}"
                     }
                 }
             }
           }
             post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.war'
                }
            }
        }    
def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}




