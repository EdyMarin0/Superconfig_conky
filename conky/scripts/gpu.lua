-- GPU parameter bypass (TEMPORARY UNTIL NEW VERSION)
local function get_gpu_stats()
local raw = conky_parse('${execi 1 nvidia-smi --query-gpu=utilization.gpu,temperature.gpu,memory.used,memory.total --format=csv,noheader,nounits}')
local util, temp, mem_used, mem_total = raw:match('(%d+),%s*(%d+),%s*(%d+),%s*(%d+)')
return tonumber(util), tonumber(temp), tonumber(mem_used), tonumber(mem_total)
end

function conky_gpu_util()
local util = get_gpu_stats()
return tostring(util or 0)
end

function conky_gpu_temp()
local _, temp = get_gpu_stats()
return tostring(temp or 0)
end

function conky_gpu_mem_used()
local _, _, mem_used = get_gpu_stats()
if not mem_used then return '0' end
return string.format('%.2f',mem_used/1024)
end

function conky_gpu_mem_total()
local _, _, _, mem_total = get_gpu_stats()
if not mem_total then return '0' end
    return string.format('%.1f',mem_total/1024)
end

function conky_gpu_mem_perc()
local _, _, mem_used, mem_total = get_gpu_stats()
if not mem_used or not mem_total or mem_total == 0 then return '0' end
    return tostring(math.floor((mem_used / mem_total) * 100))
    end
