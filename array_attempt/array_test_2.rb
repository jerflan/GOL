world = []

10.times do
  world.push(rand(0..1))
end

world.each_with_index do |value, index|
  if index == 0
    world[index] + world[index + 1]
  elsif index == -1
    world[-1] + world[-2]
  else
   world[index] + world[index - 1] + world[index + 1]
  end
end
