# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sucho <sucho@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/05/04 11:50:24 by cboutier          #+#    #+#              #
#    Updated: 2023/03/04 21:59:23 by sucho            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS 			= ./srcs
DOCKER			= docker
COMPOSE 		= cd srcs/ && docker compose
DATA_PATH 		= $(HOME)/data

all		:
			sudo mkdir -p $(DATA_PATH)
			sudo mkdir -p $(DATA_PATH)/wordpress
			sudo mkdir -p $(DATA_PATH)/database

clean	:
			$(COMPOSE) down -v --rmi all --remove-orphans



fclean	:	clean
			$(DOCKER) system prune --volumes --all --force
			sudo rm -rf $(DATA_PATH)
			$(DOCKER) network prune --force
			$(DOCKER) volume prune --force
			$(DOCKER) image prune --force

re		:	fclean all

.PHONY	:	re fclean clean all
