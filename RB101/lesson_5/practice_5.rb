munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

combined_male_age = 0

munsters.each do |munster|
  combined_male_age += munster[1]['age'] if munster[1]['gender'] == 'male'
end

p combined_male_age

combined_male_age = 0

munsters.each_value do |munster|
  combined_male_age += munster['age'] if munster['gender'] == 'male'
end

p combined_male_age
