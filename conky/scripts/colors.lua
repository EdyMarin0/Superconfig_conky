local function hex_to_rgb(hex, alpha)
hex = hex:gsub('#', '')
return {
    r = tonumber(hex:sub(1, 2), 16) / 255,
    g = tonumber(hex:sub(3, 4), 16) / 255,
    b = tonumber(hex:sub(5, 6), 16) / 255,
    a = alpha or 1,
}
end

return { hex_to_rgb = hex_to_rgb }
