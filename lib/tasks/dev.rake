require 'pastel'

namespace :dev do
  desc "Rebuilds the database"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD ...") { %x(rails db:drop) }

      show_spinner("Criando BD ...") { %x(rails db:create) }
      
      show_spinner("Migrando BD ...") { %x(rails db:migrate) }

      %x(rails dev:add_default_user)
      
      %x(rails dev:add_default_admin)
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

  private
    def show_spinner(start_message_log, end_message_log = "Concluído com sucesso!")
      pastel = Pastel.new

      spinner = TTY::Spinner.new("[:spinner] #{pastel.bright_yellow(start_message_log)}", format: :dots_2, success_mark: pastel.bright_green("+"))
      spinner.auto_spin
      yield
      spinner.success(pastel.bright_green("(#{end_message_log})"))
    end
end
