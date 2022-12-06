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
      %x(rails dev:add_questions_and_answers)
      %x(rails dev:reset_questions_counter_by_subject)
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

  desc "Loads questions with answers into the database"
  task add_questions_and_answers: :environment do
    show_spinner("Carregando questoes e respostas ...") do
      # Passa por cada assunto
      Subject.all.each do |subject|
        rand(3..10).times do |i|
          # Cadastra de 3 a 10 perguntas por assunto
          Question.create!(question_params(subject))
        end
      end
    end
  end

  desc "Reset questions_count of subject into the database"
  task reset_questions_counter_by_subject: :environment do
    show_spinner("Resetando contador de perguntas por assunto...") do
      Subject.all.each do |subject|
        Subject.reset_counters(subject.id, :questions)
      end
    end
  end

  desc "Loads all the answers into Redis"
  task set_all_answers_into_redis: :environment do
    show_spinner("Carregando todas as respostas no Redis...") do
      Answer.find_each do |answer|
        Rails.cache.write(answer.id, "#{answer.question_id}@@#{answer.correct}")
      end
    end
  end

  private
    def question_params(subject)
      # Gerando a pergunta com as respostas
      question_sentence = Faker::Lorem.paragraph + Faker::Lorem.question

      params = {
        description: question_sentence,
        subject: subject,
        # Chave para os atributos de respostas
        answers_attributes: generate_answers
      }
    end

    def generate_answers(answers = [])
      # Gerando de 2 a 5 alternativas
      rand(2..5).times do |i|
        answers.push(answer_params)
      end

      set_correct_answer(answers)

      answers
    end

    def answer_params(sentence = Faker::Lorem.sentence, correct = false)
      {
        description: sentence,
        correct: correct,
      }
    end

    def set_correct_answer(answers)
      # Sorteia uma alternativa e define como verdadeira
      index = rand(answers.size)
      answers[index][:correct] = true
    end
    
    def show_spinner(start_message_log, end_message_log = "Concluído com sucesso!")
      pastel = Pastel.new

      spinner = TTY::Spinner.new("[:spinner] #{pastel.bright_yellow(start_message_log)}", format: :dots_2, success_mark: pastel.bright_green("+"))
      spinner.auto_spin
      yield
      spinner.success(pastel.bright_green("(#{end_message_log})"))
    end
end
