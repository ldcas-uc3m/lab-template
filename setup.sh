#!/bin/bash
# Automate the process of setting up the repository for the specific project


update_report() {
    # re-create file
    rm -f report/parts/0-cover.tex
    touch report/parts/0-cover.tex

    # TODO: finish
}


update_readme() {
    # re-create file
    rm -f README.md
    touch README.md

    echo "# $lab_type: $lab_name" >> README.md

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
    echo "# Project statement" >> README.md
    echo "" >> README.md
    echo "" >> README.md
    echo "# Installation and execution" >> README.md
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


# ---
# MAIN
# ---

# get info
echo -n "Subject?: "
read subject

echo -n "Year (eg. if 22/23 put 22)?: "
read year

echo -n "Lab type (eg. Lab 1)?: "
read lab_type

echo -n "Lab name?: "
read lab_name

echo -n "Professor?: "
read prof

echo -n "Number of students?: "
read num_students

names=("Luis Daniel Casais Mezquida")
nias=("100429021")
for ((i = 1 ; i < "$num_students" ; i++)); do
    echo -n "Name $i: "
    read names[i]
    
    echo -n "NIA $i: "
    read nias[i]
done

update_readme