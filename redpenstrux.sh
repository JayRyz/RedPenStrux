#!/bin/bash

# This is the default path if no path is given.
DEFAULT_PATH="$HOME/Infosec"

# Flags to determine which folder structure to create
REDTEAM=false
PENTEST=false
HELPMENU=false
MULTI=false
CREATEFILES=false

# Parse command line options.
while getopts ":p:PRMFh" opt; do
    case $opt in
        p) 
            if [[ -z "$OPTARG" || "$OPTARG" =~ ^- ]]; then
                echo "Error: -p requires an argument." >&2
                exit 1
            fi
            TARGET_PATH="$OPTARG" ;;
        P) PENTEST=true ;;
        R) REDTEAM=true ;;
        h) HELPMENU=true ;;
        M) MULTI=true ;;
        F) CREATEFILES=true ;;
        *) echo "Error, see -h for usage." >&2; exit 1 ;;
    esac
done

# Use default path if none is provided.
TARGET_PATH="${TARGET_PATH:-$DEFAULT_PATH}"

# Display help menu.
function helpmenu(){
    echo "Usage: $0 [-p path] [-P] [-R] [-F] [-M] [-h]"
    echo "-p [path]  Specify a target path for the structure."
    echo "-P         Create Pentest folder structure."
    echo "-R         Create Red Team folder structure."
    echo "-F         Creates example Files."
    echo "-M         Create Structure with names/IPs given."
    echo "-h         Display this help menu."
}

# Create directories based on selected project type.
function create_folders(){
    
    # Takes first argument and second argument, given while using function.
    local path=$1
    local project_type=$2
    local subfolders=()

    # Folder structure for both options.
    local pentest_folderstruct=("Network" "Project_Details" "01_Reconnaissance/Active" "01_Reconnaissance/Passive"
                                "02_Scanning" "03_Exploitation" "04_Privilege_Escalation" "05_Post_Exploitation"
                                "06_Reporting")
    local redteam_folderstruct=("Network" "Project_Details"
                                "01_Intelligence_Gathering" "02_Initial_Access/phishing_campaigns"
                                "02_Initial_Access/web_exploits" "02_Initial_Access/bruteforce"
                                "03_C2_Infrastructure/reverse_shells" "04_Internal_Enumeration"
                                "05_Privilege_Escalation/Windows" "05_Privilege_Escalation/Linux"
                                "06_Action_On_Objectives" "07_Reporting")

    # Select structure based on project type.
    if [[ $project_type == "redteam" ]]; then
        subfolders=("${redteam_folderstruct[@]}")
    elif [[ $project_type == "pentest" ]]; then
        subfolders=("${pentest_folderstruct[@]}")
    fi
    
    echo "Creating folder structure at target path: ${TARGET_PATH}"
    # Creates the folders with mkdir command.
    for folder in "${subfolders[@]}"; do
        mkdir -p "$path/$folder"
    done

    if [[ $CREATEFILES == true ]]; then
        create_files "$path" "$project_type"
    fi

    if [[ $MULTI == true ]]; then
        multi "$path" "$project_type"
    fi
}

# Creating empty example files
function create_files(){
    
    local path=$1
    local project_type=$2
    local empty_files=()

    local pentest_files=(
        "Network/nmap_network_scan.txt"
        "Project_Details/README.txt"
        "Project_Details/scope.txt"
        "01_Reconnaissance/Active/active_scan_results.txt"
        "01_Reconnaissance/Passive/passive_scan_results.txt"
        "02_Scanning/nmap_scan.txt"
        "03_Exploitation/exploit_notes.txt"
        "04_Privilege_Escalation/priv_esc_methods.txt"
        "05_Post_Exploitation/post_exploit_notes.txt"
        "06_Reporting/report.md"
    )
    local redteam_files=(
        "Network/nmap_network_scan.txt"
        "Project_Details/README.txt"
        "Project_Details/scope.txt"
        "01_Intelligence_Gathering/intel_notes.txt"
        "02_Initial_Access/initial_access.txt"
        "03_C2_Infrastructure/c2_setup.txt"
        "04_Internal_Enumeration/internal_enum.txt"
        "05_Privilege_Escalation/priv_esc_notes.txt"
        "06_Action_On_Objectives/action_plan.txt"
        "07_Reporting/redteam_report.md"
    )

    if [[ $project_type == "redteam" ]]; then
        empty_files=("${redteam_files[@]}")
    elif [[ $project_type == "pentest" ]]; then
        empty_files=("${pentest_files[@]}")
    fi

    echo "Creating empty files..."
    for file in "${empty_files[@]}"; do
        touch "$path/$file"
    done
}

# Function for creating subfolders with names for example IPs.
function multi(){
    
    local path=$1
    local project_type=$2
    local place_in=()

    local place_in_pen=("01_Reconnaissance/Active"
                        "02_Scanning"
                        "04_Privilege_Escalation"
                        "05_Post_Exploitation"
    )
    local place_in_red=("04_Internal_Enumeration"
                        "06_Action_On_Objectives"
    )
    
    

    if [[ $project_type == "redteam" ]]; then
        place_in=("${place_in_red[@]}")
    elif [[ $project_type == "pentest" ]]; then
        place_in=("${place_in_pen[@]}")
    fi
    
    echo "Enter the IP addresses/names of the different target machines (separated by spaces): "
    read -r -a IP_ADDRESSES
    for dir in "${place_in[@]}"; do
        for ip in "${IP_ADDRESSES[@]}"; do
            mkdir -p "$path/$dir/$ip"
        done
    done


}


# Function looks through user input and fills the local vars.
function process_input(){
    if [[ $HELPMENU == true ]]; then
        helpmenu
        exit 0
    fi
    if [ "$REDTEAM" == true ] && [ "$PENTEST" == true ]; then
        create_folders "$1/redteam" "redteam"
        create_folders "$1/pentest" "pentest"
    elif [[ $REDTEAM == true ]]; then
        create_folders "$1" "redteam"
    elif [[ $PENTEST == true ]]; then
        create_folders "$1" "pentest"
    fi
}



# Main function
function Main(){

    process_input "$TARGET_PATH"
}

Main