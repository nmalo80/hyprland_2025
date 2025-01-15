import subprocess
from datetime import datetime

start_time = datetime.strptime('08:00', '%H:%M').time()
end_time = datetime.strptime('20:00', '%H:%M').time()

def check_and_change_theme_if_needed():
    # Get current date and time
    current_time = datetime.now().time()

    # get current system theme
    command = "cat $HOME/.cache/.theme_mode"

    process = subprocess.run(command, shell=True, stdout=subprocess.PIPE)
    current_theme = process.stdout.decode('utf-8')

    if start_time <= current_time <= end_time:
        if current_theme == "Dark\n":
            change_theme()
    else:
        if current_theme == "Light\n":
            change_theme()

def change_theme(): 
    command = "$HOME/.config/hypr/scripts/DarkLight.sh"
    process = subprocess.run(command, shell=True)
    print(process.returncode) 


while True:
    check_and_change_theme_if_needed()
    time.sleep(300)

