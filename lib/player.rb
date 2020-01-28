class Player #génère une classe qui permettra la création de joueurs respectant les paramètres ci dessous
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name #nom du personnage
    @life_points = 10 #nb de pdv du personnage
  end

  def show_state #permet d'afficher les points de vie du personnage en question ("self")
    puts "#{self.name} a #{self.life_points} points de vie"
  end

  def gets_damage(damage) #permet de réduire le capital de point de vie du perso
    self.life_points = life_points - damage
      if self.life_points <= 0 #si il a 0 pdv alors il meurt
        return "le joueur #{self.name} a été tué"
      end
  end

  def attacks(player) #permet à un perso d'attaquer un autre
    puts "le joueur #{self.name} attaque le joueur #{player.name}"
    attack_damage = compute_damage #compute fait appel à la def suivant compute_damage
    player.gets_damage( attack_damage) #gets_damage fait appel à la def précédente qui réduit le capital pdv
    puts "il lui inflige #{attack_damage} points de dommages"
  end

  def compute_damage
    return rand(1..6) #génère un chiffre aléatoire entre 1 et 6
  end

end

class HumanPlayer < Player #génère une sous-classe respectant les mêmes éléments que Player avec des modifs
  attr_accessor :weapon_level

  def initialize(name)
    @life_points = 100 #nouveau capital pdv
    @weapon_level = 1 #nouvelle variable d'instance
    @name = name
  end

  def show_state #idem qu'avant mais phrase différente pour ajouter le weapon_level
    puts "#{self.name} a #{self.life_points} points de vie et une arme de niveau #{self.weapon_level}"
  end

  def compute_damage #idem qu'avant mais avec le multiplicateur weapon_level
    rand(1..6) * @weapon_level
  end

  def search_weapon #permet de changer le weapon_level avec un jet de dés aléatoire
    new_weapon = rand(1..6) #jet de dés aléatoire
    puts "Tu as trouvé une arme de niveau #{new_weapon}"
    if new_weapon > @weapon_level #si le lancer est supérieur au weapon_level existant, il le remplace
      @weapon_level = new_weapon
      puts "Youhou ! Elle est meilleure que ton arme actuelle : tu la prends."
    else #sinon pas de changement
      puts "C'est de la camelotte cette arme !"
    end
  end

  def search_health_pack #permet de récupérer de la vie grace à un lancer de dés aléatoire
    health_pack = rand(1..6) #lancer aléatoire avec conséquences selon résultat
    puts "jet de des #{health_pack}"
    if health_pack == 1
        puts "Pas de chance, tu vas creuver"
    elsif health_pack == (2..5)
      puts "Bravo! 50 points de vie pour continuer la traque" 
      if self.life_points+50 > 100 #si total est supérieur à 100, alors total est bloqué à 100
        self.life_points = 100 
      else #sinon vie restant + 50
        self.life_points+= 50
      end 
    else 
      puts "Jakpot, tu récupères 80 points de vie"
      if self.life_points+80 > 100 #idem
        self.life_points = 100 
      else
        self.life_points+=80 #idem
      end 
    end
  end
end



