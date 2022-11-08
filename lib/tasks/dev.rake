namespace :dev do
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Rebuilds the database"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD ...") { %x(rails db:drop) }
      show_spinner("Criando BD ...") { %x(rails db:create) }
      show_spinner("Migrando BD ...") { %x(rails db:migrate) }
      %x(rails dev:add_default_user)
      %x(rails dev:add_default_admin)
      %x(rails dev:add_extra_admins)
      %x(rails dev:add_subjects)
      %x(rails dev:add_questions)
    else
      "This task run just in development environment."
    end
  end

  desc "Loads a default user into the database"
  task add_default_user: :environment do
    show_spinner("Carregando usuário padrão ...") do
      User.create!(
        email: 'user@user.com',
        password: 'qwe#@!',
        password_confirmation: 'qwe#@!'
      )
    end
  end

  desc "Loads a default admin into the database"
  task add_default_admin: :environment do
    show_spinner("Carregando admin padrão ...") do
      Admin.create!(
        email: 'admin@admin.com',
        password: 'qwe#@!',
        password_confirmation: 'qwe#@!'
      )
    end
  end

  desc "Loads extra admins into the database"
  task add_extra_admins: :environment do
    show_spinner("Carregando administradores extras ...") do
      10.times do |i|
        Admin.create!(
          email: Faker::Internet.email,
          password: 'qwe#@!',
          password_confirmation: 'qwe#@!'
        )
      end
    end
  end

  desc "Loads a subjects list into the database"
  task add_subjects: :environment do
    show_spinner("Carregando assuntos ...") do
      file_name = 'subjects.txt'
      file_path = File.join(DEFAULT_FILES_PATH, file_name)
      
      File.open(file_path, 'r').each do |line|
        Subject.create!(description: line.strip)
      end
    end
  end

  desc "Loads questions into the database"
  task add_questions: :environment do
    show_spinner("Carregando questoes ...") do
      Subject.all.each do |subject|
        rand(3..10).times do |i|
          Question.create!(
            description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
            subject: subject
          )
        end
      end
    end
  end

  private
    def show_spinner(start_message_log, end_message_log = "Concluído com sucesso!")
      pastel = Pastel.new

      spinner = TTY::Spinner.new("[:spinner] #{pastel.bright_yellow(start_message_log)}", format: :dots_2, success_mark: pastel.bright_green("+"))
      spinner.auto_spin
      yield
      spinner.success(pastel.bright_green("(#{end_message_log})"))
    end
end
