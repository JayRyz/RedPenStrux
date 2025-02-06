# RedPenStrux

RedPenStrux is a simple script designed to help cybersecurity professionals quickly set up folder structures for Red Team and Penetration Testing projects. It provides a set of example files and folders to help you organize your work and stay on track during security assessments. 

This project is meant to save time when starting a new assessment and to help structure your files in a clear and consistent manner.

## Features:
- Automatically creates folder structures for Red Team and Penetration Testing projects.
- Provides example (empty) files to guide you through the typical stages of a security engagement (e.g., reconnaissance, exploitation, reporting).
- Supports multiple target devices by allowing you to create separate folders for each target (e.g., IP addresses).
  
## Structure:
The script provides the following basic folder structures for the two types of projects:

### Red Team Project Structure:
- `00_Project_Details/README.txt`
- `01_Intelligence_Gathering/intel_notes.txt`
- `02_Initial_Access/initial_access.txt`
- `03_C2_Infrastructure/c2_setup.txt`
- `04_Internal_Enumeration/internal_enum.txt`
- `05_Privilege_Escalation/priv_esc_notes.txt`
- `06_Action_On_Objectives/action_plan.txt`
- `07_Reporting/redteam_report.md`

### Penetration Testing Project Structure:
- `00_Project_Details/README.txt`
- `01_Reconnaissance/Active/active_scan_results.txt`
- `01_Reconnaissance/Passive/passive_scan_results.txt`
- `02_Scanning/nmap_scan.txt`
- `03_Exploitation/exploit_notes.txt`
- `04_Privilege_Escalation/priv_esc_methods.txt`
- `05_Post_Exploitation/post_exploit_notes.txt`
- `06_Reporting/report.md`

## How It Works:
1. Clone the repository and navigate to the project folder.
2. Run the script to automatically generate folder structures and example files.
3. You can specify a target path for where the folders should be created.
4. Optionally, you can provide multiple IP addresses or machine names to generate separate folder structures for each.

## Installation:
To get started, clone the repository and run the script:

```bash
git clone https://github.com/JayRyz/RedPenStrux
cd RedPenStrux
chmod +x redpenstrux.sh
./redpenstrux.sh
