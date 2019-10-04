#!/bin/bash

# example: ./create-ecs-service.sh vpc-08ffd7a6c352ce4e2 sg-0b2f6b88233ccd7ce subnet-031b1693d2cb918bb\,subnet-005defdbc1fe294b6 subnet-0840d739f171981fd\,subnet-0ec2ef819fe4732e6 ns-jmrijhmtq4f4wx7a peanuts-vpc-stack-peanutsECSCluster-12S71HZK81LSL peanutsECSLogGroup-peanuts-vpc-stack

echo $1
echo $2
echo $3
echo $4
echo $5
echo $6
echo $7

aws cloudformation create-stack --capabilities CAPABILITY_IAM --stack-name=bitcoind-ecs-stack --template-body file://cloudformation/bitcoin-service.json --parameters ParameterKey=VpcId,ParameterValue=$1 ParameterKey=SecurityGroupId,ParameterValue=$2 ParameterKey=PublicSubnetIds,ParameterValue=\"$3\" ParameterKey=PrivateSubnetIds,ParameterValue=\"$4\" ParameterKey=PrivateDnsNamespaceId,ParameterValue=$5 ParameterKey=ECSClusterName,ParameterValue=$6 ParameterKey=CloudwatchLogsGroupName,ParameterValue=$7
