# This function gets a string as a parameter, adds today's date to beginning of the that string,
# replaces all whitespaces with dashes and adds ".md" to the end of the string. 
# i.e "This is a postname" -> "2019-02-08-This-is-a-postname.md"
# Function can get -ignore as a parameter. If this parameter is given, function adds "ignore_" string
# to the starting of the string in addition to operations above.
function createpost(){
    if [[ "$1" == "-ignore" ]]
    then
    	postname=$2
    	today=$(date +'%Y-%m-%d')
    	postname="$today-${postname// /-}.md"
        touch "ignore_$postname"
    else
    	postname=$1	
    	today=$(date +'%Y-%m-%d')
    	postname="$today-${postname// /-}.md"
        touch "$postname"
    fi
}
export -f createpost

# This function removes "ignore_" prefix from file names. i.e "ignore_XXX.md" -> "XXX.md"
function unignore(){
	if [ "$#" -eq "0" ]
		then
			echo "No arguments supplied"
	elif [ ! -e $(pwd)/"$1" ]
		then
			echo "No such a file"
	else
		postname=$1
		postname="${postname//ignore_/}"
		mv $1 $postname
		echo "$1 -> $postname"
	fi
}
export -f unignore

function nonascii() { LANG=C grep --color=always '[^ -~]\+'; }
export -f nonascii


# This is helper bash function which is written to remind me useful commands I can forget.
function helper(){
	if [[ "$1" == "-help" || "$#" -eq "0" ]]
		then
			echo "-protocompile => for proto compile command"
			echo "-jekyll OR -bundle => for jekyll serve command"
	elif [[ "$1" == "-protocompile" ]]
		then
			echo "protoc --go_out=plugins=grpc:. *.proto"
	elif [[ "$1" == "-jekyll" || "$1" == "-bundle" ]]
		then
			echo "bundle exec jekyll serve"
	elif [[ "$1" == "-django" ]]
		then
			echo "CREATE PROJECT : django-admin startproject mysite"
			echo "MIGRATIONS : python manage.py makemigrations APPNAME && python manage.py migrate"
	fi
}
export -f helper
