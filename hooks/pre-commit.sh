#!/bin/bash -e
#
# Pre-Commit hooks: rob.brown@visual20.com
#
#

echo ""
echo -e '\033[1;34m➡ Running Pre-Commit Validation...\033[0m'
echo ""

if [ -z ${AWS_DEFAULT_PROFILE+x} ]; then echo -e '\033[1;31m𝙓 AWS profile not set\033[0m'; exit 1; fi


# Get list of changed files
for ModifiedFile in `git diff --name-only HEAD`
do
	ModifiedFileNoPath=$(basename -- "$ModifiedFile")
	ModifiedFileExtension="${ModifiedFileNoPath##*.}"

	case "${ModifiedFileExtension}" in

	"yaml")
		# Lint
		echo -e "➡ YAML Linting   \"${ModifiedFile}\"...\c"
		yamllint -d "{extends: relaxed, rules: {line-length: {max: 160}}}" ${ModifiedFile}
		echo -e '\033[1;32m✔︎ Ok.\033[0m'

        # Validate CFN
		echo -e "➡ CFN Validating \"${ModifiedFile}\" with AWS...\c"
		CfnValidateCommandOutput=$(aws cloudformation validate-template --template-body file://${ModifiedFile})
		echo -e '\033[1;32m✔︎ Ok.\033[0m'
	;;

	"json")
		# Lint
		echo -e "➡ JSON Linting   \"${ModifiedFile}\"...\c"
		jsonlint  --compact --quiet ${ModifiedFile}
		echo -e '\033[1;32m✔︎ Ok.\033[0m'
	;;

	*)
		echo "➡ Dont know how to check file \"${ModifiedFile}\", skipping."
	;;

	esac


done

echo ""
echo -e '\033[1;32m✔︎ Pre-Commit Validation Passed, ready to git push.\033[0m'
echo ""


exit
###################. THIS IS FOR A FULL CHECK OF ALL FILES ALL THE TIME BELOW #########################

# Check the JSON
echo ""
echo -e '\033[1;34m➡ Linting JSON:\033[0m'
for ConfigFile in `ls configuration/*json`
do
	echo -e "Linting ${ConfigFile}...\c"
	jsonlint  --compact --quiet ${ConfigFile}
	echo -e '\033[1;32m✔︎ Ok.\033[0m'
done

# Check the YAML
echo ""
echo -e '\033[1;34m➡ Linting YAML:\033[0m'
for CfnFile in `ls cloudformation/*yaml`
do
	echo -e "Linting ${CfnFile}...\c"
	yamllint -d "{extends: relaxed, rules: {line-length: {max: 160}}}" ${CfnFile}
	echo -e '\033[1;32m✔︎ Ok.\033[0m'
done


# Check the cloudformation
echo ""
echo -e '\033[1;34m➡ Validating CloudFormation templates with AWS:\033[0m'
for CfnFile in `ls cloudformation/*yaml`
do
	echo -e "Validating ${CfnFile}...\c"
	CfnValidateCommandOutput=$(aws cloudformation validate-template --template-body file://${CfnFile})
	echo -e '\033[1;32m✔︎ Ok.\033[0m'
done

echo ""
echo -e '\033[1;32m✔︎ Pre-Commit Validation Passed, ready to git push.\033[0m'
echo ""
