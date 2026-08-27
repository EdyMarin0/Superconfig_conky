# Superconfig_conky
A custom Conky configuration that is very easy to configure to your liking

# Set-up
Instal _conky_ and _lm_sensors_. After installing those, download the _conky_ folder from this project and drop it in your _~/.config/_ folder.

## Running it
### 1. Manual
Inside the _conky_ folder you can find a _start_conky.sh_ file. Running that will launch a ConkyMain window with background blur enabled (if system theme has it).
Alternatively run _conky -c ~/.config/conky/conky.conf_ to prevent any blur effects.\
**NOTE**: some sensor names will differ from system to system. See "Configure it" section for how to remedy that.
\
### 2. Automatic
To enable automatic Conky launch at start-up/login, set _restart_conky.sh_ to autostart in your preferred way.\
**NOTE**: On KDE Plasma, the session restore setting duplicates Conky windows upon restart/restore. The _restart_conky.sh_ kills all existing Conky processes and launches a new one to fix this bug. If you have any other Conky processes running, they will have to be restarted after _restart_conky.sh_ runs.

## Configure it
### 1. Main config

Inside the _conky_ folder you can find _settings.lua_. This is the main way to configure this Conky theme. Most elements can be configured via this file.\
After editing the _settings.lua_ and saving it, run _restart_conky.sh_ for the settings to apply (the new settings will appy only after a system restart otherwise).

Some variable names are system specific for certain sensors (cpu temp sensor, fan controller, etc.). Please see the comments inside _setings.lua_ and change them to your specific system.

**NOTE**: The current setup works only for NVidia GPUs. I cannot test a AMD GPU version on my system. If you have modified my code to work on AMD GPUs, please let me know, and I will add it to this project.

### 2. Icons

Two sets of icons are provided by default (with and without a background). To toggle between them, change the value of _ icon_var_ inside _settings.lua_.\
\
Additionally, you can bring/make your own custom icons, as long as they follow the naming convention bellow:\
<ins>For CPU:</ins>

cpu_low_X.png\
cpu_high_X.png\
\
<ins>For GPU:</ins>

gpu_low_X.png\
gpu_high_X.png\
\
<ins>For RAM:</ins>

ram_low_X.png\
ram_high_X.png\
\
<ins>For Temperature:</ins>

temp_low_X.png\
temp_high_X.png\
\
<ins>For Battery:</ins>

battery_low_X.png\
battery_high_X.png\
\
<ins>For Drives:</ins>

drive_X.png\
\
Where X can be any number from 3 to infinity.\
To switch to your custom icon set, change _ icon_var_ inside _settings.lua_ to the number you chose to replace X.
If the custom icons have any size other than **40 * 40 px**, change the _icon_width_ and _icon_height_ inside _settings.lua_ to match your icons. All icons in a set must have the same size. You can find the original SVG used to create the icons inside _master_icons_. You can use those if you just want a simple color change of the icons.\
This theme is set up to change the icons displayed based on thresholds (except for drives) found in _settings.lua_. To disable that, change the threshold to "101" (except for battery, which should be changed to "0").\

### 3. Colors
The color of all of the elements can be changed from the _settings.lua_ file\
\
Currently _main_color_ and _accent_color_2_ are not used\
The horizontal line separator color is set by _accent_color_1_\
The color of the graphs (except CPU core graph) are set via _low_color_ and _high_color_.\
The color of the CPU core graph is set via _graph_color_ for the bars and _graph_background_ for the shadow. Transparency settings for the CPU core graph can be set via _graph_alpha_ (for the bars) and _graph_background_alpha_ (for the bar shadows).\
The color and transparency of the Conky window can be set via _window_color_ and _window_transparency_ respectively.\
\
All colors take 6 character hex codes (without the \#) unless otherwise stated. Please see the comments inside _settings.lua_ for valid ranges.

### 4. Drives
Up to 4 drives can be monitored at the same time. They do not have to be different drives (see bellow). Specify the number of drives to be monitored via _number_of_drives_ in _settings.lua_.

Inside _settings.lua_ specify the name of the drive (in _drive_name_ 1 through 4) as reported by _lsblk_ (e.g. _nvme0n1_, _sda_ etc.) or similar tools and the folder path where the drive is mounted (such as '/' or '/mnt/data/' etc.)/
**NOTE**: Drive name can change in machines every boot. To avoid that, you can use partuuid or label (if available) for a more stable behaviour on reboot.\
The _drive_name_ dictates the drive to be monitored for reads & writes, while _drive_path_ selects the folder to be monitored for used & total space.\
If you want two different folders of the same drive to be monitored for space, set the _drive_name_2_ (or 3/4) to the same name as _drive_name_1_, and specify the desired secondary folder to be monitored as _drive_path\_[2]_ (or 3/4).

### 5. Battery
Battery monitoring can be toggled via _display_battery_info_ in _settings.lua_. It is turned on ('1') by default. To turn it off, change _display_battery_info_ to any other value.

Battery name is required for proper monitoring. See the comments in _settings.lua_ for more details.\
**NOTE**: A battery with "unknown" status will show as "Stand-by". If you have a max charge percentage set in your system, the battery status will be "unknown" once the max charge level is reached, and will show as "Stand-by".
