# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    Location.create(name: 'Кордон', description: 'Описание')
    Location.create(name: 'Свалка', description: 'Описание')
    Location.create(name: 'Агропром', description: 'Описание')
Factory.create(name: 'Туз', description: 'Скверный и жадный до всего ценного барыга, работающий по приципу -"Как бы больше навару срубить".Но щедро платит за вовремя проделанную работу.',
               budget: 700000, salary: 1800, location_id: 1)
#Factory.create(name: 'Кактус', description: 'Тёртый временем сталкер,который знает толк в людях.Стоит на заставе входа на свалку.У него всегда найдётся задание для настоящего сталкера.',
#                   budget: 50000, salary: 220, location_id: 1)
#Factory.create(name: 'Болт', description: 'Начинал отмычкой у одного из ветеранов Зоны. После неудачного рейда резко поменял взгляды на жизнь и занялся мелкой торговлей артами. Всегда славился своей болтливостью ( от чего и получил прозвище).',
#                   budget: 35000, salary: 140, location_id: 1)