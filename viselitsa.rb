if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end


require_relative 'game'
require_relative 'result_printer'
require_relative 'word_reader'



# Создаем экземпляр класса ResultPrinter, который мы будет использовать для
# вывода информации на экран.
printer = ResultPrinter.new

puts "Игра виселица. V-3.0"
sleep 1
# Создаем экземпляр класса Word который мы будет использовать для
# вывода информации на экран.
word_reader = WordReader.new

# Соберем путь к файлу со словами из пути к файлу, где лежит программа и
# относительно пути к файлу words.txt.
words_file_name = File.dirname(__FILE__) + '/data/words.txt'

# Создаем объект класса Game, вызывая конструктор и передавая ему слово, которое
# вернет метод read_from_file экземпляра класса WordReader.
game = Game.new(word_reader.read_from_file(words_file_name))
while game.status == 0 do
  # Выводим статус игры с помощью метода print_status класса ResultPrinter,
  # которому на вход надо передать объект класса Game, у которого будет взята
  # вся необходимая информация для вывода состояния на экран.
  printer.print_status(game)

  # Просим угадать следующую букву, вызывая у объекта класса Game метод
  # ask_next_letter.
  game.ask_next_letter
end
# В конце вызываем метод print_status у объекта класса ResultPrinter ещё раз,
# чтобы вывести игроку результаты игры.
printer.print_status(game)


