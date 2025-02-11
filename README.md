# Linux ChromeDriver Manager

A simple and automated Bash script to install and update ChromeDriver on Linux.

## Features
- Checks if **Google Chrome** and **ChromeDriver** are installed
- Installs ChromeDriver if missing
- Updates ChromeDriver to match the installed Chrome version
- Ensures dependencies (`wget`, `unzip`) are installed
- Works on **Fedora-based** distributions (uses `dnf` for package management)

## Installation
Clone the repository:

```bash
git clone https://github.com/BahramF73/linux-chromedriver-manager.git
cd linux-chromedriver-manager
```

## Usage
Run the script:

```bash
chmod +x linux-chromedriver-manager.sh
./linux-chromedriver-manager.sh
```

## Requirements
- **Linux OS** (Tested on Fedora-based distributions)
- **Google Chrome Stable** must be installed (`google-chrome-stable`)
- **wget** and **unzip** (script installs them if missing)

## Notes
- Ensure you run the script with appropriate permissions.
- If running on a non-Fedora system, modify the package manager commands accordingly.

## License
MIT License

## Contributions
Pull requests are welcome! If you encounter any issues, feel free to open an issue.

---

Let me know if you want any modifications!

