pipeline {
    agent any

    environment {
        // ชื่อโฟลเดอร์ผลลัพธ์แบบมีเวลา ป้องกันทับ
        REPORT_DIR = "results_${new Date().format('yyyyMMdd_HHmmss')}"
    }

    stages {

        stage('Checkout Code From Git') {
            steps {
                git branch: 'TA_robot', url: 'https://github.com/shompoosks/TestAutomate.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                dir('TestAutomate') {
                    sh '''
                        python3 -m venv venv
                        . venv/bin/activate
                        pip install --upgrade pip
                        pip install -r requirements.txt
                    '''
                }
            }
        }

        stage('Run UI/Robot Tests') {
            steps {
                dir('TestAutomate') {
                    sh """
                        . venv/bin/activate
                        robot -d ${REPORT_DIR} robot-automation/tests/web-no2/login_web.robot
                    """
                }
            }
        }

        stage('Run API Tests') {
            when {
                expression { fileExists('TestAutomate/run_api.sh') }
            }
            steps {
                dir('TestAutomate') {
                    sh """
                        . venv/bin/activate
                        chmod +x run_api.sh
                        ./run_api.sh
                    """
                }
            }
        }

        stage('Publish Robot Report') {
            steps {
                // ถ้าใช้ Robot Framework Plugin ใน Jenkins
                robot outputPath: "TestAutomate/${REPORT_DIR}"

                // หรือจะ publish html ตรง ๆ
                publishHTML(target: [
                    reportDir: "TestAutomate/${REPORT_DIR}",
                    reportFiles: 'report.html',
                    reportName: 'Robot Report'
                ])
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: "TestAutomate/${REPORT_DIR}/**", fingerprint: true
        }
        failure {
            echo "Test failed. Please check report.html/log.html in the build artifacts."
        }
    }
}