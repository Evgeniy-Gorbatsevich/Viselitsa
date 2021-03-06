# Класс ResultPrinter занимается выводом на экран состояния и результата игры.
class ResultPrinter
  def initialize
    # Создадим переменную экземпляра @status_image — массив, хранящий
    # изображения виселиц.

    @status_image = []

    # Сохраним текущее положение файла программы, чтобы с его помощью позже
    # собрать путь к каждой картинке.
    current_path = File.dirname(__FILE__)
     # Создадим переменную для счетчика шагов в цикле

     counter = 0
      # В цикле прочитаем 7 файлов из папки image и запишем из содержимое в массив
      while counter < 8
        # Соберем путь к файлу с изображением виселицы.
        file_name = current_path + "/image/#{counter}.txt"

        #Проверяем файл на наличие
        if File.exist?(file_name)
          # Ести такой файл существует, считываем его содержимое целиком и кладем
        # в массив одной большой строкой. Обратите внимание, что вторым
        # параметром при чтении мы явно указываем кодировку файла.
        file = File.new(file_name,'r:UTF-8')
        @status_image << file.read
        file.close
        else
           # Если файла нет, вместо соответствующей картинки будет «заглушка»
           @status_image << "\n [ изображение не найдено ] \n" 
      end

      counter += 1
    end
  end
	# Обратите внимание, что конструктора у класса ResultPrinter нет, т.к. он
  # не хранит внутри себя никакого состояния. Все необходимые данные этому
  # методу будут переданы в качестве параметров.
  #
  # Основной метод, печатающий состояния объекта класса Game, который нужно
  # передать ему в качестве параметра.
  def print_status(game)
  	cls
  	 # Выводим на экран слово с подчеркиваниями методом get_work_for_print
    puts "\nСлово: #{get_word_for_print(game.letters, game.good_letters)}"

    # Выводим текущее количество ошибок и все «промахи»
    puts "Ошибки: #{game.bad_letters.join(', ')}"

    # Выводим саму виселицу, состояние которой определяется количеством ошибок
    print_viselitsa(game.errors)

    if game.status == -1 
    	# Если статус игры -1 (проигрыш) — выводим загаданное слово и говорим, что
      # пользователь проиграл.
       puts "\nВы проиграли :(\n"
      puts 'Загаданное слово было: ' + game.letters.join('')
      puts
       elsif game.status == 1
      # Если статус игры 1 (выигрыш) — поздравляем пользователя с победой.
      puts "Поздравляем, вы выиграли!\n\n"
    else
      # Если ни то ни другое (статус 0 — игра продолжается), просто выводим
      # текущее количество оставшихся попыток.
      puts 'У вас осталось ошибок: ' + (7 - game.errors).to_s
    end
end
# Служебный метод класса, возвращающий строку, изображающую загаданное слово
  # с открытыми угаданными буквами
   def get_word_for_print(letters, good_letters)
    result = ''

    for item in letters do
      if good_letters.include?(item)
        result += item + ' '
      else
        result += '__ '
      end
    end

    return result
  end

    def print_viselitsa(errors)
       # Так как ранее (в конструкторе) мы все картинки загрузили в массив
    # @status_image, сейчас чтобы вывести на экран нужную виселицу, достаточно
    # в качестве параметра puts указать нужный элемент этого массива.
      puts @status_image[errors]
    end

  def cls
    system('clear') || system('cls')
  end
end