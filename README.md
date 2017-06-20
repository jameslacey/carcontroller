# carcontroller
You can view detailed information about the remote control car at http://jamesl.tk/gallery.html
I can be reached as jamesl on IRC (Freenode and Foonetic) if you would like more information.

The remote control car is controlled by two scripts, control.sh is on a raspberry pi zero in the controller, it runs as 
init, so is executed shortly after the kernel boots. It receives inputs from GPIO pins and transmits them through a Slice of Radio. 

Another script runs on a XinoRF (Arduino UNO compatible with a radio module preinstalled) on the car itself and controls the motors and lights using a motor shield. A Raspberry Pi running wifibroadcast also transmits video from the onboard camera over wifi, to be received using a wifi dongle and a laptop. This is useful for controlling it remotely.

I have made these publicly accessible so that others can design remote control projects using these files, adapting them for their needs.

Resources:

http://jamesl.tk/faq.html My website's FAQ

https://befinitiv.wordpress.com/wifibroadcast-analog-like-transmission-of-live-video-data/ Wifibroadcast, used on the Raspberry Pi to transmit video, and on the laptop to receive video

https://shop.pimoroni.com/products/xinorf-100-arduino-uno-r3-based-dev-board-with-radio-transceiver Information about the XinoRF, used on the remote control car

https://shop.pimoroni.com/products/slice-of-radio-wireless-rf-transciever-for-the-raspberry-pi Information about the Slice of Radio used in the car

You will need:
* A Raspberry Pi (while the code can be run on any Linux computer with a serial port, there is some Raspberry Pi-specific code.)
* A slice of radio connected to the Raspberry Pi's UART
* Raspbian Lite distribution for Raspberry Pi.

Place this file in the root directory of your SD card and make it executable. Then add "init=/control.sh" to /boot/cmdline.txt
After rebooting, the LEDs on the Slice of Radio should flash, indicating operation.
