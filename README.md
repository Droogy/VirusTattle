# VirusTattle by Droogy
---
VirusTattle is a bash script which leverages the VirusTotal API to run a basic scan on malicious files/URLs.
---

## Usage

- Please note that this script will not accept files larger than 32MB.
- First register an account over at VirusTotal and get your free API keys.
- Next, export your API key in your terminal before running the script.
```bash
export API_KEY=<VirusTotal API key>
```
- Make the file executable.
```bash
chmod +x ./VirusTattle
```
- Run the script with -f to run in file mode.
- Run the script with no arguments to run in URL mode.
- Follow the prompt and get a pretty-printed JSON output of the analysis at the end!