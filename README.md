# PRTG-CortexXDR-Incident-Sensor-Powershellscript
A PowerShell script that connects to the Cortex XDR REST API, reads incident statuses, and creates a custom sensor for PRTG.

# Install
## Base Installation
1. Install the Cortex XDR PowerShell module by lahell  
   *(Note: This module is no longer maintained, but it still works.)*

2. Generate an API Key and API Key ID in the Cortex XDR Console using **Advanced Settings**  
   Cortex XDR API Documentation

3. Identify your Cortex XDR tenant name and region by checking the URL of your Cortex XDR console:  
   `https://<YOURCOMPANY>.xdr.<YOURREGION>.paloaltonetworks.com/login`

4. Download the script `PRTG-XDRCortexIncident.ps1` and place it on your PRTG probe under:  
   `C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML`

---

## Script Usage

1. In PRTG, add an **EXE/Script Advanced Sensor** to your probe.
2. Name the sensor, e.g., *Cortex XDR Incident Status*.
3. In the **EXE/Script** dropdown, select the script.
4. Set the following parameters:

| Parameter   | Example                                | Description                                      |
|-------------|----------------------------------------|--------------------------------------------------|
| APIID     | `99`                                   | The ID of your generated API Key (numeric)       |
| APIKey    | `ljnsadfjkandskjfnasdjkfnjadsnffjasdnfj` | Your generated API Key                           |
| Region    | `YOURREGION`                           | Region of your tenant (see Base Installation)    |
| tenant    | `YOURCOMPANY`                          | Name of your tenant in Cortex XDR                |

### Example usage in PRTG:
> -APIID "99" -APIKey "ljnsadfjkandskjfnasdjkfnjadsnffjasdnfj" -tenant YOURCOMPANY -Region YOURREGION

You can test the script on your probe by executing from a powershell console
> .\PRTG-XDRCortexIncident.ps1 -APIID "99" -APIKey "ljnsadfjkandskjfnasdjkfnjadsnffjasdnfj" -tenant YOURCOMPANY -Region YOURREGION

---

## PRTG Settings
- Set your preffered channel (default is New Incident)
- Set preferred timeout and interval

### Channel Settings
- By default there is no errror and warning set, define each channel when wanted so

---

# Example Screenshot
![image](https://github.com/user-attachments/assets/3a238918-fa58-40d8-b090-572946d84080)
