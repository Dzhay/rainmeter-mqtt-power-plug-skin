-- Reloads the skin when Settings.inc is saved, so new broker settings
-- apply without a manual refresh.

local path
local last

local function ReadSettings()
    local file = io.open(path, 'r')
    if not file then return nil end
    local text = file:read('*a')
    file:close()
    return text
end

function Initialize()
    path = SKIN:MakePathAbsolute(SKIN:GetVariable('@') .. 'Settings.inc')
    last = ReadSettings()
end

function Update()
    local text = ReadSettings()
    if text and text ~= last then
        last = text
        SKIN:Bang('!Refresh')
    end
    return 0
end
