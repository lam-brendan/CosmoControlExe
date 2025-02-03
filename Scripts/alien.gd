extends Alien
	
var alien_name

var alienSprite

var alien_star_sector

var alien_star_sector_symbol

var alien_planet

var idCardExpireDate

var visaExpireDate

var idCardImage

var isLegal

var visaName

var visaBoardingDate

var purposeOfVisit

var documentSequence

var species_name

var species_symbol_path

var pattern_seq_converted

var stamp_symbol_path

var alienHeight

#Below here is code used for the creation of the sequence for aliens.
var shape_dict = {
	1: "Square",
	2: "Circle",
	3: "Triangle",
	4: "Diamond",
	5: "Pentagon",
}

# wrongInfo is the number correlating to which info is going to be incorrect
# 1 - id expire date
# 2 - visa expire date
# 3 - visa name, 
# 4 - boarding date, 
# 5 - symbol squence, 
# 6 - purpose of visit, 
# 7 - illegal alien sprite
# 8 - mismatch alien irl sprite with id card, 
# 9 - illegal star sector/planet combo
# 10 - star sector symbol
# 11 - stamp symbol
# 12 - Mismatch Species Symbol
var wrongInfo = randi_range(1,12)
#var wrongInfo = 10F

var currentDate = [10,7,2024]

const possible_names := [
	"Layvit","On'ngur","Muloncolonic","Hay'hrey","Kei'tyln","Jau'gh","Ahk'mari","Xerxe","Erzyn'kai","Uaut'tin"
	,"Bhen'jaymyn","Kaasahn'duragh","Laiak'tai","Fhul'narh","Jeeyow'sukagyh","Scki'reiyoh","Phful'sehn","Haney'agh","Mhalg'colym","Rahgph'feighyel"
	,"Jhach'quyellyn","Naigh'thyn","Zzak'kahray","Thaykha'ra","Zau'ugkahm","Gzuj'shan","Nyxthu'fahazan","Ayaykq'vzakyn","Fyraan'seen","Kaeyel'ah"
	,"Cgungha'ru","Geah'Bonhg","Poh'bawngyng","Staranhgue'aahrm","Skahai'yelah","Jaahn'ghny","Phreddrick","Blambino","Gauther'z","Xerocero"
	,"Loupmont","Wissbost","IeciDace","Yargioh","Gtreut'nim","Kringlz","Ghloriiz","Trisidziid","Ouranean","Shelelemo"
	,"M𒍏𒍏","𒌒|-|𒌒","𒁉 𒄠","Ilexal","𒈠𒀭𒀀𒆠","𒆠'𒌝'𒈾","Kh𒆪k","𒅎𒄖 Drul","*𒉈*","R𒅁n"
	,"H𒈾m𒀀t𒀀","𒋛u𒋼𒋼𒊑𒈠","Sewz 𒀀𒈾𒀀","V'𒈠𒀭 id","F𒆪𒆪xi𒀭n","𒁲 ukru","𒂖mhoi","Hangurap","𒅁akkuck","𒋫r𒀀z𒀀z𒀀"
	,"𒉈Vol𒅋","𒁍tIlm𒋾","𒈨 𒄿dey𒅇","Nokri 𒍪","B𒀀aubb","Kraunky","𒁴 𒁀 Jvis","Glyr'𒀸𒀀𒄿"," 𒀭Col𒀭","𒋾𒅋 Rite"
	,"𒋾𒁍","𒈾𒉿𒊑 𒅎","𒄴𒋫𒄠𒂊𒁍𒍑","𒅗𒋫𒆷 𒈠𒀜","𒆠𒄿𒋼𒁍","𒇷𒅗𒄿𒋗","𒌅𒊺𒍪","𒅔'𒀭𒀭","𒂊𒅖𒂊𒅖"," 𒉡 𒌝 𒊭 𒆠"
	,"Eugoi,𒅗𒄠","Moa'𒂵𒂵","𒈾𒆪𒀜'acite","Bosh𒁍 𒂍𒀭𒌓","𒐍𒄘𒍏 Nio","Phizzyee","𒈬𒂵𒄠 Zanthum","Quarn𒀭𒉌","𒅗𒍑'tiax","Rena𒐍𒐍"
]

const alphabet = 'abcdefghijklmnopqrstuvwxyz'

# Not Used Right Now
const possible_sprites := [
		["res://Art/Aliens/Amorphus/blobby_no.png","res://Art/Aliens/Amorphus/rot_no.png","res://Art/Aliens/Amorphus/tutorialslime_no.png"],#No Alien
		["res://Art/Aliens/Amorphus/blobby_yes1.png","res://Art/Aliens/Amorphus/blobby_yes2.png","res://Art/Aliens/Amorphus/blobby_yes3.png",
		"res://Art/Aliens/Amorphus/rot_yes1.png","res://Art/Aliens/Amorphus/rot_yes2.png","res://Art/Aliens/Amorphus/rot_yes3.png",
		"res://Art/Aliens/Amorphus/tutorialslime_yes1.png","res://Art/Aliens/Amorphus/tutorialslime_yes2.png","res://Art/Aliens/Amorphus/tutorialslime_yes3.png"],
		["res://Art/Aliens/Ancient/angel_no.png","res://Art/Aliens/Ancient/hole_no.png","res://Art/Aliens/Ancient/weaver_no.png"],#No Alien
		["res://Art/Aliens/Ancient/angel_yes1.png","res://Art/Aliens/Ancient/angel_yes2.png","res://Art/Aliens/Ancient/angel_yes3.png",
		"res://Art/Aliens/Ancient/hole_yes1.png","res://Art/Aliens/Ancient/hole_yes2.png","res://Art/Aliens/Ancient/hole_yes3.png",
		"res://Art/Aliens/Ancient/weaver_yes1.png","res://Art/Aliens/Ancient/weaver_yes2.png","res://Art/Aliens/Ancient/weaver_yes3.png"],
		["res://Art/Aliens/Foliage/bloodshroom_no.png","res://Art/Aliens/Foliage/cactus_no.png","res://Art/Aliens/Foliage/venusflytrap_no.png"],#No Alien
		["res://Art/Aliens/Foliage/bloodshroom_yes1.png", "res://Art/Aliens/Foliage/bloodshroom_yes2.png", "res://Art/Aliens/Foliage/bloodshroom_yes3.png",
		"res://Art/Aliens/Foliage/cactus_yes1.png","res://Art/Aliens/Foliage/cactus_yes2.png","res://Art/Aliens/Foliage/cactus_yes3.png",
		"res://Art/Aliens/Foliage/venusflytrap_yes1.png","res://Art/Aliens/Foliage/venusflytrap_yes2.png","res://Art/Aliens/Foliage/venusflytrap_yes3.png"],
		["res://Art/Aliens/Horned/deer_no.png","res://Art/Aliens/Horned/markhor_no.png","res://Art/Aliens/Horned/monk_no.png"],#No Alien
		["res://Art/Aliens/Horned/deer_yes1.png","res://Art/Aliens/Horned/deer_yes2.png","res://Art/Aliens/Horned/deer_yes3.png",
		"res://Art/Aliens/Horned/markhor_yes1.png","res://Art/Aliens/Horned/markhor_yes2.png","res://Art/Aliens/Horned/markhor_yes3.png",
		"res://Art/Aliens/Horned/monk_yes1.png","res://Art/Aliens/Horned/monk_yes2.png","res://Art/Aliens/Horned/monk_yes3.png"],
		["res://Art/Aliens/HumanOrgans/cataracts_no.png","res://Art/Aliens/HumanOrgans/guts_no.png","res://Art/Aliens/HumanOrgans/tendons_no.png"],#No Alien
		["res://Art/Aliens/HumanOrgans/cataracts_yes1.png","res://Art/Aliens/HumanOrgans/cataracts_yes2.png","res://Art/Aliens/HumanOrgans/cataracts_yes3.png",
		"res://Art/Aliens/HumanOrgans/guts_yes1.png","res://Art/Aliens/HumanOrgans/guts_yes2.png","res://Art/Aliens/HumanOrgans/guts_yes3.png",
		"res://Art/Aliens/HumanOrgans/tendons_yes1.png","res://Art/Aliens/HumanOrgans/tendons_yes2.png","res://Art/Aliens/HumanOrgans/tendons_yes3.png"],
		["res://Art/Aliens/Marine/angler_no.png","res://Art/Aliens/Marine/squid_no.png","res://Art/Aliens/Marine/whale_no.png"],#No Alien
		["res://Art/Aliens/Marine/angler_yes1.png","res://Art/Aliens/Marine/angler_yes2.png","res://Art/Aliens/Marine/angler_yes3.png",
		"res://Art/Aliens/Marine/squid_yes1.png","res://Art/Aliens/Marine/squid_yes2.png","res://Art/Aliens/Marine/squid_yes3.png",
		"res://Art/Aliens/Marine/whale_yes1.png","res://Art/Aliens/Marine/whale_yes2.png","res://Art/Aliens/Marine/whale_yes3.png"],
		["res://Art/Aliens/Mechanical/oilrig_no.png","res://Art/Aliens/Mechanical/securitycam_no.png","res://Art/Aliens/Mechanical/tvwires_no.png"],#No Alien
		["res://Art/Aliens/Mechanical/oilrig_yes1.png","res://Art/Aliens/Mechanical/oilrig_yes2.png","res://Art/Aliens/Mechanical/oilrig_yes3.png",
		"res://Art/Aliens/Mechanical/securitycam_yes1.png","res://Art/Aliens/Mechanical/securitycam_yes2.png","res://Art/Aliens/Mechanical/securitycam_yes3.png",
		"res://Art/Aliens/Mechanical/tvwires_yes1.png","res://Art/Aliens/Mechanical/tvwires_yes2.png","res://Art/Aliens/Mechanical/tvwires_yes3.png"]
]
		
		
const star_sector_dict = {
	"Inverse Null":[
		["C41-G4RY","R3D DII R"],
		["res://Art/StarSectorSymbol/StarSec_Ancient1.png",
		"res://Art/StarSectorSymbol/StarSec_Ancient2.png"]
	],
	"Synthesia IV":[
		["V4N-CV", "V1K-TR4", "RC M0-ND"],
		["res://Art/StarSectorSymbol/StarSec_Caldoria1.png",
		"res://Art/StarSectorSymbol/StarSec_Caldoria2.png"]
	],
	"Caldoria Prime":[
		["T2", "02T-4", "LN-D0N"],
		["res://Art/StarSectorSymbol/StarSec_Leaf1.png",
		"res://Art/StarSectorSymbol/StarSec_Leaf2.png"]
	],
	"Feletta":[
		["W1 NII P3G"],
		["res://Art/StarSectorSymbol/StarSec_Lunar1.png",
		"res://Art/StarSectorSymbol/StarSec_Lunar2.png"]
	],
	"Carnesta":[
		["SK-2N", "R3 GN4"],
		["res://Art/StarSectorSymbol/StarSec_Mariplant1.png",
		"res://Art/StarSectorSymbol/StarSec_Mariplant2.png"]
	],
	"Vizion":[
		["H4L II FX", "YRM 0T"],
		["res://Art/StarSectorSymbol/StarSec_Null1.png",
		"res://Art/StarSectorSymbol/StarSec_Null2.png"]
	],
	"Pythagoria":[
		["L3M 0-SIIV", "INU VII K", "42-RMA"],
		["res://Art/StarSectorSymbol/StarSec_Triangle1.png",
		"res://Art/StarSectorSymbol/StarSec_Triangle2.png"]
	]
}

const goodPurposeOfVisit := [
"Vacation", "Visiting Family", "Visiting Friends", "Work", "Education", "Convention", "Business Meeting", "Treatment", "Training Course", "Holiday",
"Passing By", "Relocation", "Biological Research", "Shopping", "Sports Event", "Movie Premiere", "Contract Work", "Resupply", "Space Trading", "Mining Prospection",
"Planet Exploration", "Species Study", "Asylum", "Ship Repair", "Junk Removal", "Construction", "Anomalous Research", "Sector Mapping", "Sector Festival", "Archaeology",
"Data Upload", "Bounty Hunting", "Cultural Exchange", "Habitat Inspection", "Space Conference", "Diplomacy", "Artifact Research", "Peacekeeping", "Sports Tournament", "License Exam",
"Volunteer Work", "Pilgrimage", "Art Exhibit", "School Enrollment", "Real Estate", "Funeral", "Marriage", "Tourism", "Jury Duty", "Apprenticeship"
]

const badPurposeOfVisit := [
"World Domination", "...", "To Infect", "To Expand", "Smuggling", "Murder", "Revenge", "Vandalism", "Rebellion", "Drug Trade",
"Parasitism", "Quantum Theft", "Piracy", "Species Trafficking", "Hijacking", "Death", "Body Theft", "Mind Control", "Orbital Bombing", "Junk Dumping",
"Alien Poaching", "Bioweapon Trade","Identity Fraud",	"Cosmic Pillaging",	"Embezzlement ", "Homicide", "Laundering",	"Slavery", "Exortion", "Tax Evasion",
"Assimilate Life", "Espionage", "Black Market", "Terrorism", "AI-Piracy", "Art-Piracy", "Cult Recruitment", "Hostile Takeover",	"Stalking", "Sabotage",
"Research Fraud", "Illegal Trade","Scorch Earth", "Uprising", "Deathmatch", "Corruption", "Give me body", "Cosume World", "Extermination","Genocide"
]

func get_alien_name() -> String:
	return alien_name
	
func get_alien_star_sector() -> String:
	return alien_star_sector
	
func get_alien_star_sector_symbol() -> String:
	return alien_star_sector_symbol
	
func get_alien_planet() -> String:
	return alien_planet
	
func set_alien_name():
	randomize()
	var x = randi() % possible_names.size()
	alien_name = possible_names[x]

func get_alien_sprite() -> Sprite2D:
	var alien_sprite = find_child("alien_sprite")
	return alien_sprite
	
func set_alien_sprite() -> String:
	# Option 1 is using 2D Array and using random to pick for now, will have to use numbers/math to pick illegal variant
	###################################################################################
	#var typeOfAlienSprite = randi_range(0, possible_sprites.size() -1)
	#var alienSpritePos = randi_range(0, possible_sprites[typeOfAlienSprite].size()-1)
	#print(typeOfAlienSprite, " ", alienSpritePos," ", possible_sprites[typeOfAlienSprite][alienSpritePos])
	#return possible_sprites[typeOfAlienSprite][alienSpritePos]
	###################################################################################
	
	alienSprite = createAlienSpecies()
	return alienSprite[0]
	
func get_alien_is_legal() -> bool:
	return isLegal
	
func set_alien_is_legal():
	randomize()
	isLegal = randi() % 2 == 0
	
func get_id_card_expire_date() -> Array:
	return idCardExpireDate

func set_id_card_expire_date():
	idCardExpireDate = createExpireDate(1)

func get_visa_expire_date() -> Array:
	return visaExpireDate

func set_visa_expire_date():
	visaExpireDate = createExpireDate(2)

func get_visa_name() -> String:
	return visaName

func set_visa_name():
	visaName = createVisaName()

func get_visa_boarding_date() -> Array:
	return visaBoardingDate

func set_visa_boarding_date():
	visaBoardingDate = createBoardingDate()

func get_purpose() -> String:
	return purposeOfVisit
	
func set_purpose():
	purposeOfVisit = selectPurpose()
	
func get_document_sequence():
	return documentSequence
	
func set_document_sequence():
	documentSequence = build_sequence()

func set_species():
	species_name = alienSprite[3]

func get_species() -> String:
	return species_name

func set_species_symbol():
	species_symbol_path = alienSprite[1]

func get_species_symbol() -> String:
	return species_symbol_path
	
func set_alien_height():
	alienHeight = alienSprite[2]
	
func get_alien_height() -> int:
	return alienHeight
	

func get_pattern_seq_converted():
	var temp_seq = ""
	for shape in documentSequence:
		match shape.to_lower():
			"circle": 
				temp_seq += "⬤"
			"diamond": 
				temp_seq += "◆"
			"pentagon": 
				temp_seq += "⬟"
			"square": 
				temp_seq += "■"
			"triangle": 
				temp_seq += "▲"
	pattern_seq_converted = temp_seq
	return pattern_seq_converted

func set_stamp():
	create_stamp()

func get_stamp():
	return stamp_symbol_path
	
func createExpireDate(isVisa):
	randomize()
	var day
	var month
	var year
	if (!(self.isLegal) and wrongInfo==isVisa):
		var x = randi_range(1,3)
		match x:
			1:
				day = randi_range(1,currentDate[0]-1)
				month = currentDate[1]
				year = currentDate[2]
			2:
				day = randi_range(1,30)
				month = randi_range(1,currentDate[0]-1) 
				year = currentDate[2]
			3:
				day = randi_range(1,30)
				month = randi_range(1,12) 
				year = randi_range(2020,currentDate[2]-1)
	else:
		var y = randi_range(1,2)
		match y:
			1:
				day = randi_range(1,30)
				month = randi_range(1,12) 
				year = randi_range(currentDate[2]+1,2030)
			2:
				day = randi_range(currentDate[0]+1,30)
				month = randi_range(currentDate[1],12) 
				year = randi_range(currentDate[2],2030)
	return [day,month,year]
	
func createVisaName():
	if (!(self.isLegal) and wrongInfo == 3):
		var name = self.alien_name
		var pos = randi_range(0,name.length()-1)
		randomize()
		var x = randi_range(1,3) 
		match x:
			1:
				var newChar = randi_range(0,alphabet.length()-1)
				if name[pos] == alphabet[newChar] and newChar != 25:
					newChar+=1
				elif name[pos] == alphabet[newChar] and newChar == 25:
					newChar=0
				name[pos] = alphabet[newChar]
			2:
				name = name.erase(pos,1)
			3:
				var insertedChar = randi_range(0,alphabet.length())
				name = name.insert(pos,alphabet[insertedChar])
		return name 
	else:
		return self.alien_name
		

func createBoardingDate():
	var boardingDate
	if (!(self.isLegal) and wrongInfo==4):
		boardingDate = currentDate
		randomize()
		var x = randi_range(1,3) 
		match x:
			1:
				boardingDate[0] +=randi_range(1,3)
			2:
				boardingDate[0] -=randi_range(1,3)
			3:
				var swap = boardingDate[1]
				boardingDate[1] = boardingDate[0]
				boardingDate[0] = swap
	else:
		boardingDate = currentDate
	return boardingDate

func selectPurpose():
	randomize()
	if (!(self.isLegal) and wrongInfo==6):
		var x = randi() % badPurposeOfVisit.size()
		return badPurposeOfVisit[x]
	else:
		var x = randi() % goodPurposeOfVisit.size()
		return goodPurposeOfVisit[x]
		
func build_sequence():
	var sequence = []	# the thing we're returning
	
	#Size of the sequence
	var seq_max = 8
	
	#Keep track of things placed. Important for restriction 1
	var last = ""
	var second_last = ""
	
	#Keep track of the shapes
	var circ_count = 0
	var tri_count = 0
	var penta_count = 0
	var diamond_count = 0
	
	var diamond_first_flag = false
	
	#var random = RandomNumberGenerator.new()
	#random.randomize()
	
	#Build the sequence based on the restrictions.
	for i in seq_max:
		#possible shapes that can be used.
		var shapes = [1] #We can always place a square.
		
		# Check to place circles
		var circle_valid = check_circ(circ_count, tri_count, penta_count)
		if (circle_valid):
			shapes.append(2)
		
		#Check to place triangles
		if !(last == "Square" && second_last == "Triangle"):
			if (tri_count + 1 >= circ_count):
				shapes.append(3)
		
		#As long as its not the first spot, we can place a diamond.
		if (!diamond_first_flag):
			shapes.append(4)
		
		#Check to place pentagons
		if tri_count > 0:
			shapes.append(5)
		elif penta_count+1 >= circ_count:
			shapes.append(5)
		
		#Get a random shape from the possible shapes array
		var random = randi_range(0, shapes.size()-1)
		
		#Place is the random number from the random selection, grabbing it from the dictionary.
		var place = shape_dict[shapes[random]]
		
		#Update all of our date if needed.
		sequence.append(place)
		second_last = last
		last = place
		
		#Update all of our data if needed.
		if (place == "Circle"):
			circ_count += 1
		elif (place == "Triangle"):
			tri_count += 1
		elif (place == "Pentagon"):
			penta_count += 1
		elif (place == "Diamond"):
			diamond_count += 1
	
		if (i==0):
			diamond_first_flag = true
	
	if (!(self.isLegal) and wrongInfo == 5):	#Destroy the sequence if wrongInfo is 5.
		sequence = destroy_sequence(sequence, circ_count, tri_count, penta_count, diamond_count)
		
	return sequence

#Function to check the complicated restrcition of circles.
func check_circ(circ, tri, penta):
	# Place a circle if it is less than triangle count and a triangle exists
	if (tri >= 1):
		if (circ + 1 > tri):
			return false	
		else:
			return true
			
	elif (penta >= 1):		#if no triangles, then we follow pentagon rules.
		if (circ + 1 > penta):
			return false
		else:
			return true
			
	else:	#There are no triangles nor pentagons, so we can place a circle.
		return true

func destroy_sequence(seq_p, circles_p, triangles_p, pentagons_p, diamonds_p):
	#Some random generator variables
	var random
	var random2
	
	#Choose a random rule to violate
	random = randi_range(1, 4)
	
	#Just for clarity to know what I'm using. 
	var seq = seq_p
	var circles = circles_p
	var triangles = triangles_p
	var pentagons = pentagons_p
	var diamonds = diamonds_p
	
	if random == 1:
		print("VIOLATING RULE 1")	#violate rule one, which involves square and triangle placement
		random2 = randi_range(1,seq.size()-2)
		seq[random2] = "Square"
		seq[random2-1] = "Triangle"
		seq[random2+1] = "Triangle"
	elif random == 2: #Violate rule two, which involves circles, triangles and pentagons.
		print("VIOLATING RULE 2")
		var current_shape_count	#The shape that is the reliant one between triangle and pentagon
		var current_shape = ""	#For checking.
		
		#Check to see which shape has priority. If none, set one up forcefully as a priority shape.
		if (triangles > 0):
			current_shape_count = triangles
			current_shape = "Triangle"
		elif (pentagons > 0):
			current_shape_count = pentagons
			current_shape = "Pentagon"
		else:
			random2 = randi_range(0,1)
			if (random2 == 0):
				current_shape_count = triangles
				current_shape = "Triangle"
			else:
				current_shape_count = pentagons
				current_shape = "Pentagon"
			random2 = randi_range(0,seq.size()-1)
			seq[random2] = current_shape
		
		while(circles <= current_shape_count):
			random2 = randi_range(0,seq.size()-1)
			
			var removed = seq[random2]
		
			if (removed != "Circle"):
				if (removed == current_shape && current_shape_count-1 > 0):
					seq[random2] = "Circle"
					current_shape_count -= 1
					circles += 1
				else:
					seq[random2] = "Circle"
					circles += 1
	elif random == 3:	#violate rule 3, which involves diamond placement and cout
		print("VIOLATING RULE 3")
		seq[0] = "Diamond"
		random2 = randi_range(1, seq.size()-1)
		seq[random2] = "Diamond"
	elif random == 4:
		print("VIOLATING RULE 4")	#Violate rule 4, which involves number of shapes in the sequence
		random2 = randi_range(0,1)
		if random2 == 0:
			random2 = randi_range(1,5)
			seq.append(shape_dict[random2])
		else:
			seq.pop_back()
	return seq

func set_alien_star_sector():
	var valid_sector = star_sector_dict.keys().pick_random()
	
	if (!(self.isLegal) and wrongInfo == 9):
		var temp_sector = star_sector_dict.keys().pick_random()
		
		while (temp_sector == valid_sector):
			temp_sector = star_sector_dict.keys().pick_random()
			
		alien_star_sector = valid_sector
		alien_planet = star_sector_dict.get(temp_sector)[0].pick_random()
	else:
		alien_star_sector = valid_sector
		alien_planet = star_sector_dict.get(alien_star_sector)[0].pick_random()
		
func set_alien_star_sector_symbol():
	var valid_symbol = star_sector_dict.get(alien_star_sector)[-1].pick_random()
	
	if (!(self.isLegal) and wrongInfo == 10):
		var temp_symbol = star_sector_dict.get(alien_star_sector)[-1].pick_random()
		while (temp_symbol == valid_symbol):
			temp_symbol = star_sector_dict.get(alien_star_sector)[-1].pick_random()
		alien_star_sector_symbol = temp_symbol
	else:
		alien_star_sector_symbol = valid_symbol

func get_id_card_image() -> String:
	return idCardImage

func set_id_card_image():
	idCardImage = createIDCardImage()

func createIDCardImage() -> String:
	var alienSpritePath = self.alienSprite[0]
	alienSpritePath = alienSpritePath.replace("Aliens","ID")
	print("sprite: " + self.alienSprite[0])
	if (!(self.isLegal) and wrongInfo == 8):
		var wrongIDImage = alienSpritePath
		print("sprite: " + self.alienSprite[0])
		wrongIDImage = wrongIDImage[-5]
		var modifier = [-1,1]
		wrongIDImage = int(wrongIDImage) + modifier.pick_random()
		var newNum =  wrongIDImage %3
		if(newNum == 0):
			newNum += 3
		alienSpritePath = alienSpritePath.replace(alienSpritePath[-5],str(newNum))
		return alienSpritePath
	else:
		
		return alienSpritePath
	

func createAlienSpecies() -> Array:
	var alienSpeciesInfo = []
	
	var dirNameAlien := "res://Art/Aliens/"
	var fileNames := DirAccess.get_directories_at(dirNameAlien)
	var notPackedFileNames:= Array(fileNames)
	var randomSpeciesFolder = notPackedFileNames.pick_random()
	var newFilePath := DirAccess.get_files_at(dirNameAlien+randomSpeciesFolder)
	var filePath := Array(newFilePath)
	var rawFiles = []
	for i in len(filePath):
		if (i%2 ==0):
			if (wrongInfo == 7 and !(self.isLegal)):
				if (filePath[i].find("_no") > 0):
					rawFiles.append(filePath[i])
			elif (filePath[i].find("_no") == -1):
				rawFiles.append(filePath[i])

	var randomAlienSprite = rawFiles.pick_random()
	alienSpeciesInfo.append(String(dirNameAlien+randomSpeciesFolder+"/"+randomAlienSprite))
	#print(dirNameAlien+randomSpeciesFolder+"/"+randomAlienSprite)
	
	
	var dirNameSpeciesSymbol := "res://Art/SpeciesSymbol/"
	var speciesSymbolPNG
	
	if (wrongInfo == 12 and !(self.isLegal)):
		var speciesList = ["Amorphus","Ancient","Foliage","Horned","Horned","Marine","Mechanical"]
		var position =  speciesList.find(randomSpeciesFolder)
		speciesList.pop_at(position)
		randomSpeciesFolder = speciesList.pick_random()
		
	match randomSpeciesFolder:
		"Amorphus":
			speciesSymbolPNG = "SpeciesSymbol_Amorphys.png"
		"Ancient":
			speciesSymbolPNG = "SpeciesSymbol_Ancient.png"
		"Foliage":
			speciesSymbolPNG = "SpeciesSymbol_Foliaceous.png"
		"Horned":
			speciesSymbolPNG = "SpeciesSymbol_Artiodactyl.png"
		"HumanOrgans":
			speciesSymbolPNG = "SpeciesSymbol_Offalis.png"
		"Marine":
			speciesSymbolPNG = "SpeciesSymbol_Marquatic.png"
		"Mechanical":
			speciesSymbolPNG = "SpeciesSymbol_Mechanica.png"
			
	alienSpeciesInfo.append(dirNameSpeciesSymbol+speciesSymbolPNG)
	
	alienSpeciesInfo.append(findHeight(randomAlienSprite))
	alienSpeciesInfo.append(randomSpeciesFolder) #alien species index 3
	print(alienSpeciesInfo)
	return alienSpeciesInfo

func findHeight(alien):
	var alienFileName = alien.split("_")
	print(alienFileName)
	
	match alienFileName[0]:
		"blobby":
			return 530
		"rot":
			return 570
		"tutorialslime":
			return 470
		"angel":
			return 490
		"hole":
			return 440
		"weaver":
			return 455
		"bloodshroom":
			return 560
		"cactus":
			return 535
		"venusflytrap":
			return 425
		"deer":
			return 390
		"markhor":
			return 465
		"monk":
			return 490
		"cataracts":
			return 490
		"guts":
			return 513
		"tendons":
			return 535
		"angler":
			return 500
		"squid":
			return 515
		"whale":
			return 465
		"oilrig":
			return 500
		"securitycam":
			return 535
		"tvwires":
			return 530

func create_stamp():
	var random
	var stamp = "res://Art/Stamp/Stamp" 
	if (!(self.isLegal) and wrongInfo == 11):
		random = randi_range(1,6)
		stamp += ("Fake_" + str(random) + ".png")
	else:
		random = randi_range(1,3)
		stamp += ("Official_" + str(random) + ".png")
	stamp_symbol_path = stamp	
	print (stamp_symbol_path)
# Called when the node enters the scene tree for the first time.
func _ready():
	set_alien_name()
	set_alien_star_sector()
	set_alien_star_sector_symbol()
	set_alien_is_legal()
	set_id_card_expire_date()
	set_visa_expire_date()
	set_visa_name()
	set_visa_boarding_date()
	set_purpose()
	set_document_sequence()
	$alien_sprite.texture = load(set_alien_sprite())
	set_id_card_image()
	set_species_symbol()
	set_species()
	set_alien_height()
	set_stamp()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
