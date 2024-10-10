''
  function kinak
      read -s -P "Enter rclone password: " RCLONE_CONFIG_PASS
      echo
      read -s -P "Enter restic password: " RESTIC_PASSWORD
      echo
      set -lx RCLONE_CONFIG_PASS $RCLONE_CONFIG_PASS
      set -lx RESTIC_PASSWORD $RESTIC_PASSWORD

      while true
  		echo -e "Enter 1 to backup"
      	echo -e "Enter 2 to gc"
  		echo -e "Enter 3 to sync"
  		echo -e "Enter 4 to print snapshots"
  		echo -e "Enter 5 to check repository"
  		echo -e "Enter 6 to forge <hashid>"
  		echo -e "Enter 7 to custom command"
  		echo -e "Enter 0 to exit"
          read -P "ready?: " answer
          switch $answer
              case "1"
                  echo -e "Start backup🌟\n"
                  restic -r rclone:restic-local: backup --tag Pictures🎨 ~/Pictures
                  echo -e "Pictures OK🌟\n"
                  restic -r rclone:restic-local: backup --tag Music🎵 ~/Music/bgm/
                  echo -e "Music OK🌟\n"
  				restic -r rclone:restic-local: backup --tag Video📼 ~/Videos/
  				echo -e "Video OK🌟\n"
                  restic -r rclone:restic-local: backup --tag Documents📚 ~/Documents/*
                  echo -e "Documents OK🌟\n"
                  restic -r rclone:restic-local: backup --tag rclone🌌 ~/rclone/
                  echo -e "rclone OK🌟\n"
              case "2"
                  echo -e "Start gc"
                  restic -r rclone:restic-local: forget --keep-last 1 --prune 
              case "3"
                  echo -e "Start sync"
                  rclone sync ~/restic google:restic -P
              case "4"
                  echo -e "Print snapshots"
                  restic -r rclone:restic-local: snapshots
                  restic -r rclone:restic-google: snapshots
              case "5"
                  echo -e "Check repository"
                  rclone check ~/restic/ google:restic/
  			case "6"
  				read -P "Hash id: " hashId
  				set hashIdM (string trim -c '"' "$hashId")
  				eval restic -r rclone:restic-local: forget $hashIdM --keep-last 1 --prune
  			case "7"
  				read -P "Custom command: " whatCommand
  				eval $whatCommand
              case "0"
                  echo -e "exit"
                  return
          end
      end
  end
''
