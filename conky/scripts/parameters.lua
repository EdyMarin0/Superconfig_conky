--==================================
--
-- Superconfig_conky Parameters
--
-- For version 1.2
--
-- Creator: Edy Marin
--
--==================================

local settings = require 'settings'
local colors = require 'scripts.colors'

-- Automatic DPI calculator. DPI is needed to calculate the line heigh used for icon positioning
local function get_xft_dpi()
    local handle = io.popen("xrdb -query 2>/dev/null | grep -i '^Xft.dpi:' | awk '{print $2}'")
    local result = handle:read("*a")
    handle:close()
    result = result:gsub("%s+", "")
    return tonumber(result)
end

local function get_monitor_dpi(monitor_index)
    local handle = io.popen("xrandr --listactivemonitors")
    local output = handle:read("*a")
    handle:close()

    for line in output:gmatch("[^\n]+") do
        local idx, w_px, w_mm, h_px, h_mm = line:match("^%s*(%d+):.-(%d+)/(%d+)x(%d+)/(%d+)%+%d+%+%d+")
        if idx and tonumber(idx) == monitor_index then
            w_px, w_mm, h_px, h_mm = tonumber(w_px), tonumber(w_mm), tonumber(h_px), tonumber(h_mm)

            -- straight pairing: width px/mm with width, height px/mm with height
            local dpi_w1 = w_px / (w_mm / 25.4)
            local dpi_h1 = h_px / (h_mm / 25.4)
            local diff1 = math.abs(dpi_w1 - dpi_h1)

            -- crossed pairing: handles cases where px got rotated but mm didn't
            local dpi_w2 = w_px / (h_mm / 25.4)
            local dpi_h2 = h_px / (w_mm / 25.4)
            local diff2 = math.abs(dpi_w2 - dpi_h2)

        -- whichever pairing gives closer-matching horizontal/vertical DPI is correct,
        -- since real square pixels always have equal DPI on both axes
            if diff1 <= diff2 then
                return math.floor(((dpi_w1 + dpi_h1) / 2) + 0.5)
            else
                return math.floor(((dpi_w2 + dpi_h2) / 2) + 0.5)
            end
        end
    end
    return settings.monitor_dpi  -- fallback if parsing fails or monitor index not found
end

local monitor_dpi = get_xft_dpi() or get_monitor_dpi(settings.monitor)

local param = {}

-- Conky-syntax font string, built from settings.font_name / settings.font_size
param.conky_font = settings.font_name .. ":size=" .. settings.font_size

-- Line height (measured via external Python/FreeType script — Conky's config-parsing
local venv_python = os.getenv('HOME') .. '/.config/conky/scripts/venv/bin/python3'
local script_path = os.getenv('HOME') .. '/.config/conky/scripts/line_height.py'
local cmd = string.format("%s %s '%s' %d %d", venv_python, script_path, settings.font_name, settings.font_size, monitor_dpi)

local handle = io.popen(cmd)
local result = handle:read("*a")
handle:close()

param.line_height = tonumber(result) or settings.font_size * 1.2  -- fallback estimate if the script fails

-- Conky graphs sizing
param.graph_width = settings.window_width - settings.icon_width - settings.icon_gap
param.graph_height = settings.icon_height
param.graph_half_height = settings.icon_height // 2
param.graph_half_width = (param.graph_width - settings.graph_gap) // 2
param.graph_offset = -(param.line_height / 2)

-- Lua graphs position
param.graph_position = settings.icon_height + 4 * param.line_height + param.graph_offset + settings.horizontal_line_offset
param.battery_graph_position_x = settings.window_border_distance + settings.icon_width + settings.icon_gap
param.battery_graph_position_y = 4 * settings.icon_height + 22 * param.line_height + settings.bar_height + 4 * param.graph_offset + 5 * settings.horizontal_line_offset + settings.number_of_drives * (5 * param.line_height + settings.icon_height + param.graph_offset + settings.horizontal_line_offset) + settings.window_border_distance + (settings.icon_height - settings.battery_graph_height) // 2

-- Lua graph colours conversion
param.graph_rgb = colors.hex_to_rgb(settings.graph_color, settings.graph_alpha)
param.graph_background_rgb = colors.hex_to_rgb(settings.graph_background, settings.graph_background_alpha)

-- Icon positions
-- add one extra param.line_height for every text line in a section to every section following the one modified
param.ram_icon_y = settings.icon_height + 4 * param.line_height + settings.bar_height + param.graph_offset + settings.horizontal_line_offset
param.gpu_icon_y = 2 * settings.icon_height + 8 * param.line_height + settings.bar_height + 2 * param.graph_offset + 2 * settings.horizontal_line_offset
param.temp_icon_y = 3 * settings.icon_height + 13 * param.line_height + settings.bar_height + 3 * param.graph_offset + 3 * settings.horizontal_line_offset
param.drive_icon_y = {
    [1] = 4 * settings.icon_height + 22 * param.line_height + settings.bar_height + 4 * param.graph_offset + 5 * settings.horizontal_line_offset,
    [2] = 5 * settings.icon_height + 27 * param.line_height + settings.bar_height + 5 * param.graph_offset + 6 * settings.horizontal_line_offset,
    [3] = 6 * settings.icon_height + 32 * param.line_height + settings.bar_height + 6 * param.graph_offset + 7 * settings.horizontal_line_offset,
    [4] = 7 * settings.icon_height + 37 * param.line_height + settings.bar_height + 7 * param.graph_offset + 8 * settings.horizontal_line_offset,
}
param.battery_icon_y = 4 * settings.icon_height + 22 * param.line_height + settings.bar_height + 4 * param.graph_offset + 5 * settings.horizontal_line_offset + settings.number_of_drives * (5 * param.line_height + settings.icon_height + param.graph_offset + settings.horizontal_line_offset)

return param
