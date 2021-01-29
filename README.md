This is free software, consider supporting me by checking out the following:
1. Trade Crypto using my website -> https://www.freddyt.com/
   We use the same trade engine as the popular software Atomic Wallet.
2. Trade using my referral link: https://changenow.io?link_id=fe6ba5015090e3
3. Buy a .crypto or .zil domain: https://unstoppabledomains.com/r/004bc3990d814ee
4. Sign up at Binance: https://accounts.binance.us/en/register?ref=52120453
5. Sign up at Coinbase: https://www.coinbase.com/join/tarase_gz


![Sample Graph Showing MH/s](https://www.github.com/frog357/)


Intro:
MRTG was one of my favorite tools for keeping tabs on all aspects of equipment utilization. It can easily be modified to track the number of running processes, open tcp connections, cpu and ram usage, anything you want really. The program was designed with routers in mind but I like to think outside of the box.

Phoenix Miner is my favorite software for mining Ethereum. I wanted to contribute my work to the community for everyone to enjoy. I looked for a way to monitor my equipment and there was nothing free. I hate how everyone wants to cash in on whatever is trending. It took me about 3 hours to get this to release stage. It might have some issues, see implementation details below for tips on how to best use this software.


Build Requirements:
Visual Basic 6
vbAdvance - or similar method to build console aware applications.


Implementation:
Follow the steps for installing Perl and MRTG. It goes like this, download the .msi for Windows, install Perl into a directory like D:\Perl64. Extract the MRTG package to a directory like: D:\Scripts\mrtg. Create a folder like D:\Data\MineTracker. Create a .conf file for each miner that you wish to track. A few examples are provided to show you how to track a mining rig with 1 GPU and another example showing how to track 4 GPUs. The format should be very easy to understand and expand upon. This program supports reading 25 GPUs, I am not aware of the reality of such a configuration but I included it because the alphabet had 26 chars available and I was already using A. :) In each config file you start by specifying the path to where the output files will be created, I recommended earlier a directory like D:\Data\MineTracker as an example. Next is the config files have a group for each graph you wish to generate. You can delete sections if you don't care to track that data such as power or fan usage. Save the config file and now we need to setup Task Scheduler to run this every 5-10 minutes. Normally MRTG was run every 5 minutes when it was used with a router but we can adjust to run it less frequently with our use case. I recommend running it every 10 minutes. I accomplish this by creating a batch file that contains the following:
@echo off
start /min wperl D:\Scripts\mrtg\bin\mrtg D:\Data\MineTracker\Miner001.conf
sleep 4
start /min wperl D:\Scripts\mrtg\bin\mrtg D:\Data\MineTracker\Miner002.conf
sleep 4
start /min wperl D:\Scripts\mrtg\bin\mrtg D:\Data\MineTracker\Miner003.conf
sleep 4
start /min wperl D:\Scripts\mrtg\bin\mrtg D:\Data\MineTracker\Miner004.conf
Save the batch file named "run-mrtg.cmd" or "run-mrtg.bat" and point your scheduled task to execute a program and tell it to run your batch file. The trigger should be "When I login". Once the task has been created, right click and go to properties and click on the Triggers tab and click "NEW". Select "Daily", enter a time that is approx 10 minutes into the future. Change the box to the right that says "for a duration of" and select "1 Day". Next check the box at the bottom "Repeat task every" and change the dropdown to be "10 Minutes", also check the box that says "Stop task if it runs for longer than" and enter "8 minutes". This will ensure if something goes wrong the task is not hung running in the background. 


Command line options:
Example:
MRTG-MinerReport AAminer001
Output = Combined Rig speed in MH/s
MRTG-MinerReport BAminer001
Output = GPU1 speed in MH/s
MRTG-MinerReport ABminer001
Output = n/a - initial release does not support rig temp or fan %.
MRTG-MinerReport ADminer001
Output = Combined rig power usage
MRTG-MinerReport GDminer001
Output = GPU6 Power Usage in Watts


First letter selects from one of the following:
A=RIG
B=GPU1
C=GPU2
D=GPU3
E=GPU4
F=GPU5
G=GPU6
H=GPU7
I=GPU8
J=GPU9
K=GPU10
L=GPU11
M=GPU12
N=GPU13
O=GPU14
P=GPU15
Q=GPU16
R=GPU17
S=GPU18
T=GPU19
U=GPU20
V=GPU21
W=GPU22
X=GPU23
Y=GPU24
Z=GPU25

Second letter selects from the following:
A=MH/s
B=Temp (f)
C=Temp (c)
D=Power (watts)
E=Fan Speed (%)


Anything remaining is considered to be the host + optional port number. If no port is specified a default port of 3333 is assumed. You can override this like this:

MRTG-MinerReport AAminer001:3334
Output=Rig speed in MH/s



Things left for you to do:
Organize the PNG or HTML files produced in your own web page or find another method for remote viewing. I personally have a script that uploads the PNG files using ftp and I have a html page that includes the images. This method allows me to view the status remotely without having to open inbound ports on the firewall at my mining facility.


Example Config files are located in the Examples folder.


Need some further help? Reach out to me at zilliqafred@gmail.com



https://www.virustotal.com/gui/file/37ca2694e516038024c62d31fe0fe4298c624a172015cdb163d0ecb9ebab0ee1/detection