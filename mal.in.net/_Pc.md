# My PC

I have only one PC. Since I assembled it using some loose parts lying around and found online for cheap, it's not too beefed by today's standards. Nonetheless, it can run an [up-to-date Linux](https://archlinux.org) just fine. What stands out is its ability to flawlessly run Windows 98 SE.

The Internet says modern PCs can't run Windows 98, because it does not support PCI-Express, drivers are missing etc. Over the past few months, thanks to the various [forums](https://www.vogons.org/) and [YouTube channels](https://www.youtube.com/@O_mores), I learned this is not entirely true. Long story short, all you need are expansion cards, which Windows 98 has drivers for, and a little luck when picking a mainboard.

[![PC](images/380px-PC.jpg "PC")](images/PC.jpg)
[![Inside the PC](images/380px-PC_inside.jpg "Inside the PC")](images/PC_inside.jpg)


## Specifications

- Mainboard: Asus H61M-K (LGA1155)
- CPU: Intel Xeon E3-1225 v2 (4 x 3.2GHz, 8MB Cache)
- RAM: 2 x GoodRam DDR3-1333 8GB (16GB total)
- Integrated GPU: Intel HD P4000
- Discrete GPU: ATI Radeon X550
- No-Name ASM1083-based PCIe to PCI Adapter:
    - Sound Card: Creative Sound Blaster Audigy 2 (SB0240)
    - USB PCI Card: No-Name VT6212L-based
- 1st Storage: 2.5' SATA SSD GoodRam 240GB MLC (Bootloader and Windows 98 system drive)
- 2nd Storage: M.2 NVMe SSD Intel 256GB (Linux system drive)
- 3rd Storage: 2.5' SATA HDD Toshiba 2TB (Storage drive)
- Optical Drive: Samsung DVD-RW over ATA ---> SATA adapter
- Power Supply: be quiet! System Power 7 300W
- Display: Lenovo P24h-10 + OSSC 1.6
- Case: Fractal Pop Silent Black TG

Let me quickly go over the parts, to give you rationale behind them.


### Mainboard, CPU and RAM

This is the loose part I started from. It allowed me to install Windows 98 and run 3DMarks without a hitch, so I decided to proceed with this one.

Initially the board had a Pentium CPU and 4GB of RAM installed. Later I updated its BIOS and maxed it out with the Xeon and 16GB of RAM, which I got online for pennies. According to the [Wikipedia](https://en.wikipedia.org/wiki/List_of_Intel_Xeon_processors_(Ivy_Bridge-based)) there are three more 1155 Xeons, which have an iGPU and are positioned higher than 1225v2, but they are ridiculously expensive.

What is worth noting here is that I also tried a MSI B250M Bazooka Opt Boost, which is a newer board with Skylake and Kabylake CPU support. I managed to install Windows 98, but it kept assigning the same IRQ to all PCI devices, so I had to ditch it. Bummer, since it's a better board.


### Discrete GPU and Sound Card

Since Windows 98 has no drivers for the integrated Intel GPU, I decided to add a Radeon X550. I chose this model because it's supported by the latest Catalyst drivers for Windows 98, it's cheap, passively cooled and has enough power for the most games I want to play. For Linux I blacklisted the *radeon* module and use only the integrated GPU.

The Sound Blaster works fine with both Windows 98 and Linux, so I decided to use it with both OSes and keep the integrated one disabled.


### USB PCI Card

Every mainboard I've seen so far has a BIOS option called like "Legacy USB Support". In a nutshell, it's purpose is to emulate a USB Mouse and a USB Keyboard connected to the mainboard as PS/2 devices. It makes them usable in "Legacy OSes" like DOS, as well as in the BIOS itself. The problem is that the emulation can be buggy, which in my case manifests in odd acceleration of the mouse cursor.

The workaround for the issue is to use the USB Mouse natively. Windows 98 does not have drivers for the USB ports provided by the mainboard, thus the USB PCI Card, which Windows 98 has drivers for, is needed. Long story short, the only purpose of this card is to provide a USB port for the Mouse.


### Storage

I use SYSLINUX as a bootloader. In order to boot an OS installed on a FAT32 partition from SYSLINUX, both the FAT32 parition and SYSLINUX partition need to be on the same disk.

The NVMe SSD is connected through PCIe X1. This is a bottleneck for the drive, but it's still faster than the SATA SSD, so I use it for Linux.
