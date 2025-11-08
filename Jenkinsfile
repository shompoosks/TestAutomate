pipeline {
    agent any

    stages {
        stage('Set timestamp') {
            steps {
                script {
                    // สร้างชื่อโฟลเดอร์ report แบบมีเวลา
                    env.REPORT_DIR = "results_${new Date().format('yyyyMMdd_HHmmss')}"
                    echo "📁 Report directory: ${env.REPORT_DIR}"
                }
            }
        }

        stage('Checkout Code From Git') {
            steps {
                git branch: 'TA_robot', url: 'https://github.com/shompoosks/TestAutomate.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                // อยู่ที่ root ของ repo เลย ไม่ต้อง dir('TestAutomate')
                sh '''#!/bin/bash
                    set -e
                    echo "📦 create venv"
                    python3 -m venv venv
                    source venv/bin/activate
                    python -m pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run UI/Robot Tests') {
            steps {
                sh """#!/bin/bash
                    set -e
                    source venv/bin/activate
                    robot -d ${REPORT_DIR} robot-automation/tests/web-no2/login_web.robot
                """
            }
        }

        stage('Run API Tests') {
            when {
                expression { fileExists('run_api.sh') }
            }
            steps {
                sh """#!/bin/bash
                    if [ -d "venv" ]; then
                        source venv/bin/activate
                    elif [ -d ".venv" ]; then
                        source .venv/bin/activate
                    fi

                    chmod +x run_api.sh
                    ./run_api.sh
                """
            }
        }

        stage('Publish Robot Report') {
            steps {
                robot outputPath: "${REPORT_DIR}"
            }
        }
    }

    post {
        always {
            // เก็บ report เข้ากับ build
            archiveArtifacts artifacts: "${REPORT_DIR}/**", fingerprint: true
        }
        failure {
            echo "Test failed. Please check report.html/log.html in the build artifacts."
        }
    }
}