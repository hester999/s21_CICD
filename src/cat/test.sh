#!/bin/bash
SUCCESS=0
FAIL=0
COUNTER=0
TEST_FILE=(
    "tests/test1.txt"
    "tests/test2.txt"
    "tests/test3.txt"
    "tests/test4.txt"
)

s21_cat="./s21_cat"
cat="cat"

flags=(
    "-b"
    "-e"
    "-n"
    "-s"
    "-t"
    "-v"
)

printf "\n"
echo "-----------------------"
echo "TESTS"
echo "-----------------------"
printf "\n"
echo "======================="
echo "1 FLAG - 1 FILE"
echo "======================="
printf "\n"

for v1 in "${flags[@]}"
do
    for v2 in "${TEST_FILE[@]}"
    do
        (( COUNTER++ ))
        TEST1="$v1 $v2"
        
        $s21_cat $TEST1 > s21_cat_res.txt
        $cat $TEST1 > cat_res.txt
        DIFF_RES="$(diff -s s21_cat_res.txt cat_res.txt)"
        if [ "$DIFF_RES" == "Files s21_cat_res.txt and cat_res.txt are identical" ]
            then
                (( SUCCESS++ ))
                echo "$COUNTER - \033[32mSUCCESS\033[0m $TEST1"
            else
                echo "$TEST1" >> log.txt
                (( FAIL++ ))
                echo "$COUNTER - \033[31mFAIL\033[0m $TEST1"
        fi
        rm s21_cat_res.txt cat_res.txt
        
    done
done

printf "\n"
echo "-----------------------"
echo "TESTS"
echo "-----------------------"
printf "\n"
echo "======================="
echo "2 FLAGS - 1 FILE"
echo "======================="
printf "\n"

for v1 in "${flags[@]}"
do
    for v2 in "${flags[@]}"
    do
        if [ $v1 != $v2 ]
        then 
            for v3 in "${TEST_FILE[@]}"
            do
                (( COUNTER++ ))
                TEST1="$v1 $v2 $v3"
        
                $s21_cat $TEST1 > s21_cat_res.txt
                $cat $TEST1 > cat_res.txt
                DIFF_RES="$(diff -s s21_cat_res.txt cat_res.txt)"
                if [ "$DIFF_RES" == "Files s21_cat_res.txt and cat_res.txt are identical" ]
                    then
                        (( SUCCESS++ ))
                        echo "$COUNTER - \033[32mSUCCESS\033[0m $TEST1"
                else
                        echo "$TEST1" >> log.txt
                        (( FAIL++ ))
                        echo "$COUNTER - \033[31mFAIL\033[0m $TEST1"
                fi
                rm s21_cat_res.txt cat_res.txt
            done
        fi
    done
done

printf "\n"
echo "-----------------------"
echo "TESTS"
echo "-----------------------"
printf "\n"
echo "======================="
echo "1 FLAG - 2 FILES"
echo "======================="
printf "\n"

for v1 in "${flags[@]}"
do
    for v2 in "${TEST_FILE[@]}"
    do
        for v3 in "${TEST_FILE[@]}"
        do
            if [ $v2 != $v3 ]
            then 
                (( COUNTER++ ))
                TEST1="$v1 $v2 $v3"
        
                $s21_cat $TEST1 > s21_cat_res.txt
                $cat $TEST1 > cat_res.txt
                DIFF_RES="$(diff -s s21_cat_res.txt cat_res.txt)"
                if [ "$DIFF_RES" == "Files s21_cat_res.txt and cat_res.txt are identical" ]
                    then
                        (( SUCCESS++ ))
                        echo "$COUNTER - \033[32mSUCCESS\033[0m $TEST1"
                else
                        echo "$TEST1" >> log.txt
                        (( FAIL++ ))
                        echo "$COUNTER - \033[31mFAIL\033[0m $TEST1"
                fi
                rm s21_cat_res.txt cat_res.txt
            fi
        done
     done
done

printf "\n"
echo "FAILED: $FAIL"
echo "SUCCESSFUL: $SUCCESS"
echo "ALL: $COUNTER"
printf "\n"
##############################

printf "\n"
echo "-----------------------"
echo "TESTS"
echo "-----------------------"
printf "\n"
echo "======================="
echo "2 FLAGS - 2 FILES"
echo "======================="
printf "\n"

for v1 in "${flags[@]}"
do
    for v2 in "${flags[@]}"
    do
        if [ $v1 != $v2 ]
        then 
            for v3 in "${TEST_FILE[@]}"
            do
                for v4 in "${TEST_FILE[@]}"
                do
                    if [ $v3 != $v4 ]
                    then 
                        (( COUNTER++ ))
                        TEST1="$v1 $v2 $v3 $v4"
        
                        $s21_cat $TEST1 > s21_cat_res.txt
                        $cat $TEST1 > cat_res.txt
                        DIFF_RES="$(diff -s s21_cat_res.txt cat_res.txt)"
                        if [ "$DIFF_RES" == "Files s21_cat_res.txt and cat_res.txt are identical" ]
                            then
                                (( SUCCESS++ ))
                                echo "$COUNTER - \033[32mSUCCESS\033[0m $TEST1"
                        else
                                echo "$TEST1" >> log.txt
                                (( FAIL++ ))
                                echo "$COUNTER - \033[31mFAIL\033[0m $TEST1"
                        fi
                        rm s21_cat_res.txt cat_res.txt
                     fi
                done
             done
        fi
    done
done

printf "\n"
echo "FAILED: $FAIL"
echo "SUCCESSFUL: $SUCCESS"
echo "ALL: $COUNTER"
printf "\n"
rm log.txt
HALF=$((COUNTER / 2))


if [ "$SUCCESS" -gt "$HALF" ];
then
	    exit 0
    else 
	        exit 1
fi
