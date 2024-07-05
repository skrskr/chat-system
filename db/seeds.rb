include Utils


20.times do |i|
    Application.create!(
      name: "Application #{i + 1}",
      token: generate_random_token(8)
    )
end