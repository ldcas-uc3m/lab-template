#!/bin/bash
# Automate the process of setting up the repository for the specific project


get_info() {
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
    # re-create LaTeX file
    rm -f report/parts/0-cover.tex
    touch report/parts/0-cover.tex

    echo "\begin{titlepage}" >> report/parts/0-cover.tex
    echo "    \begin{sffamily}" >> report/parts/0-cover.tex
    echo "    \color{azulUC3M}" >> report/parts/0-cover.tex
    echo "    \begin{center}" >> report/parts/0-cover.tex
    echo "        % university logo" >> report/parts/0-cover.tex
    echo "        \begin{figure}[H]" >> report/parts/0-cover.tex
    echo "            \makebox[\textwidth][c]{\includegraphics[width=5cm]{img/uc3m_logo.png}}" >> report/parts/0-cover.tex
    echo "        \end{figure}" >> report/parts/0-cover.tex
    echo "        \vspace{1.5cm}" >> report/parts/0-cover.tex
    echo "        \begin{Large}" >> report/parts/0-cover.tex
    echo "            Bachelor's degree in Computer Science and Engineering\\\\" >> report/parts/0-cover.tex
    echo "            $subject\\\\" >> report/parts/0-cover.tex
    echo "            20$year-20$((year+1))\\\\" >> report/parts/0-cover.tex
    echo "            \vspace{2cm}" >> report/parts/0-cover.tex
    echo "            \textsl{$lab_type}" >> report/parts/0-cover.tex
    echo "            \bigskip" >> report/parts/0-cover.tex
    echo "" >> report/parts/0-cover.tex
    echo "        \end{Large}" >> report/parts/0-cover.tex
    echo "            {\Huge \`\`$lab_name''}\\\\" >> report/parts/0-cover.tex
    echo "            \vspace*{0.5cm}" >> report/parts/0-cover.tex
    echo "            \rule{10.5cm}{0.1mm}\\\\" >> report/parts/0-cover.tex
    echo "            \vspace*{0.9cm}" >> report/parts/0-cover.tex

    # authors
    for ((i = 0; i < "$num_students"; i++)); do
        echo "            {\LARGE ${names[i]} - ${nias[i]}}\\\\" >> report/parts/0-cover.tex
        echo "            \vspace*{0.2cm}" >> report/parts/0-cover.tex
    done

    echo "" >> report/parts/0-cover.tex
    echo "            \vspace*{0.8cm}" >> report/parts/0-cover.tex
    echo "        \begin{Large}" >> report/parts/0-cover.tex
    echo "            Professor:\\\\" >> report/parts/0-cover.tex
    echo "            $prof\\\\" >> report/parts/0-cover.tex
    echo "        \end{Large}" >> report/parts/0-cover.tex
    echo "    \end{center}" >> report/parts/0-cover.tex
    echo "    \vfill" >> report/parts/0-cover.tex
    echo "" >> report/parts/0-cover.tex
    echo "    \end{sffamily}" >> report/parts/0-cover.tex
    echo "\end{titlepage}" >> report/parts/0-cover.tex
}


update_readme() {
    # re-create GFM file
    rm -f README.md
    touch README.md

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


cleanup() {
    git commit -am "setup"
    rm -f setup.sh
}


# ---
# MAIN
# ---

get_info
update_readme
update_report
cleanup
