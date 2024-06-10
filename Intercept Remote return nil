local function intercept(remote)
    return function()
        local mt = getrawmetatable(remote)
        local oldNC = mt.__namecall
        setreadonly(mt, false)

        mt.__namecall = newcclosure(function(...)
            return nil
        end)

        setreadonly(mt, true)
    end
end

return intercept
