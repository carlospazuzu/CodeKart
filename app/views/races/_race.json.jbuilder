json.id race.id
json.tournament_id race.tournament.id
json.place race.place
json.date race.date
json.placements race.placements do |placement|
  json.id placement.id
  json.racer_id placement.racer_id
  json.position placement.position
end