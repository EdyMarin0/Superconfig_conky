--==================================
--
-- Superconfig_conky Settings
--
-- Version: 1.2.1
--
-- Creator: Edy Marin
--
--==================================

local cfg = {
    -- placement
    monitor = 1, -- ID of the monitor on which to be displayed
    monitor_dpi = 96, -- fallback value if the automated DPI calculator fails

    -- refresh rates
    main_update_interval = 1, -- update interval of the main window and all elements within
    secondary_update_interval = 0.1, -- update interval used for secondary windows to render graphics

    -- CPU
    cpu_cores = 12, -- number of cores to be shown in the graph, in numerical order
    cpu_temp_chip = 'coretemp-isa-0000', -- full hwmon chip identifier from sensors output. Intel example: 'coretemp-isa-0000'. AMD example: 'k10temp-pci-00c3'
    cpu_temp_label = 'Package id 0', -- exact label from sensors output to match. Intel example:'Package id 0'. AMD example: 'Tctl' or 'Tdie'
    cpu_temp_sensor = 'coretemp', -- shortened version of chip name for hwmon
    cpu_temp_index = 1, -- shortened label for hwmon

    -- Fans
    fan_chip = 'asus',
    cpu_fan_id = 1,
    gpu_fan_id = 2,

    -- Drives
    number_of_drives = 1, -- Select the number of drives to be displayed. Up to 4 maximum (hard coded. more drives require the code to be changed). Set to 0 to disable storage showing up
    drive_name_1 = 'partuuid:0bc926b9-1ccb-421f-ba3a-e09298877969', -- Select the name of the drive to be monitored. Check for the specific name in your system ("sda" "nvme0n1"). Can accept labels ('label:PARTITION LABEL') or partuuid ('partuuid:YOUR PARTITION ID') formats for a more stable setup (device names can change on reboot)
    drive_name_2 = 'nvme0n1', -- Example using drive name. Might change upon reboot
    --drive_name_3 = 'label:Storage', -- Example using label. Not all drives/partitions have labels
    drive_name_3 = 'nvme0n1',
    drive_name_4 = 'nvme0n1',

    -- Drive paths
    -- Number of non-empty values have to match the number of drives selected above
    drive_path = {
        [1] = '/', -- mount point for drive 1. Examples: '/', '/home', '/mnt/data', '/run/media/username/DriveLabel'
        [2] = '/',
        [3] = '/',
        [4] = '/',
    },

    -- Battery
    display_battery_info = 1, -- Display battery info after the drives section. Any other value than '1' disables it
    battery_id = 'BAT1', -- battery ID as found in /sys/class/power_supply/

    -- Icon variants
    icon_var = '1', -- icon variant id for the icons. 1 = background, 2 = no background. For custom icons follow the naming convention and add the icons to the "icons folder"

    -- Icon sizes
    icon_width = 40, -- icon size in px. Check the icons you use
    icon_height = 40,
    icon_gap = 10, -- gap between icon and in line graph
    graph_gap = 5, -- gap between two graphs on the same line (Temperature, Drives)

    -- Icon change thresholds
    cpu_threshold = 90, -- CPU utilistation percentage
    cpu_temperature_threshold = 80, -- CPU temperature
    ram_threshold = 80, -- RAM use percentatge
    gpu_threshold = 80, -- GPU utilisation percentage
    gpu_temperature_threshold = 80, -- GPU temperature
    battery_threshold = 20, -- Battery percent

    -- Conky window size
    window_x = 20, -- horizontal offset from edge. Set to zero when using '..._middle' position for true centering
    window_y = 20, -- vertical offset from edge. Set to zero when using 'middle_...' position for true centering
    window_position = 'top_left', -- window position. Valid options (top/middle/bottom) + (left/middle/right)
    window_height = 500, -- adjust manually based on the number of drives if it does not automatically adjust
    window_width = 240,
    window_border_distance = 10, -- distance between elements and window edge

    -- Conky window colors
    window_color = '801D1D1D', -- window background color, including alpha value at the start

    -- Conky elemts colour
    main_color = '00ffcc',
    accent_color_1 = '00aa88',
    accent_color_2 = '009c78',
    low_color = '009779', -- color used for low values on conky graphs
    high_color = '00ffcc', -- color used for high values on conky graphs
    text_color = 'ffffff',

    -- Conky fonts
    font_name = 'Noto Sans', -- font family name to be used
    font_size = 10, -- font size to be used

    -- Conky elements
    horizontal_line_thickness = 3, -- horizontal separator line thickness
    horizontal_line_offset = -15, -- offset of horizontal separator lines. Negative numbers brings the line closer to the icon

    -- Lua table colors
    graph_color = '00ffcc', -- main color of the columns
    graph_background = 'ffffff', -- color of the column shadow box. Not the colour of the entire graph background
    graph_alpha = 1, -- transparency of the columns. Valid range: 0 (transparent) - 1 (opaque)
    graph_background_alpha = 0.08, -- transparency of the column shadow box. Valid range: 0 (transparent) - 1 (opaque)

    -- Lua graphs
    -- CPU Cores graph
    bar_height = 80, -- max height of the CPU core graph
    bar_gap = 5, -- gap width between columns, in px

    -- Battery percent graph
    battery_graph_height = 20, -- Height of the battery percent bar. Shoul not excede icon height
}

return cfg
