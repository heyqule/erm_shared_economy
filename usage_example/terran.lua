---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 3/29/2025 12:34 AM
---
local Minerals = require('__erm_shared_economy__/prototypes/mineral')
local Geyser = require('__erm_shared_economy__/prototypes/geyser')
local Refinery = require('__erm_shared_economy__/prototypes/refinery')

local mineral_name = 'terran-mineral'
Minerals.add_resource({
    name = mineral_name,
    order = 'b', -- same order as iron
    mining_time = 2,
    import_location = 'earth',
    ---autoplace
    has_starting_area_placement = true,
    base_density = 6,
    base_spots_per_km2 = 4,
    regular_rq_factor_multiplier = 1.2,
    starting_rq_factor_multiplier = 1.5,
    candidate_spot_count = 44,
})
Minerals.add_recycle_recipe({
    name = mineral_name,
    enabled = false,
    energy_required = 0.2,
    ingredients = {
        {type = "item", name = mineral_name, amount = 1}
    },
    results = {
        {type = "item", name = "iron-ore",  amount = 1, probability = 0.66, show_details_in_recipe_tooltip = false},
        {type = "item", name = "copper-ore", amount = 1, probability = 0.5, show_details_in_recipe_tooltip = false},
        {type = "item", name = "holmium-ore", amount = 1, probability = 0.03, show_details_in_recipe_tooltip = false},
        {type = "item", name = "uranium-ore",  amount = 1, probability = 0.01, show_details_in_recipe_tooltip = false},
    }
})

local geyser_name = 'terran-geyser'
Geyser.add_resource({
    name = geyser_name,
    type = 'terran',
    order = 'c', -- same order as iron
    mining_time = 2,
    import_location = 'earth',
    ---autoplace
    has_starting_area_placement = false,
    base_density = 4,
    regular_rq_factor_multiplier = 1.2,
    starting_rq_factor_multiplier = 1.5,
    random_probability = 1/48,
    random_spot_size_minimum = 1,
    random_spot_size_maximum = 1,

    smoke_color_1_outer = {r=0.353, g=1, b=0},
    smoke_color_1_outer_strength = 0.2,
    smoke_color_1_inner = {r=0.353, g=1, b=0},
    smoke_color_1_inner_strength = 0.5,
    smoke_color_2_outer = {r=0.353, g=1, b=0},
    smoke_color_2_outer_strength = 0.3,
    smoke_color_2_inner = {r=0.353, g=1, b=0},
    smoke_color_2_inner_strength = 0.7,

    map_color = {r=0.353, g=1, b=0},
})
Geyser.add_refinery_recipe({
    name = geyser_name,
    type = 'terran',
    enabled = false,
    energy_required = 2,
    ingredients = {
        {type = "item", name = geyser_name, amount = 1}
    },
    results = {
        {type = "fluid", name = "steam", amount = 50, temperature = 500},
        {type = "fluid", name = "water", amount = 10},
        {type = "fluid", name = "crude-oil", amount = 3},
    }
})

--- This is global.  
Refinery.add_terran_machine()

--- Add these to technology that unlocks them, usually from planet discovery research
{
    --- Unlock protoss refinery, it's global
    {
        type = "unlock-recipe",
        recipe = "terran_refinery"
    },
    --- Unlock planet specific refinery and recipes
    {
        type = "unlock-recipe",
        recipe = geyser_name.."-refinery"
    },
    {
        type = "unlock-recipe",
        recipe = mineral_name.."-recycling"
    }
} 