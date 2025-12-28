pipeline {
    agent any

    environment {
        SCRIPT = "count_etc_files.sh"
        RPM_PACKAGE = "count-etc-files-1.0-1.noarch.rpm"
        DEB_PACKAGE = "count-etc-files_1.0_all.deb"
    }

    stages {
        stage('Build Docker') {
            steps {
                script {
                    sh 'docker build -t jenkins-builder .'
                }
            }
        }

        stage('Run Jenkins Builder') {
            steps {
                script {
                    sh 'docker run --name jenkins-builder-run -d jenkins-builder'
                }
            }
        }

        stage('Install Package & Run Script') {
            steps {
                script {
                    sh 'docker cp packaging/rpm/${RPM_PACKAGE} jenkins-builder-run:/tmp/'
                    sh 'docker cp packaging/deb/${DEB_PACKAGE} jenkins-builder-run:/tmp/'
                    sh '''
                        docker exec jenkins-builder-run bash -c "sudo dpkg -i /tmp/${DEB_PACKAGE} || true"
                        docker exec jenkins-builder-run bash -c "/usr/local/bin/${SCRIPT}"
                    '''
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    sh 'docker stop jenkins-builder-run'
                    sh 'docker rm jenkins-builder-run'
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished."
        }
    }
}
