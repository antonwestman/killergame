namespace :data do
  def create_stuff
    User.find_or_create_by(username: 'AceWeston', first_name: 'Anton', last_name: 'Westman', email: 'anton@mail.se')
    User.find_or_create_by(username: 'The dawg', first_name: 'Dexter', last_name: 'Westman', email: 'dexter@mail.se')
    User.find_or_create_by(username: 'SoafTheMeatLoaf', first_name: 'Sofia', last_name: 'Rytterlund', email: 'sofia@mail.se')
    CreateGameRound.call(users: User.all)
  end

  desc 'Seed test data'
  task seed: :environment do
    puts
    puts
    puts 'This will seed test data in your current environment'
    puts 'Are you sure? (y/n)'
    abort 'Aborted.' unless $stdin.gets.strip.casecmp('y').zero?

    create_stuff
  end
end
