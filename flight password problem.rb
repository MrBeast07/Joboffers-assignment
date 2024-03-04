INPUT = File.open(ARGV[0]).read.chomp("\n").split("\n")


class PasswordChecker

  attr_reader :parse_passwords, :check_passwords

  def initialize(passwords)
    @passwords = passwords
    @parsed_passwords = parse_passwords
  end

  def parse_passwords
    parsed = @passwords.map do |item|
      item_split = item.match(/(^\d*)-(\d*) (\w): (\w*)/)
      {
        min: item_split[1].to_i,
        max: item_split[2].to_i,
        letter: item_split[3],
        password: item_split[4]
      }
    end
    parsed
  end

  def validate_password_frequency(log)
    # puts "rules are minimum #{log[:min]} and max #{log[:max]}"
    # puts "there are #{log[:password].count(log[:letter])} letter #{log[:letter]}'s"
    log[:password].count(log[:letter]).to_i.between?(log[:min],log[:max])
  end

  def validate_password_accuracy(log)
    return false unless log[:password].include?(log[:letter])
    return false if log[:password][log[:min] - 1] == log[:letter] && log[:password][log[:max] - 1] == log[:letter]

    # puts "rules are letter #{log[:letter]} must be at position #{log[:min]} and then at position #{log[:max]}"
    # puts "there's a #{log[:password][log[:min] - 1]} at position #{log[:min]} and a #{log[:password][log[:max] - 1]} at position #{log[:max]}"
    log[:password][log[:min] - 1] == log[:letter] || log[:password][log[:max] - 1] == log[:letter]
  end

  def check_passwords(way="frequency")
    @parsed_passwords.map do |log|
        if way == "accuracy"
          validate_password_accuracy(log)
        else
          validate_password_frequency(log)
        end
    end.count(true)
  end

end

check = PasswordChecker.new(INPUT)

# puts check.parse_passwords
# puts "======="
puts "#{check.check_passwords} are valid for part one"
puts "#{check.check_passwords("accuracy")} are valid for part two"
