#!/bin/bash

driver=$(chromedriver --version 2>/dev/null)
chrome=$(google-chrome-stable --version 2>/dev/null)

# Get first and second word (Google Chrome)
first_word=$(echo "$chrome" | cut -d ' ' -f 1)
second_word=$(echo "$chrome" | cut -d ' ' -f 2)
#Get version
chrome_ver=$(echo "$chrome" | cut -d ' ' -f 3)

if [ "$first_word" != "Google" ] || [ "$second_word" != "Chrome" ]; then
  echo "Error: Google Chrome Stable (google-chrome-stable) is not installed."
  exit 1
fi
# Check if user want to update or install
ask_user_to_continue() {
 input=$1
 input=$(echo "$input" | tr '[:upper:]' '[:lower:]')
 if [ "$input" != "y" ]; then
   echo "Installing/Updating canceled. Exiting..."
   exit 1
 fi
}

download_or_install_driver() {
 ver=$1
 url=https://storage.googleapis.com/chrome-for-testing-public/$ver/linux64/chromedriver-linux64.zip
 echo "Downloading ChromeDriver from: $url"

 # Ensure dependencies are installed
 if ! command -v wget &>/dev/null; then
   echo "Installing wget..."
   sudo dnf install wget2 -y || { echo "Failed to install wget"; exit 1; }
 fi
 if ! command -v unzip &>/dev/null; then
   echo "Installing unzip..."
   sudo dnf install unzip -y || { echo "Failed to install unzip"; exit 1; }
 fi

 # Download and Extract
 wget -O chromedriver-linux64.zip "$url" || { echo "Download failed!"; exit 1; }
 unzip -o chromedriver-linux64.zip || { echo "Failed to unzip ChromeDriver."; exit 1; }

 # Move the binary and set correct permissions
 # shellcheck disable=SC2164
 sudo cp chromedriver-linux64/chromedriver /usr/bin/chromedriver
 sudo chown root /usr/bin/chromedriver
 sudo chmod +x /usr/bin/chromedriver
 sudo chmod 755 /usr/bin/chromedriver

 # Cleanup
 rm -rf chromedriver-linux64 chromedriver-linux64.zip
 echo "ChromeDriver $ver installed successfully."
}
# Check if Chrome Driver is installed or not
if [ "$(echo "$driver" | cut -d ' ' -f 1)" != "ChromeDriver" ]; then
  echo "ChromeDriver is not installed!"
  # shellcheck disable=SC2162
  read -p "Do you want to install ChromeDriver? (y/n) : " user_input
  ask_user_to_continue "$user_input"
  echo "Installing ChromeDriver ..."
  download_or_install_driver "$chrome_ver"
else
  driver_ver=$(echo "$driver" | cut -d ' ' -f 2)

  echo "Driver version: $driver_ver"
  echo "Chrome version: $chrome_ver"

  # Check if Chrome Driver is up to date or not
  if [ "$driver_ver" == "$chrome_ver" ]; then
    echo "Chrome Driver is up to date."
  else
    echo "Chrome Driver is outdated!"
    # shellcheck disable=SC2162
    read -p "Do you want to update ChromeDriver? (y/n): " user_input
    ask_user_to_continue "$user_input"
    echo "Updating ChromeDriver ..."
    download_or_install_driver "$chrome_ver"
  fi
fi