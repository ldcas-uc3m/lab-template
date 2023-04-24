#!/bin/bash
# Automate the process of setting up the repository for the specific project


get_info() {
    echo -n "Subject?: "
    read subject

    echo -n "Year (eg. if 22/23 put 22)?: "
    read year
    course=20$year-20$((year+1))
    course_short=$year/$((year+1))

    echo -n "Lab type (eg. Lab 1)?: "
    read lab_type

    echo -n "Lab name?: "
    read lab_name

    echo -n "Professor?: "
    read prof

    echo -n "Number of students?: "
    read num_students

    if (("$num_students" == 1)); then
        names=("Luis Daniel Casais Mezquida")
        nias=("100429021")
    
    else
        echo "Please enter the names in alphabetical order."
        names=()
        nias=()
        for ((i = 0 ; i < "$num_students" ; i++)); do
            echo -n "Name $i: "
            read names[i]
            
            echo -n "NIA $i: "
            read nias[i]
        done
    fi
}


update_report() {
    
    # general variables
    sed -i "s/[\\]def[\\]subject[{].*[}]/\\\\def\\\\subject{$subject}/g" report/parts/0-cover.tex
    sed -i "s/[\\]def[\\]year[{].*[}]/\\\\def\\\\year{$course}/g" report/parts/0-cover.tex
    sed -i "s/[\\]def[\\]labType[{].*[}]/\\\\def\\\\labType{$lab_type}/g" report/parts/0-cover.tex
    sed -i "s/[\\]def[\\]labName[{].*[}]/\\\\def\\\\labName{$lab_name}/g" report/parts/0-cover.tex
    sed -i "s/[\\]def[\\]proffesor[{].*[}]/\\\\def\\\\proffesor{$prof}/g" report/parts/0-cover.tex
    
    # authors

    # count lines 'til author
    author_line=$(sed -n '/[{][\\]LARGE Luis Daniel Casais Mezquida - 100429021[}][\\\\]/{=; q;}' report/parts/0-cover.tex)

    # delete author lines
    delete=${author_line}d
    sed -i "$delete" report/parts/0-cover.tex
    sed -i "$delete" report/parts/0-cover.tex

    # insert authors
    for ((i = 0; i < "$num_students"; i++)); do
        name=${names[i]}
        nia=${nias[i]}

        sed -i "$author_line i \ \t\t{\\\\LARGE $name - $nia}\\\\\\\\" report/parts/0-cover.tex
        author_line=$((author_line+1))

        sed -i "$author_line i \ \t\t\\\\vspace*{0.2cm}" report/parts/0-cover.tex
        author_line=$((author_line+1))
    done

}


update_readme() {
    
    # general data
    sed -i "s/# Lab: Name/# $lab_type: $lab_name/" README.md
    sed -i "s=Subject 2X/2Y=$subject $course_short=" README.md  # sed allows for use of different delimeters, in this case = instead of /

    # authors

    # build string
    authors="By "
    for ((i = 0; i < "$num_students"; i++)); do
        if (( i < $num_students - 2)); then
            authors="$authors${names[i]}, "
        elif (( i < $num_students - 1)); then
            authors="$authors${names[i]} \& "  # need to scape the &
        else
            authors="$authors${names[i]}"
        fi
    done

    # insert authors
    sed -i "s/By Luis Daniel Casais Mezquida/$authors/g" README.md

}


debug() {

    echo "$subject"
    echo "$year"
    echo "$course"
    echo "$course_short"
    echo "$lab_type"
    echo "$lab_name"
    echo "$prof"

    for i in "${names[@]}"; do
        echo "$i"
    done
    
    for i in "${nias[@]}"; do
        echo "$i"
    done
}


update_license() {
    full_year=20$year

    sed -i "s/<YEAR>/$full_year/" LICENSE
}


cleanup() {
    # git commit -am "setup"
    rm -f setup.sh
}


# ---
# MAIN
# ---

get_info
update_license
update_readme
update_report
cleanup
