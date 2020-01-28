require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player' #rappel les fichiers game et player dans lib/

player1 = Player.new("Xena") #creation d'une nouvelle instance dans la classe Joueurs
puts "#{player1.name} entre dans l'arène"
player2 = Player.new("Rocky") #idem
puts "#{player2.name} se joint au combat !\n\n"
puts "===================\n\n"
while player1.life_points>0 && player2.life_points>0
  puts "Voici l'état de chaque joueur :" #présentation de l'état de chaque joueur suivant la méthode dédiée.
  puts player1.show_state
  puts player2.show_state
  puts "===================\n"
  puts "Passons à la phase d'attaque :\n\n"
  puts "==================="
  puts "|  F  I  G  H  T  |" #début du cycle d'attaque
  puts "===================\n\n"
  puts "#{player1.name} attaque #{player2.name}"
  player1.attacks(player2)
  if player2.life_points<=0 #précision que si l'un des joueurs est mort, le combat doit s'arrêter
    break
    puts "#{player2.name} est mort !"
  else
    puts "#{player2.name} attaque #{player1.name}"
    player2.attacks(player1)
  end
end

if player2.life_points<=0
  puts "#{player2.name} a été tué !" #message indiquant la mort du perso
else
  puts "#{player1.name} a été tué !"
end


#binding.pry -> permet de faire des tests avec pry