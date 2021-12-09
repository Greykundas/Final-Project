#!/bin/bash
echo ""
echo "Welcome to my Final Challenge trivia game."
echo ""
echo "If you manage to get all of the right answers I'll give you the password to the encrypted file."
echo ""
echo ""
echo ""
# constants
quiz_file=/root/RiddlerGame/.bash_histry/quiz.txt
negative_phrases=/root/RiddlerGame/.bash_histry/phrases.txt
positive_phrases=/root/RiddlerGame/.bash_histry/pos_phrases.txt
score=0

# check if quiz file exists
if [ ! -f $quiz_file ]
then
    echo "Quiz file doesn't exist!"
    exit 1
fi
# check if negative phrase file exists
if [ ! -f $negative_phrases ]
then
    echo "Phrases file doesn't exist!"
    exit 1
fi
# check if positive phrase file exists
if [ ! -f $positive_phrases ]
then
   echo "Positive Phrases file doesn't exist!"
   exit 1
fi

# game loop (loop over quiz file line/line)
while read -u9 line
do

    # parsing quiz file for current question
    question=`echo $line | cut -f1 -d' '`
    choice1=`echo $line | cut -f2 -d' '`
    choice2=`echo $line | cut -f3 -d' '`
    choice3=`echo $line | cut -f4 -d' '`
    solution=`echo $line | cut -f5,6 -d' '`

    # print question & choices
    echo "$question?"
    echo ""
    echo "- $choice1"
    echo "- $choice2"
    echo "- $choice3"
    echo ""

    # read player choice
    read -p "- Your response: " player_choice

    # compare player against solution & increment score
    if [ "$player_choice" == "$solution" ]
    then
        score=$(( ++score ))
	echo ""
	echo ""
        echo "Correct! $(shuf -n 1 $positive_phrases)"
	echo ""
	echo ""
    else
	echo ""
	echo ""
        echo "Wrong! $(shuf -n 1 $negative_phrases)"
	echo ""
	echo ""
    fi

done 9< $quiz_file 

echo "Your score is $score/`wc -l $quiz_file`"
echo ""
echo ""
# print score
if [ $score -lt 10 ]
then
	echo "Does your head hurt Batman? Understandable. You're no match for me. No secrets for you."
	echo ""
	echo ""
else
	echo "So you finished the quiz at last and have gotten all of the right answers. I'm impressed. This was one of the more taxing challenges. As per agreement here is the prize unlock code: SG9seSBCb3VuY3kgQm9pbGVyIFBsYXRlCg==. Whoops! Looks like its encoded. I guess I'm just a sore loser."
	echo ""
	echo ""
fi
