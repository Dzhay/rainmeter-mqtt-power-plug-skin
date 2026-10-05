function Initialize()
end

function Update()
    local json = SKIN:GetMeasure("powerImport"):GetStringValue()
    local power = string.match(json, [["Power"%s*:%s*([%d%.]+)]])
    return power or "--"
end
