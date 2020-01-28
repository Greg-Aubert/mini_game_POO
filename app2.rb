require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def perform #va lancer le jeu
  puts "--------------------------------------------------"
  puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !       |"
  puts "|Le but du jeu est d'être le dernier survivant ! |"
  puts "--------------------------------------------------\n\n"

  puts "Quel est ton nom, combattant ?"
  print ">" #le joueur entre son nom qui le suivra jusqu'à la fin du combat
  human_player_name = gets.chomp
  humanplayer1 = HumanPlayer.new(human_player_name) #l'instance du nouveau joueur est rajoutée à la class des joueurs
  puts "Bienvenue dans l'arène, #{humanplayer1.name}\n"
  puts "====================================="
  puts "Tes ennemis s'avancent..."
  bot_players = [] #création de l'array contenant les combattants ennemis
  player1 = Player.new("Xena")
  bot_players << player1 #ajout du premier ennemi dans l'array des ennemis
  puts "#{player1.name} entre dans l'arène"
  player2 = Player.new("Rocky")
  bot_players << player2 #ajout du premier ennemi dans l'array des ennemis
  puts "#{player2.name} se joint au combat !\n\n"
  puts "====================================="

  while humanplayer1.life_points >0 && (player1.life_points > 0 || player2.life_points >0) #tant que ni le joueur humain ni les 2 adversaires ne sont morts, le jeu continue
    puts "Voici l'état de chaque joueur :"
    puts humanplayer1.show_state
    if player1.life_points > 0 #permet d'arrêter l'attaque d'un ennemi mort
      puts player1.show_state
    else 
      puts "#{player1.name} est morte"
    end
    if player2.life_points > 0 #permet d'arrêter l'attaque d'un ennemi mort
      puts player2.show_state
    else 
      puts "#{player2.name} est mort"
    end
    puts "===================\n" #menu du joueur pour sélectionner son action lors de ce tour
    puts "Quelle action veux-tu effectuer ?\n"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner\n"
    puts "attaquer un joueur en vue :"
    if player1.life_points > 0 #permet de ne plus proposer l'action contre un adversaire déjà mort
      print "0 - "
      puts player1.show_state
    else 
      puts "#{player1.name} est mort"
    end
    if player2.life_points > 0
      print "1 - "
      puts player2.show_state
    else 
      puts "#{player2.name} est mort"
    end
    player_choice = gets.chomp #selection des réactions du programme au regard du choix du joueur
    if player_choice == "a"
      humanplayer1.search_weapon #chercher une meilleure arme
      puts "==================="
    elsif player_choice == "s"
      humanplayer1.search_health_pack #se soigner
      puts humanplayer1.show_state
      puts "==================="
    elsif player_choice == "0"
      puts "Passons à l'attaque :\n\n"
      puts "==================="
      puts "|  F  I  G  H  T  |"
      puts "===================\n\n"
      humanplayer1.attacks(player1) #attaque l'adversaire 1
      puts "==================="
    elsif player_choice == "1"
      puts "Passons à l'attaque :\n\n"
      puts "==================="
      puts "|  F  I  G  H  T  |"
      puts "===================\n\n"
      humanplayer1.attacks(player2) #attaque l'adversaire 2
      puts "==================="
    end

    bot_players.each do |player| #permet de laiser les adversaires attaquer l'un après l'autre le joueur
      if player.life_points >= 0
        puts "l'ennemi se défend"
        puts "#{player.name} attaque #{humanplayer1.name}"
        player.attacks(humanplayer1)
        puts "==================="
        if humanplayer1.life_points <= 0
          break
          puts "#{player.name} a tué #{humanplayer1.name}"
        end
      end
    end
  end

  if humanplayer1.life_points<=0 #message de fin indiquant la victoire ou la défaite
    puts "========================"
    puts "|                      |"
    puts "|Vous êtes une quiche !|"
    puts "|                      |"
    puts "========================"
  else
    puts "========================"
    puts "|  C'est la victoire ! |"
    puts "|    Beau gosse va !   |"
    puts "|                      |"
    puts "========================"
  end
end

perform

