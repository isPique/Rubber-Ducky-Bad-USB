<div align=center>

# 💀 Rubber Ducky Bad USB 💀

**This is a Visual Basic Script (VBS) that uses Windows Script Host (WSH) to perform various actions and running the Windows PowerShell script named `root.ps1` from a USB drive, it bypasses PowerShell Execution Policy and executes the PowerShell script from the USB drive.**

<br><img src="https://github.com/isPique/Rubber-Ducky-Bad-USB/assets/139041426/c637196b-5fab-4970-b9ab-b4555e8a105a" width="700">
</div>

#
<br>

# What is Rubber Ducky?

* The Rubber Ducky is an HID (Human Interface Device), which are devices such as keyboards, mouses, and joysticks that interface with humans. When these devices are connected to a computer via USB, they are not blocked by the computer's firewall. In other words, they are considered trustworthy by the system and are not subject to control. Unlike other USB inputs, which are controlled by the computer, once the USB containing the Rubber Ducky payload is encoded, the computer recognizes it as an HID. Due to this lack of scrutiny, if the device contains malicious software, it can potentially harm or hack into your computer. Therefore, I recommend not connecting unknown USB devices to your computer.

# Read before you start

* The objective of this repository is to serve as an example, it has educational purposes, and in no case does it pretend to be perfect or fully functional.

* This script (script.vbs) is for running a **regular USB** like **Rubber Ducky** with **USB-AutoRun**, not a real **Rubber Ducky USB** and is designed to collect **various system information** and **Wi-Fi Passwords** by running a script (root.ps1) on a **removable USB drive**.

* The `-ExecutionPolicy Bypass` option allows the script to run bypassing the default execution policies. This gives the user more control when running the PowerShell script, potentially bypassing advanced security measures.

# Here is an overview of what the script does:

* It starts by querying the WMI (Windows Management Instrumentation) to identify removable USB drives and their associated logical disks.

* For each USB drive found, it checks if a "Data" directory exists. If not, it creates one.

* It then proceeds to collect various system information, such as **computer info, network information, BIOS, environment variables, network interfaces, network adapters, IP configuration, routes, DNS settings, TCP connections, UDP endpoints, running processes, services, installed hotfixes**, and **system event logs**.

* If a Wi-Fi interface is present, the script collects Wi-Fi profiles and their associated passwords.

# USAGE

* Place the `root.ps1` and `script.vbs` files on your USB drive.

* After that, set up the file named `USBAC-DEMO-ENG-SETUP.exe` to install USB-AutoRun.

* After installing it, open it up. You should see something like this:
  
   ![USB-AutoRun](https://github.com/isPique/Rubber-Ducky-Bad-USB/assets/139041426/897df7dc-1352-4465-803b-3aabecce4bee)

* Click on the **Select Button** and select the `script.vbs` file on your USB.

* And then, click on the **Browse Button**. You should see something like this:

  ![Select Folder](https://github.com/isPique/Rubber-Ducky-Bad-USB/assets/139041426/42d80fcf-f8c1-4639-a9b0-1ce63432a1e3)

* Click on the **USB drive Button**, then click on the **OK Button**.

* You should see something like this:

  ![After Browse](https://github.com/isPique/Rubber-Ducky-Bad-USB/assets/139041426/5f4ddf17-8106-47b1-9fd3-a808e8aa4fbd)

* Click on the **Create Button**. It will create AutoRun folders. You should see something like this:

  ![Create AutoRun Folders](https://github.com/isPique/Rubber-Ducky-Bad-USB/assets/139041426/d92ca1d1-c16a-4af3-9b62-11cf55fe8d28)

  * You can close the app now.

* After doing all these things, congratulations! You've just created a simple **Rubber Ducky USB**. Enjoy it!

* Unplug your USB from your computer and plug it back in.

  ![PowerShell](https://github.com/isPique/Rubber-Ducky-Bad-USB/assets/139041426/224eb470-21e9-4260-96e1-07fa4ea11cb8)

  * See, it's working :>

# Donations Accepted:

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/ispique)
