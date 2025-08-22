local DAMAGE_INTERVAL = 300     -- ticks
local DAMAGE_AMOUNT = 10        -- how much damage per cycle
local DAMAGE_TYPE = "acid"      -- damage type to use
local TARGET_SURFACE = "nauvis" -- change to your planet/surface name

-- List of entity types considered "production machines"
local production_types = {
    ["assembling-machine"] = true,
    ["furnace"] = true,
}
-- List of immune entities for galvanized machines or wtv
local immunity = {
    ["galvanized-assembling-machine"] = true,
    ["galvanized-furnace"] = true,
}


script.on_event(defines.events.on_tick, function(event)
    if event.tick % DAMAGE_INTERVAL ~= 0 then return end
    -- Search your selected surface
    local surface = game.surfaces[TARGET_SURFACE]
    if not surface then return end
    -- Search your selected machine types
    for machine_types, _ in pairs(production_types) do
        local entities = surface.find_entities_filtered { type = machine_types, force = "player" }
        for _, entity in pairs(entities) do
            if entity.valid and entity.health and entity.destructible then
                if not immunity[entity.name] then
                    entity.damage(DAMAGE_AMOUNT, "neutral", DAMAGE_TYPE)
                end
            end
        end
    end
end)
