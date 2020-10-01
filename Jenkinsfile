pipeline 
{
    agent any
    options
    {
        buildDiscarder(logRotator(numToKeepStr: "10")) 
    } 
        environment 
    {
        AWS_REGION = 'ap-southeast-1'
        ECR_URI_DEV = '224931607066.dkr.ecr.ap-southeast-1.amazonaws.com/ravindrasingh6969/load'
        IMAGE_NAME = 'ravindrasingh6969/load'
        CLUSTER = 'dev-ecs'
        FAMILY = 'dev-definition'
        SERVICE_NAME = 'dev-service'
    }
    stages 
    {
		stage('Build') 
        {
		 when
		 {
		     branch 'test' 
		 }
         environment { JAVA_HOME = '/usr/lib/jvm/java-1.8.0' }
         steps 
         {
            echo 'Running build'
			sh './gradlew clean build'
         }
        }

        stage('Build Docker Image') 
        {
            when 
            {
                branch 'test'
            }
            steps 
            {
                script 
                {
                    app = docker.build(IMAGE_NAME)
                    app.inside 
                    {
                        sh 'echo Hello, World!'
                    }
                }
            }
        }

        stage('Push Docker Image') 
        {
            when
            { 
                branch 'test'
            }
            steps 
            {
                script 
                {
                    docker.withRegistry("https://" + "${env.ECR_URI_DEV}" + "/" + "${env.IMAGE_NAME}",'ecr:' + "${env.AWS_REGION}" + ':AKIAZZARPMDQCA5SVQN6')
                    {
                    app.push("${env.BUILD_NUMBER}")
                    }
                }
            }
        }
        stage('Create and Update Task Definition')
        {
            steps
            {
                sh ''' sed -e "s;%BUILD_NUMBER%;$BUILD_NUMBER;g" aws/task-definition.json > task-definition-$BUILD_NUMBER.json '''
                sh 'aws ecs register-task-definition --family dev-definition --cli-input-json --region ${AWS_REGION} file://task-definition-${BUILD_NUMBER}.json'
            }
        }
        stage('Update Service')
        {
            steps
			{
			    //sh ''' aws ecs describe-task-definition --task-definition ${FAMILY}  --region ${AWS_REGION} | egrep "revision" | tr "," " " | awk '{print $2}' '''
                sh ''' aws ecs update-service --cluster ${CLUSTER} --service ${SERVICE_NAME} --region ${AWS_REGION} --task-definition ${FAMILY}:$(aws ecs describe-task-definition --task-definition ${FAMILY}  --region ${AWS_REGION} | egrep "revision" | tr "," " " | awk '{print $2}') --desired-count 1 '''
			}

        }    
    } 
}
