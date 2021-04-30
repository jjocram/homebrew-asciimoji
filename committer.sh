#! /bin/sh

echo "New version number:"
read version_number

echo "Retrieving new sha256 from the new url"
new_url="https://gitlab.com/jjocram/asciimoji/-/archive/v$version_number/asciimoji-v$version_number.tar.gz"

status_code_gitlab=$(curl --write-out "%{http_code}\n" "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22" --output output.txt --silent)
echo "${status_code_gitlab}"
if [ $status_code_gitlab -ne 200 ]
then
    echo "Release not found at ${new_url}"
    exit 1
fi

new_sha=$(curl ${new_url} | sha256sum | /usr/bin/grep -oh "[a-zA-Z0-9_.-]*") # Saves only the hash, sometimes sha256sum returned an extra " -"

echo "Update asciimoji.rb file"
old_url=$(sed '4!d' asciimoji.rb | awk 'match($0,/"[^"]*"/) {print substr($0,RSTART+1,RLENGTH-2)}') # Get the old url from asciimoji.rb file
old_sha=$(sed '5!d' asciimoji.rb | awk 'match($0,/"[^"]*"/) {print substr($0,RSTART+1,RLENGTH-2)}') # Get old sha256 from asciimoji.rb file

sed -i '' -e "4s|${old_url}|${new_url}|g" asciimoji.rb # Replace old url with the new one in asciimoji.rb, the "|" is necessary because in the url there are "/"
sed -i '' -e "5s/${old_sha}/${new_sha}/g" asciimoji.rb # Replace old sha256 with the new one in asciimoji.rb

echo "Committing and pushing"
git add .
git commit -m "Update to $version_number, see changelog on GitLab for details"
git push
