#json.cache! @police_actions do |json|
  json.array! @police_actions do |json, police_action|
    @police_action = police_action
#    json.cache! @police_action do |json|
      json.partial! @police_action
#    end
  end
#end
