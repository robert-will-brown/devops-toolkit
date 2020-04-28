#!/bin/bash -e
#
# Pre-Commit hooks: rob.brown@visual20.com
#
#

echo ""
echo -e '\033[1;34m➡ Running Pre-Commit Validation...\033[0m'
echo ""

##if [ -z ${AWS_DEFAULT_PROFILE+x} ]; then echo -e '\033[1;31m𝙓 AWS profile not set\033[0m'; exit 1; fi


# Get list of changed files
for ModifiedFile in $(git diff --name-only HEAD)
do
	ModifiedFileNoPath=$(basename -- "$ModifiedFile")
	ModifiedFileExtension="${ModifiedFileNoPath##*.}"

	case "${ModifiedFileExtension}" in

	"yaml")
		# Lint
		echo -e "➡ YAML Linting   \"${ModifiedFile}\"...\c"
		yamllint -d "{extends: relaxed, rules: {line-length: {max: 160}}}" "${ModifiedFile}"
		echo -e '\033[1;32m✔︎ Ok.\033[0m'

#       # Validate CFN
#		echo -e "➡ CFN Validating \"${ModifiedFile}\" with AWS...\c"
#		aws cloudformation validate-template --template-body file://"${ModifiedFile}" 2>/dev/null 1>/dev/null
#		echo -e '\033[1;32m✔︎ Ok.\033[0m'
	;;

	"json")
		# Lint
		echo -e "➡ JSON Linting   \"${ModifiedFile}\"...\c"
		jsonlint  --compact --quiet "${ModifiedFile}"
		echo -e '\033[1;32m✔︎ Ok.\033[0m'
	;;


	"sh")
		# Lint
		echo -e "➡ ShellCheck \"${ModifiedFile}\"...\c"
		shellcheck  --compact --quiet "${ModifiedFile}"
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
