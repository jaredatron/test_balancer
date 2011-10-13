tests = [318, 23299, 878, 891, 167, 777, 548, 533394, 545, 956, 23213, 891, 156, 591, 583, 302, 647, 977, 533, 646]


def in_groups tests, n
  groups = n.times.map{[]}
  tests.sort!.reverse!
  tests.each{|t| smallest = groups.sort_by{|group| group.inject(0, &:+) }.first << t }
  groups
end

(1..5).map do |i|
  groups = in_groups(tests, i)
  puts ""
  p groups
  p groups.map{|group| group.inject(0, &:+) }
end
