aws --profle myprofile ssm send-command \
    --instance-ids "i-06ae453469aa" \
    --document-name "AWS-RunShellScript" \
    --comment "IP config" \
    --parameters commands=ifconfig \
    --output text \
    --region us-east-1
    
aws --profile myprofile ssm send-command --instance-ids i-06aede6f31231669aa --document-name "AWS-RunShellScript" --comment "IP config" --parameters commands=ifconfig --output text --region us-east-1

aws ssm send-command \
    --document-name "AWS-RunShellScript" \
    --targets "Key=InstanceIds,Values=instance-id" \
    --cli-input-json file://installCodeDeployAgent.json
    
    aws --profile myprofile ssm list-command-invocations --command-id 0c235e14-4a9b-411c-89a8-8537a4821c8b --details --region us-east-1
    
    
    aws --profile myprofile ssm send-command --instance-ids i-43534353 --document-name "AWS-RunShellScript" --cli-input file://ssm-test.json --region us-east-1 --output json | jq -r '.Command.CommandId'
    
    aws --profile myprofile ssm list-command-invocations --command-id $( ) --details --region us-east-1
                        "cd ~",
                        "yum install -y java-1.8.0-openjdk.x86_64",
                        "aws s3 cp s3://12.0.zip ~",
                        "unzip ~/12.0.zip",
                        "chmod 775 ~LI.sh",
                        "touch ~/nse.xml",
                        
                        "export INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)",
                        "mkdir $INSTANCE_ID"
                        "~LI.sh -b ~/ccdf.xml -html -csv -rd $INSTANCE_ID",
                        "aws s3 cp --recursive ~/$INSTANCE_ID s3://output/"

   
