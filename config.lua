Config = {}

--- O DECAY SO FUNCIONA COM O PLAYER ONLINE

Config.DecayTime = 216 -- Tempo que demora para decair a qualidade do item -- 864 segundos = 24 horas para estragar -- 432 segundos = 12 horas para estragar
Config.DecayAmount = 1 -- Quanto decai pelo tempo definido em Decay time (apenas numeros inteiros)
Config.DamageHealth = 100 -- Quanto de vida perde ao comer coisa estragada (A VIDA É ATÉ 600)
Config.DamageStress = -20 -- Quanto de estresse recebe por comer coisa estragada (O estresse é até -100)

Config.Consumables = {
    Eat = { -- default food items
        ['bread'] = {
            item = 'bread',
            hunger = 25,
            thirst = 0,
            stress = 5,
            propname = 'p_bread_14_ab_s_a'
        },
    },
    Drink = { -- default drink items
        ['water'] = {
            item = 'water',
            hunger = 0,
            thirst = 25,
            stress = 100,
            propname = 'p_bottlebeer01a'
        },
    },
    Stew = { -- default stew items
        ['stew'] = {
            item = 'stew',
            hunger = 50,
            thirst = 25,
            stress = 20,
            propname = 'p_bowl04x_stew'
       },
    },
}
