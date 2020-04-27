#!/bin/bash

Region="eu-west-2 "

for Template in `ls`
do 
	echo "Validating: ${Template}..."
	aws --region ${Region} cloudformation validate-template --template-body file://${Template}
done
