json.array! @police_actions do |json, police_action|
  @police_action = police_action
  json.partial! @police_action
end
