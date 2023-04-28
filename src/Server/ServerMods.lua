local module = {}

module.mods = {}

--[=[
	Registers a single ModuleScript as a mod.
	@param mod ModuleScript -- Individual ModuleScript to be loaded as a mod.
]=]
function module:RegisterMod(context: string, name: string, mod: {[any]: any})
        if module.mods[context] == nil then
        module.mods[context] = {}
    end
    
    if (mod.GetPriority ~= nil) then
        mod.priority = mod:GetPriority()
    else
        mod.priority = 0
    end
    mod.name = name
    
    table.insert(self.mods[context], mod)
    
    table.sort(self.mods[context], function(a,b)
        return a.priority > b.priority
    end)
end

function module:GetMod(context, name)

    local list = self.mods[context]

    for key,contents in list do
        if (contents.name == name) then
            return contents
        end        
    end
    
    return nil
end

function module:GetMods(context)

    if (self.mods[context] == nil) then
        self.mods[context] = {}
    end
    return self.mods[context]
end

return module