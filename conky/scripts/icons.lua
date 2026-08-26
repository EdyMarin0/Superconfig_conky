local settings = require 'settings'
local icons_path = os.getenv('HOME') .. '/.config/conky/icons/'

local function draw_icon(cr, path, x, y, width, height)
local img = cairo_image_surface_create_from_png(path)
if cairo_surface_status(img) ~= CAIRO_STATUS_SUCCESS then
    cairo_surface_destroy(img)
    return -- missing/bad file — skip rather than crash
    end
    cairo_save(cr)
    cairo_translate(cr, x, y)
    local img_w = cairo_image_surface_get_width(img)
    local img_h = cairo_image_surface_get_height(img)
    if img_w > 0 and img_h > 0 then
        cairo_scale(cr, width / img_w, height / img_h)
        end
        cairo_set_source_surface(cr, img, 0, 0)
        cairo_paint(cr)
        cairo_restore(cr)
        cairo_surface_destroy(img)
        end

        local function icon_path(base_name, is_high)
        local state = is_high and 'high' or 'low'
        return icons_path .. base_name .. '_' .. state .. '_' .. settings.icon_var .. '.png'
        end

        local M = {}

        function M.draw_all(cr)
        local border = settings.window_border_distance
        -- CPU
        local cpu_usage = tonumber(conky_parse('${cpu cpu0}')) or 0
        draw_icon(cr, icon_path('cpu', cpu_usage >= settings.cpu_threshold),
                  border, border, settings.icon_width, settings.icon_height)

        -- RAM
        local mem_perc = tonumber(conky_parse('${memperc}')) or 0
        draw_icon(cr, icon_path('ram', mem_perc >= settings.ram_threshold),
                  border, border + settings.ram_icon_y, settings.icon_width, settings.icon_height)

        -- GPU
        local gpu_raw = conky_parse('${execi 1 nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits}')
        local gpu_util = tonumber(gpu_raw) or 0
        draw_icon(cr, icon_path('gpu', gpu_util >= settings.gpu_threshold),
                  border, border + settings.gpu_icon_y, settings.icon_width, settings.icon_height)

        -- Temp (CPU OR GPU over threshold)
        local cpu_temp = tonumber(conky_parse('${hwmon ' .. settings.cpu_temp_sensor .. ' temp ' .. settings.cpu_temp_index .. '}')) or 0
        local gpu_temp_raw = conky_parse('${execi 1 nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits}')
        local gpu_temp = tonumber(gpu_temp_raw) or 0
        local temp_high = (cpu_temp > settings.cpu_temperature_threshold) or (gpu_temp > settings.gpu_temperature_threshold)
        draw_icon(cr, icon_path('temp', temp_high),
                  border, border + settings.temp_icon_y, settings.icon_width, settings.icon_height)

        -- Drives (One icon for each drive displayed)
        for i = 1, settings.number_of_drives do
            draw_icon(cr,
                      icons_path .. 'drive_' .. settings.icon_var .. '.png',
                      border, border + settings.drive_icon_y[i],
                      settings.icon_width, settings.icon_height)
            end
        end

        return M
