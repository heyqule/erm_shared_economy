---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 3/25/2025 2:31 PM
---

local resource_autoplace = require("resource-autoplace")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local base_tile_sounds = require("__base__/prototypes/tile/tile-sounds")
local simulations = require("__space-age__.prototypes.factoriopedia-simulations")
local hit_effects = require ("__base__.prototypes.entity.hit-effects")


local function add_miner(options)
    data.extend({
        {
            type = "mining-drill",
            name = options.name,
            icon = options.icon,
            flags = {"placeable-neutral", "player-creation", "not-rotatable"},
            minable = {mining_time = 0.5, result = options.name},
            resource_categories = options.resource_categories,
            max_health = options.max_health,
            dying_explosion = options.dying_explosion,
            collision_box = {{-3, -2}, {3, 3}},
            selection_box = {{-3, -3}, {3, 3}},
            damaged_trigger_effect = hit_effects.entity(),
            drawing_box_vertical_extension = 1,
            energy_source = options.energy_source,
            energy_usage = options.energy_usage,
            mining_speed = options.mining_speed,
            resource_searching_radius = 0.45,
            vector_to_place_result = options.vector_to_place_result,
            module_slots = 2,
            radius_visualisation_picture =
            {
                filename = "__base__/graphics/entity/pumpjack/pumpjack-radius-visualization.png",
                width = 12,
                height = 12
            },
            monitor_visualization_tint = {78, 173, 255},
            base_render_layer = "lower-object-above-shadow",
            base_picture =
            {
                layers = options.base_picture
            },
            graphics_set =
            {
                animation =
                {
                    north = options.animations
                }
            },
            open_sound = {filename = "__base__/sound/open-close/pumpjack-open.ogg", volume = 0.5},
            close_sound = {filename = "__base__/sound/open-close/pumpjack-close.ogg", volume = 0.5},
            working_sound =
            {
                sound = {filename = "__base__/sound/pumpjack.ogg", volume = 0.7, audible_distance_modifier = 0.6},
                max_sounds_per_prototype = 3,
                fade_in_ticks = 4,
                fade_out_ticks = 10
            },

            circuit_connector = circuit_connector_definitions["pumpjack"],
            circuit_wire_max_distance = default_circuit_wire_max_distance
        },
        {
            type = "item",
            name = options.name,
            icon = options.icon,
            subgroup = "extraction-machine",
            order = "b[erm-geyser]-b["..options.name.."]",
            inventory_move_sound = item_sounds.pumpjack_inventory_move,
            pick_sound = item_sounds.pumpjack_inventory_pickup,
            drop_sound = item_sounds.pumpjack_inventory_move,
            place_result = options.name,
            stack_size = 20
        },
        {
            type = 'recipe',
            name = options.name,
            energy_required = 5,
            ingredients = options.ingredients,
            results = {{type="item", name=options.name, amount=1}},
            enabled = false
        },
    })
    --- Tech appends to planet discovery.
end


local Refinery = {}

function Refinery.add_terran_machine()
    if not mods['erm_terran_hd_assets'] then
        error('Terran asset mod (erm_terran_hd_assets) must be enabled to add terran refinery.')
    end
    local TerranAnimationDB = require("__erm_terran_hd_assets__/animation_db")
    
    if not data.raw['explosion']['terran--building-explosion'] then
        data.extend({{
                         type = "explosion",
                         name = "terran--building-explosion",
                         icon = "__erm_terran_hd_assets__/graphics/entity/icons/buildings/advisor.png",
                         icon_size = 64,
                         subgroup = "explosions",
                         flags = { "not-on-map" },
                         hidden = true,
                         order = "terran-explosions",
                         render_layer = "explosion",
                         animations = TerranAnimationDB.get_layered_animations("death","small_building_death","explosion")
                     }})
    end
    
    local options = {
        name = 'terran_refinery',
        icon = "__erm_terran_hd_assets__/graphics/entity/buildings/refinery/terran-icon.png",
        max_health = 1200,
        dying_explosion = "terran--building-explosion",
        vector_to_place_result = {0.5, 3.5},
        energy_source =   {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = { pollution = 12 },
        },
        energy_usage = "90kW",
        resource_categories = {"erm-geyser-terran"},
        mining_speed = 1,
        base_picture = {
            {
                filename = "__erm_terran_hd_assets__/graphics/entity/buildings/refinery/terran.png",
                priority = "extra-high",
                width = 501,
                height = 372,
                scale = 0.55,
                frame_count = 1
            },
            {
                filename = "__erm_terran_hd_assets__/graphics/entity/buildings/refinery/terran.png",
                priority = "extra-high",
                width = 501,
                height = 372,
                scale = 0.55,
                shift = util.by_pixel(12, 2),
                frame_count = 1,
                draw_as_shadow = true
            },
        },
        animations = {
            layers =
            {
                {
                    filename = "__base__/graphics/entity/crude-oil/oil-smoke-inner.png",
                    frame_count = 47,
                    line_length = 16,
                    width = 40,
                    height = 84,
                    animation_speed = 0.3,
                    shift = util.by_pixel(13, -140),
                    scale = 1.5,
                    tint = util.multiply_color({r=0.353, g=1, b=0}, 0.7)
                },
                {
                    filename = "__base__/graphics/entity/crude-oil/oil-smoke-outer.png",
                    frame_count = 47,
                    line_length = 16,
                    width = 90,
                    height = 188,
                    animation_speed = 0.5,
                    shift = util.by_pixel(13, -203),
                    scale = 1.5,
                    tint = util.multiply_color({r=0.353, g=1, b=0}, 0.3)
                }
            }
        },
        ingredients = {
            {type = "item", name = "steel-plate", amount = 5},
            {type = "item", name = "iron-gear-wheel", amount = 10},
            {type = "item", name = "electronic-circuit", amount = 5},
            {type = "item", name = "pipe", amount = 10}
        }
    }
    add_miner(options)
end

function Refinery.add_zerg_machine()
    if not mods['erm_zerg_hd_assets'] then
        error('Zerg asset mod  (erm_zerg_hd_assets) must be enabled to add zerg refinery.')
    end
    local ZergAnimationDB = require("__erm_zerg_hd_assets__/animation_db")
    
    if not data.raw['explosion']['zerg--building-explosion'] then
        data.extend({{
             type = "explosion",
             name = "zerg--building-explosion",
             icon = "__erm_zerg_hd_assets__/graphics/entity/icons/buildings/advisor.png",
             icon_size = 64,
             subgroup = "explosions",
             flags = { "not-on-map" },
             hidden = true,
             order = "zerg-explosions",
             render_layer = "explosion",
             animations = ZergAnimationDB.get_layered_animations("death", "large_building", "explosion")
        }})
    end
    
    local options = {
        name = 'zerg_refinery',
        icon = "__erm_zerg_hd_assets__/graphics/entity/buildings/extractor/zerg-icon.png",
        max_health = 1200,
        dying_explosion = "zerg--building-explosion",
        vector_to_place_result = {0.5, 3.5},
        energy_source =   {
            type = "electric",
            usage_priority = "secondary-input",
        },
        energy_usage = "90kW",
        resource_categories = {"erm-geyser-zerg"},
        mining_speed = 1,
        base_picture = {
            util.empty_sprite()
        },
        animations = {
            layers =
            {
                {
                    filename = "__erm_zerg_hd_assets__/graphics/entity/buildings/extractor/zerg-animation.png",
                    priority = "extra-high",
                    width = 512,
                    height = 468,
                    scale = 0.5,
                    frame_count = 4,
                    animation_speed = 0.1,
                    shift = util.by_pixel(0, -32),
                },
            }
        },
        ingredients = {
            {type = "item", name = "steel-plate", amount = 5},
            {type = "item", name = "iron-gear-wheel", amount = 10},
            {type = "item", name = "electronic-circuit", amount = 5},
            {type = "item", name = "pipe", amount = 10}
        }
    }
    add_miner(options)
end

function Refinery.add_protoss_machine()
    if not mods['erm_toss_hd_assets'] then
        error('Protoss asset mod (erm_toss_hd_assets) must be enabled to add protoss refinery.')
    end
    local ProtossAnimationDB = require("__erm_toss_hd_assets__/animation_db")
    if not data.raw["explosion"]["protoss--large-building-explosion"] then
        data.extend({
            {
                type = "explosion",
                name = "protoss--large-building-explosion",
                icon = "__erm_toss_hd_assets__/graphics/entity/icons/buildings/advisor.png",
                icon_size = 64,
                subgroup = "explosions",
                flags = { "not-on-map" },
                hidden = true,
                order = "toss-explosions",
                render_layer = "explosion",
                animations = ProtossAnimationDB.get_layered_animations("death","large_building","explosion")
            },
        })
    end
    
    local options = {
        name = 'protoss_refinery',
        icon = "__erm_toss_hd_assets__/graphics/entity/buildings/assimilator/protoss-icon.png",
        max_health = 1200,
        dying_explosion = "protoss--large-building-explosion",
        vector_to_place_result = {0.5, 3.5},
        energy_source =   {
            type = "electric",
            usage_priority = "secondary-input",
            emissions_per_minute = { pollution = 8 },
        },
        energy_usage = "90kW",
        resource_categories = {"erm-geyser-protoss"},
        mining_speed = 1,
        base_picture = {
            {
                filename = "__erm_toss_hd_assets__/graphics/entity/buildings/assimilator/protoss.png",
                priority = "extra-high",
                width = 485,
                height = 377,
                scale = 0.55,
                frame_count = 1
            },
            {
                filename = "__erm_toss_hd_assets__/graphics/entity/buildings/assimilator/protoss.png",
                priority = "extra-high",
                width = 485,
                height = 377,
                scale = 0.55,
                shift = util.by_pixel(12, 2),
                frame_count = 1,
                draw_as_shadow = true
            },
        },
        animations = {
            layers =
            {
                {
                    filename = "__base__/graphics/entity/crude-oil/oil-smoke-inner.png",
                    frame_count = 47,
                    line_length = 16,
                    width = 40,
                    height = 84,
                    animation_speed = 0.3,
                    shift = util.by_pixel(-92, -110),
                    scale = 1.0,
                    tint = util.multiply_color({r=0.353, g=1, b=0}, 0.5)
                },
                {
                    filename = "__base__/graphics/entity/crude-oil/oil-smoke-inner.png",
                    frame_count = 47,
                    line_length = 16,
                    width = 40,
                    height = 84,
                    animation_speed = 0.3,
                    shift = util.by_pixel(60, -130),
                    scale = 1.0,
                    tint = util.multiply_color({r=0.353, g=1, b=0}, 0.5)
                },
                {
                    filename = "__base__/graphics/entity/crude-oil/oil-smoke-inner.png",
                    frame_count = 47,
                    line_length = 16,
                    width = 40,
                    height = 84,
                    animation_speed = 0.15,
                    shift = util.by_pixel(85, -40),
                    scale = 1.0,
                    tint = util.multiply_color({r=0.353, g=1, b=0}, 0.5)
                },
            }
        },
        ingredients = {
            {type = "item", name = "steel-plate", amount = 5},
            {type = "item", name = "iron-gear-wheel", amount = 10},
            {type = "item", name = "electronic-circuit", amount = 5},
            {type = "item", name = "pipe", amount = 10}
        }
    }
    add_miner(options)
end


return Refinery