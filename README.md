# Temp Fix for Resolve
Temp way to run Resolve until they fix it

If anyone is interested, here is how I fixed the Resolve / Python issue:
(I am on Fedora 43)
<br>
<br>

## Table of Contents
1. First time installation of Resolve?
2. Implement the Python workaround
3. Remove after Resolve is fixed
<br>
<br>

## First time installation of Resolve?
If this is your first time installing Resolve, and assuming BlackMagic still is using the outdated libraries, you will need to do this:

### 1. Bypass the zlib error

```bash
sudo SKIP_PACKAGE_CHECK=1 ./DaVinci_Resolve file name -i
```

### 2. Move the outdated libs
```bash
cd /opt/resolve/libs && sudo mkdir disabled-libraries && sudo mv libglib* libgio* libgmodule* disabled-libraries
```
<br>
<br>

## Implement the Python workaround

### 1. Move to your home directory:
```bash
cd ~
```
### 2. Install Python3.13
```bash
sudo dnf in python3.13
```
### 3. Create a virtual env in your home directory:
```bash
python3.13 -m venv resolve_venv
```
### 4. Create a script that will automate the launch process:
```bash
nano run_resolve.sh
```
Add the following:
```bash
#!/bin/bash

# Set virtual environment directory
VENV_DIR="$HOME/resolve_venv"

# Check if virtual environment exists
if [ ! -d "$VENV_DIR/bin" ]; then
    echo "Virtual environment not found at $VENV_DIR!"
    exit 1
fi

# Activate the virtual environment
source "$VENV_DIR/bin/activate"

# Verify Python version
python --version | grep -q "3.13" || { echo "Wrong Python version"; deactivate; exit 1; }

# Run the application
exec /opt/resolve/bin/resolve "$@"
```
### 5. Make it executable
```bash
chmod +x run_resolve.sh
```
### 6. Add an alias to your bashrc:
```bash
nano .bashrc
```
Add:
```bash
alias runresolve='/home/YOURHOMENSMEHERE/run_resolve.sh'
```
*(change 'YOURHOMENSMEHERE' to your home directory name)*
### 7. Reload your bashrc:
```bash
source .bashrc
```
### 8. Launch Resolve:
```bash
runresolve
```
<br>
<br>

## Remove after Resolve is fixed
### 1.Change to your home dir
```bash
cd ~
```
### 2.Remove the venv
```bash
rm -dfrv resolve_venv
```
### 3.Remove the shell script from your home dir
```bash
rm run_resolve.sh
```
### 4.Remove this alias from your bashrc
```bash
alias runresolve='/home/YOURHOMENSMEHERE/run_resolve.sh'
```
