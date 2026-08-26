require 'cairo'
require 'cairo_xlib'
local settings = require 'settings'
local icons = require 'scripts.icons'

-- ===== CONFIG =====
local graph_x = settings.window_border_distance
local graph_y = settings.graph_position

function conky_cpu_columns()
if conky_window == nil then return end

    local cs = cairo_xlib_surface_create(conky_window.display,
                                         conky_window.drawable, conky_window.visual,
                                         conky_window.width, conky_window.height)
    local cr = cairo_create(cs)
    local usable_width = conky_window.width - (2 * settings.window_border_distance)
    local bar_width = (usable_width - (settings.bar_gap * (settings.cpu_cores - 1))) / settings.cpu_cores

    for i = 1, settings.cpu_cores do
        local usage = tonumber(conky_parse('${cpu cpu' .. i .. '}')) or 0
        local x = graph_x + (i - 1) * (bar_width + settings.bar_gap)

        cairo_set_source_rgba(cr, settings.graph_background_rgb.r, settings.graph_background_rgb.g, settings.graph_background_rgb.b, settings.graph_background_rgb.a)
        cairo_rectangle(cr, x, graph_y, bar_width, settings.bar_height)
        cairo_fill(cr)

        local fill_h = settings.bar_height * (usage / 100)
        cairo_set_source_rgba(cr, settings.graph_rgb.r, settings.graph_rgb.g, settings.graph_rgb.b, settings.graph_rgb.a)
        cairo_rectangle(cr, x, graph_y + (settings.bar_height - fill_h), bar_width, fill_h)
        cairo_fill(cr)
        end

        icons.draw_all(cr)

        cairo_destroy(cr)
        cairo_surface_destroy(cs)
        end
