#!/bin/bash

IFS=$'\n'

input="/home/android_build/android/system_dump/max1_complete_tree/sepolicy"
all_te_files="/tmp/all_te_files.txt"

skip_types=1
skip_categories=1
skip_classes=1
skip_common=1
skip_constraints=0

check_type() {
    if [ "$skip_types" -ne 1 ]
    then
        l=$(echo "$1" | sed 's/^ *//;s/ *$//')

        query=$(echo "$l" | cut -d ' ' -f 2- | cut -d ',' -f 1 | cut -d ' ' -f 1)

        if [ -z "$query" ]
        then
            echo "Empty type: $query ($l)"
            exit
        fi

        grep -E "^ *type $query *(,| alias)" $(cat "$all_te_files") > /tmp/found.txt
        if [ $? -eq 0 ]
        then
            echo "Type $query already defined."
            cat /tmp/found.txt
        else
            seinfo -x --type "$query" "$input" | grep '^   [^ ]' | sed 's/^ *//;s/ *$//' > /tmp/new_entry.txt
            echo "New type: $query"
            cat /tmp/new_entry.txt | tee -a types.te
        fi
    fi
}

check_category() {
    if [ "$skip_categories" -ne 1 ]
    then
        l=$(echo "$1" | sed 's/^ *//;s/ *$//')

        query=$(echo "$l" | cut -d ' ' -f2- | cut -d ' ' -f 1 | cut -d ';' -f 1)

        if [ -z "$query" ]
        then
            echo "Empty category: $query ($l)"
            exit
        fi

        grep -E "^ *category $query *(,| alias)" $(cat "$all_te_files") > /tmp/found.txt
        if [ $? -eq 0 ]
        then
            echo "Category $query already defined."
            cat /tmp/found.txt
        else
            seinfo -x --category "$query" "$input" | grep '^   [^ ]' | sed 's/^ *//;s/ *$//' > /tmp/new_entry.txt
            echo "New category: $query"
            cat /tmp/new_entry.txt | tee -a categories.te
        fi
    fi
}

check_class() {
    if [ "$skip_classes" -ne 1 ]
    then
        l=$(echo "$1" | sed 's/^ *//;s/ *$//')

        query=$(echo "$l" | cut -d ' ' -f 2- | cut -d ',' -f 1 | cut -d ' ' -f 1)

        if [ -z "$query" ]
        then
            echo "Empty class: $query ($l)"
            exit
        fi

        grep -E "^ *class $query$" $(cat "$all_te_files") > /tmp/found.txt
        if [ $? -eq 0 ]
        then
            echo "Class $query already defined."
            cat /tmp/found.txt
        else
            seinfo -x --class "$query" "$input" | sed '1,2d;s/^ *//;$s/$/;/' > /tmp/new_entry.txt
            echo "New class: $query"
            cat /tmp/new_entry.txt | tee -a classes.te
        fi
    fi
}

check_common() {
    if [ "$skip_common" -ne 1 ]
    then
        l=$(echo "$1" | sed 's/^ *//;s/ *$//')

        query=$(echo "$l" | cut -d ' ' -f 2- | cut -d ',' -f 1 | cut -d ' ' -f 1)

        if [ -z "$query" ]
        then
            echo "Empty common: $query ($l)"
            exit
        fi

        grep -E "^ *common $query($| |;)" $(cat "$all_te_files") > /tmp/found.txt
        if [ $? -eq 0 ]
        then
            echo "Common $query already defined."
            cat /tmp/found.txt
        else
            seinfo -x --common "$query" "$input" | sed '1,2d;s/^ *//;$s/$/;/' > /tmp/new_entry.txt
            echo "New common: $query"
            cat /tmp/new_entry.txt | tee -a common.te
        fi
    fi
}

check_constraint() {
    if [ "$skip_constraints" -ne 1 ]
    then
        l=$(echo "$1" | sed 's/^ *//;s/ *$//')

        query=$(echo "$l" | cut -d ' ' -f 2- | cut -d ',' -f 1 | cut -d ' ' -f 1 | cut -d ';' -f 1)

        if [ -z "$query" ]
        then
            echo "Empty constraint: $query ($l)"
            exit
        fi

        grep -E "^ *(mls|)constrain $query($| |;)" $(cat "$all_te_files") > /tmp/found.txt
        if [ $? -eq 0 ]
        then
            echo "Constraint $query already defined."
            cat /tmp/found.txt
        else
            seinfo -x --constrain "$query" "$input" | sed '1,2d;s/^ *//;$s/$/;/' > /tmp/new_entry.txt
            echo "New constraint: $query"
            cat /tmp/new_entry.txt | tee -a common.te
        fi
    fi
}


echo "Generate a list of all te files to query for already defined types, classes, etc."
find /home/android_build/android/omnirom_src/ -name "*.te" | grep -v '/device/letv/max1/' > "$all_te_files"

echo "Extract all info from sepolicy file."
seinfo -x --all "$input" > /tmp/all.txt

> /tmp/filtered.txt

# initalize .te files

if [ "$skip_types" -ne 1 ]
then
    > types.te
fi
if [ "$skip_categories" -ne 1 ]
then
    > categories.te
fi
if [ "$skip_classes" -ne 1 ]
then
    > classes.te
fi
if [ "$skip_common" -ne 1 ]
then
    > common.te
fi
if [ "$skip_constraints" -ne 1 ]
then
    > constraints.te
fi

# main loop

class=""
while read l
do
    if [ $(echo "$l" | grep '^[A-Z]\+[^:]*: [0-9]\+$' | wc -l) -gt 0 ]
    then
        class=$(echo "$l" | cut -d ':' -f 1)
    elif [ -n "$class" ] && [ $(echo "$l" | grep '^   [^ ]' | wc -l) -gt 0 ]
    then
        cl=$(echo "$l" | sed 's/^ *\([^ ]*\) .*$/\1/')

        case "$cl" in
            type)
                check_type "$l"
                ;;
            category)
                check_category "$l"
                ;;
            class)
                check_class "$l"
                ;;
            common)
                check_common "$l"
                ;;
            constrain | mlsconstrain)
                check_constraint "$l"
                ;;
            *)
                echo "Unknown: $cl ($l)"
                exit
                ;;
        esac

    fi
done < <(cat "/tmp/all.txt")
