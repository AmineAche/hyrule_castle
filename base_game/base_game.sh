#!/bin/bash

                                                                                                                                                       # Fonctions
Save_Player_Csv() {
    while IFS=',' read -r id name hp mp str int def res spd luck race class rarity; do
	if [[ $id == 1 ]]; then
	    Myplayer_name=$name
	    Myplayer_hp=$hp      
	    Myplayer_hpmax=$hp
	    Myplayer_halfhp=$((hp / 2))
	    Myplayer_str=$str
	fi 
    done < players.csv
}


Save_Monster_Csv() {
    while IFS=',' read -r id name hp mp str int def res spd luck race class rarity; do
	if [[ $id == 12 ]]; then
	    Monster_name=$name
	    Monster_hp=$hp
	    Monster_maxhp=$hp
	    Monster_str=$str
	fi
    done < enemies.csv
}


Save_Bosses_Csv() {
    while IFS=',' read -r id name hp mp str int def res spd luck race class rarity; do
	if [[ $id == 1 ]]; then
	    Boss_name=$name
	    Boss_hp=$hp
	    Boss_maxhp=$hp
	    Boss_str=$str
	fi
    done < bosses.csv
}


Combat() {
    while [[ $Monster_hp -gt  0 ]]; do
	echo ""
	echo ""
	echo "----------- Choose your action -------------"
	echo "          1                       2         "
	echo "====================="  "==================="
	echo "====== Attack ======="  "====== Heal ======="
	echo "====================="  "==================="
	read choix
	if [[ $choix != 1 ]] && [[ $choix != 2 ]]; then
	    echo "----------- Choose your action -------------"
	    echo "          1                       2         "
	    echo "====================="  "==================="
	    echo "====== Attack ======="  "====== Heal ======="
	    echo "====================="  "==================="
	    read  choix
	elif [[ $choix == 1 ]]; then
	    Monster_hp=$((Monster_hp - Myplayer_str))
	    echo "==> $Myplayer_name did $Myplayer_str damages to $Monster_name ."
	    echo ""
	    echo ""
	    echo "---------------------------------------------------------------------------  $Monster_name  ---------""   $Monster_hp ""/ " "$Monster_maxhp"
	    echo ""
	    echo ""
	    read ok
	elif [[ $choix == 2 ]]; then
	    echo $Myplayer_halfhp
	    echo $Myplayer_hpmax
	    echo $Myplayer_hp
	    
	    if [[ $Myplayer_hp -ge $Myplayer_halfhp ]]; then
		Myplayer_hp=$Myplayer_hpmax
		echo ""
		echo " Now you are full life !"
		echo ""
		echo "------------------------------------------------------------------------"" $Myplayer_name ""------------" "$Myplayer_hp" " / " "$Myplayer_hpmax"
		read ok
	    else
		Myplayer_hp=$((Myplayer_hp + Myplayer_halfhp))
		echo "==> You use Heal ! "
		echo "------------------------------------------------------------------------- $Myplayer_name ------------- $Myplayer_hp / $Myplayer_hpmax"
		read ok
	    fi
	fi
	if [[ $Monster_hp -gt 0 ]]; then 
	    echo "==> Now $Monster_name can attack"
	    echo ""
	    Myplayer_hp=$((Myplayer_hp - Monster_str))
	    echo "==> $Monster_name attacked and dealt $Monster_str damages to $Myplayer_name !"
	    echo ""
	    echo " -------------------------------------------------------------------------- $Myplayer_name --------- $Myplayer_hp / $Myplayer_hpmax"
	else
	    echo "                                -------------------- $Monster_name is dead. ---------------------"
	fi
    if [[ $Myplayer_hp -le 0 ]]; then
	echo "----------------------------------------- Game Over -----------------------------------------"
	read ok
	exit 0
    else echo ""
    fi
done
}
                                                                                      # Fin des fonctions

                                                                                             #Liste de Variables 
floor=1
                                                                                              #D??but du code

Save_Player_Csv
Save_Monster_Csv
Save_Bosses_Csv

echo "               ------------------------------"
echo "     ------------------- Welcome -------------------" 
echo "---------------------- To      The -----------------------"
echo "     ------------ World    of     Zelda ------------"
echo "            ----------------------------------"
echo""
echo""
read ok
clear
echo "===> New Game"
read ok
clear






while [[ $floor != 10 ]]; do
    echo "=================== FIGHT "$floor"================"
    Monster_hp=$Monster_maxhp 
    Combat                                                                                                #Boucle pour r??aliser les 9 premiers ??tages
    clear
    
    if [[ $Monster_hp -le 0 ]]; then
	floor=$((floor + 1))
    fi
done
clear

echo "------------------------------ You enter in the Boss Floor   -----------------------------------------"
echo ""
echo "You will Fight versus $Boss_name ( Strength : $Boss_str, Life : $Boss_hp )"
echo ""
echo "Good Luck"
read ok
clear

while [[ $Boss_hp -gt  0 ]]; do
    echo ""
    echo ""
    echo "----------- Choose your action -------------"
    echo "          1                       2         "
    echo "====================="  "==================="
    echo "====== Attack ======="  "====== Heal ======="
    echo "====================="  "==================="
    read choix
    if [[ $choix != 1 ]] && [[ $choix != 2 ]]; then
	echo "----------- Choose your action -------------"
	echo "          1                       2         "
	echo "====================="  "==================="
	echo "====== Attack ======="  "====== Heal ======="
	echo "====================="  "==================="
	read  choix
    elif [[ $choix == 1 ]]; then
	Boss_hp=$((Boss_hp - Myplayer_str))
	echo "==> $Myplayer_name did $Myplayer_str damages to $Boss_name ."
	echo ""
	echo ""
	echo "---------------------------------------------------------------------------  $Boss_name  ---------""   $Boss_hp ""/ " "$Boss_maxhp"
	echo ""
	echo ""
	read ok
    elif [[ $choix == 2 ]]; then
	
	if [[ $Myplayer_hp -ge $Myplayer_halfhp ]]; then
	    Myplayer_hp=$Myplayer_hpmax
	    echo ""
	    echo " Now you are full life !"
	    echo ""
	    echo "------------------------------------------------------------------------"" $Myplayer_name ""------------" "$Myplayer_hp" " / " "$Myplayer_hpmax"
	    read ok
	else
	    Myplayer_hp=$((Myplayer_hp + Myplayer_halfhp))
	    echo "==> You use Heal ! "
	    echo "------------------------------------------------------------------------- $Myplayer_name ------------- $Myplayer_hp / $Myplayer_hpmax"
	    read ok
	fi
    fi
    if [[ $Boss_hp -gt 0 ]]; then
	echo "==> Now $Boss_name can attack"
	echo ""
	Myplayer_hp=$((Myplayer_hp - Boss_str))
	echo "==> $Boss_name attacked and dealt $Boss_str damages to $Myplayer_name !"
	echo ""
	echo " -------------------------------------------------------------------------- $Myplayer_name --------- $Myplayer_hp / $Myplayer_hpmax"
    else
	echo "                                -------------------- $Boss_name is dead. ---------------------"
	echo "                             -------------------------- Congratulation ---------------------------"
    fi
    if [[ $Myplayer_hp -le 0 ]]; then
	echo "----------------------------------------- Game Over -----------------------------------------"
	read ok
	exit 1                                                                                                                                                                                                                              
    fi
done
