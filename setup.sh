#!/bin/bash
# Automate the process of setting up the repository for the specific project


get_info() {
    echo -n "Subject?: "
    read subject

    echo -n "Year (eg. if 22/23 put 22)?: "
    read year
    year=20$year-20$((year+1))

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
        echo "Please enter the names in alphabetical order"
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
    sed -i "s/[\\]def[\\]subject[{]Subject[}]/\\\\def\\\\subject{$subject}/g" report/parts/0-cover.tex
    sed -i "s/[\\]def[\\]year[{]2022-2023[}]/\\\\def\\\\year{$year}/g" report/parts/0-cover.tex
    sed -i "s/[\\]def[\\]labType[{]Lab[}]/\\\\def\\\\subjlabTypeect{$lab_type}/g" report/parts/0-cover.tex
    sed -i "s/[\\]def[\\]labName[{]Name[}]/\\\\def\\\\labName{$lab_name}/g" report/parts/0-cover.tex
    sed -i "s/[\\]def[\\]proffesor[{]Name[}]/\\\\def\\\\proffesor{$prof}/g" report/parts/0-cover.tex
    

    # count lines til author
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
    # re-create GFM file
    rm -f README.md
    touch README.md
    
    # TODO: change echos for something better bruh
    
    echo "# $lab_type: $lab_name" >> README.md

    # authors
    echo -n "By " >> README.md
    for ((i = 0; i < "$num_students"; i++)); do
        if (( i < $num_students - 2)); then
            echo -n "${names[i]}, " >> README.md
        elif (( i < $num_students - 1)); then
            echo -n "${names[i]} & " >> README.md
        else
            echo "${names[i]}  " >> README.md
        fi
    done

    echo "$subject $year/$((year+1))  " >> README.md
    echo "Bachelor's Degree in Computer Science and Engineering, grp. 89  " >> README.md
    echo "Universidad Carlos III de Madrid" >> README.md
    echo "" >> README.md
    echo "## Project statement" >> README.md
    echo "" >> README.md
    echo "" >> README.md
    echo "## Installation and execution" >> README.md
}


debug() {

    echo "$subject"
    echo "$year"
    echo "$((year+1))"
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


cleanup() {
    # git commit -am "setup"
    rm -f setup.sh
}


# ---
# MAIN
# ---

get_info
update_readme
update_report
cleanup
