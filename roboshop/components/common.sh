HEAD(){
  echo -n -e "\e[1m $1 \e[0m \t\t ... "
}

STAT(){
  if [ $1 -eq 0 ]; then
    echo -e "\e[1;32m SUCCESS \e[0m"
      echo -e "\e[1;32m SUCCESS from two \e \033[36m%-30s\033[0m %s\n"
  else
    echo -e "\e[1;31m FAILED \e[0m"
    echo -e "\e[1;33m Check the log for more details...Log-file: /tmp/roboshop.log\e[0m"
    exit 1
  fi

}


