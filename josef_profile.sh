#!/usr/bin/env bash:wq

# ======================================
# 🌐 JOSEF TAN :: FULL TERMINAL SYSTEM
# ======================================

LINKEDIN="https://www.linkedin.com/in/josef-tan/"
GITHUB="https://github.com/joseftanlang"
WHATSAPP="https://wa.me/6588454281"
EMAIL="mailto:tanjosef33@gmail.com"

# ---------- COLORS ----------
YELLOW="\e[33m"
CYAN="\e[36m"
BOLD="\e[1m"
RESET="\e[0m"

# ---------- MENU ----------
options=(
"About"
"Work"
"Skills"
"LinkedIn"
"GitHub"
"WhatsApp"
"Email"
"Secret"
"Game + Cat Mode"
"Exit"
)

selected=0

# ---------- CAT ANIMATION ----------
cat1=("   /\_/\   " "  ( o.o )  " "   > ^ <   ")
cat2=("   /\_/\   " "  ( -.- )  " "   > ^ <   ")

cat_frame=0

# ---------- DRAW MENU ----------
draw() {
    clear

    echo -e "${CYAN}${BOLD}======================================"
    echo "      JOSEF TAN TERMINAL SYSTEM"
    echo -e "======================================${RESET}"
    echo

    # LEFT SIDE MENU
    for i in "${!options[@]}"; do
        if [ "$i" -eq "$selected" ]; then
            echo -e "${YELLOW}${BOLD}> ${options[$i]}${RESET}"
        else
            echo "  ${options[$i]}"
        fi
    done

    echo
    echo "--------------------------------------"
    echo "🐱 CAT SIDE PANEL"
    echo "--------------------------------------"

    # RIGHT SIDE CAT ANIMATION
    if ((cat_frame % 2 == 0)); then
        echo "   ${cat1[0]}"
        echo "   ${cat1[1]}"
        echo "   ${cat1[2]}"
    else
        echo "   ${cat2[0]}"
        echo "   ${cat2[1]}"
        echo "   ${cat2[2]}"
    fi

    ((cat_frame++))
}

# ---------- INPUT ----------
read_input() {
    read -rsn1 key

    if [[ $key == $'\x1b' ]]; then
        read -rsn2 key
        case $key in
            "[A") ((selected--)) ;;
            "[B") ((selected++)) ;;
        esac
    elif [[ $key == "" ]]; then
        execute
    fi

    ((selected < 0)) && selected=$((${#options[@]}-1))
    ((selected >= ${#options[@]})) && selected=0
}

# ---------- ACTIONS ----------
execute() {
    case $selected in

        0)
        clear

        echo "+-------------------------------------+"
        echo "|               ABOUT                 |"
	echo "+-------------------------------------+"
        echo "|    Builder • Learner • Creator      |"
        echo "| Focus: systems that solve problems  |"
	echo "+-------------------------------------+"

        read -p "enter..."
        ;;

        1)
        clear

	echo "+-----------------------+"
        echo "|         WORK          |"
	echo "+-----------------------+"
        echo "| • Community leadership|"
        echo "| • Teaching            |"
        echo "| • Automation projects |"
	echo "+-----------------------+"

        read -p "enter..."
        ;;

        2)
	clear

	echo "+----------------------------------------------+"
	echo "|                    SKILLS                   |"
	echo "+----------------------------------------------+"
	echo "| Excel | AI | Teaching | Problem Solving     |"
	echo "+----------------------------------------------+"

	read -p "enter..."



        ;;

        3)
        xdg-open "$LINKEDIN" >/dev/null 2>&1 &
        ;;

        4)
        xdg-open "$GITHUB" >/dev/null 2>&1 &
        ;;

        5)
        xdg-open "$WHATSAPP" >/dev/null 2>&1 &
        ;;

        6)
        xdg-open "$EMAIL" >/dev/null 2>&1 &
        ;;

        7)
        clear
        echo "SECRET"
        echo "You're building something bigger than you think."
        read -p "enter..."
        ;;

        8)
        game
        ;;

        9)
        clear
        exit
        ;;
    esac
}

# ---------- GAME ----------
game() {
    stty -echo -icanon time 0 min 0

    px=10; py=5
    ex=20; ey=10

    while true; do
        clear

        for ((y=0;y<15;y++)); do
            for ((x=0;x<30;x++)); do
                if ((x==px && y==py)); then
                    echo -n "P"
                elif ((x==ex && y==ey)); then
                    echo -n "X"
                elif ((x==0 || y==0 || x==29 || y==14)); then
                    echo -n "#"
                else
                    echo -n "."
                fi
            done
            echo
        done

        echo
        echo "WASD move | Q quit"

        read -rsn1 k

        case $k in
            w) ((py--)) ;;
            s) ((py++)) ;;
            a) ((px--)) ;;
            d) ((px++)) ;;
            q) stty sane; return ;;
        esac

        ((ex<px)) && ((ex++))
        ((ex>px)) && ((ex--))
        ((ey<py)) && ((ey++))
        ((ey>py)) && ((ey--))

        if ((px==ex && py==ey)); then
            clear
            echo "GAME OVER"
            sleep 1
            stty sane
            return
        fi
    done
}

# ---------- MAIN LOOP ----------
while true; do
    draw
    read_input
    sleep 0.1
done
