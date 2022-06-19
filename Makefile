all : update
	@./addtosource.sh;./ohmyscript.sh

update :
	@git pull --quiet

#add crontab; add fin kayn;  conigfile