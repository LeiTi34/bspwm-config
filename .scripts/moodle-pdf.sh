#!/bin/sh

menu=(rofi -dmenu -l 25)

tmpdir="/tmp/moodle-pdf/"
cookie="${tmpdir}cookie.txt"
courseoverviewsite="${tmpdir}courses.html"
coursesite="${tmpdir}course.html"

source ~/Scripts/moodle-pdf-credentials

loginurl="https://moodle.technikum-wien.at/login/index.php"
overviewurl='https://moodle.technikum-wien.at/my/#courses'

mkdir -p "$tmpdir"

# Set cookie
echo "Getting cookie..."
wget --load-cookies "$cookie" --post-data="anchor=&username=$user&password=$passwd&rememberusername=1" --save-cookies="$cookie" --keep-session-cookies $loginurl -O /dev/null -q

# Get course overview
echo "Getting courses..."
wget --load-cookies "$cookie" --keep-session-cookies --save-cookies "$cookie" "$overviewurl" -O "$courseoverviewsite" -q

# Parse Links
courselist=$(echo "cat //html/body/div/div/div/div/section/div/aside/section/div/div/div/div/div/div/ul/div/div/li/div/a" |xmllint --html --shell "$courseoverviewsite" 2>/dev/null |grep 'href\|<b>'| sed 's/<a class="w-100 justify-content-around row" href="//g' | sed 's/<\/b>&amp;nbsp&amp;nbsp<\/td>//g' |sed 's/<b>//g'|sed 's/">\r//g'|sed 'N;s/\n/ /')

echo "$courselist"
# Show menu
course=$(echo "$courselist" | grep "$(echo "$courselist" |awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}'| recode html..UTF-8 |"${menu[@]}")")

if [ "$course" =  "$courselist" ]
then
    exit 1
fi

course=$(echo "$course" | awk '{print $1}')

# Get course URL
echo "Getting PDF-list..."
wget --load-cookies "$cookie" --keep-session-cookies --save-cookies "$cookie" "$course" -O "$coursesite" -q
# Parse Course
filelist=$(echo "cat //html/body/div/div/div/div/section/div/div/ul/li/div/ul/li/div/div/div/div" |xmllint --html --shell "$coursesite" 2>/dev/null| grep -v contentwithoutlink | grep pdf | sed 's/<div class="activityinstance"><a class="" onclick=".*" href="//g' | sed 's/"><img src="https:\/\/moodle\.technikum-wien\.at\/theme\/image\.php\/boost\/core\/[0-9]*\/f\/pdf-24" class="iconlarge activityicon" alt="" role="presentation" aria-hidden="true"><span class="instancename">/ /g' | sed 's/<span class="accesshide "> Datei<\/span><\/span><\/a><\/div>//g')

file=$(echo "$filelist" | grep "$(echo "$filelist" |awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}' | recode html..UTF-8 | "${menu[@]}")")

if [ "$file" =  "$filelist" ]
then
    exit 1
fi

file=$(echo "$file" | awk '{print $1}')

# Get & show file
echo "Getting PDF"
wget --load-cookies "$cookie" --keep-session-cookies --save-cookies "$cookie" "$file" -qO- | zathura - & disown
