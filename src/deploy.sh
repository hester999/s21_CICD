#!/bin/bash

REMOTE_HOST="192.168.0.18"
REMOTE_USER="user"
REMOTE_DIR="/usr/local/bin"


PATH_1="/home/gitlab-runner/builds/Px5du6p_/0/students/DO6_CICD.ID_356283/agathaze_student.21_school.ru/DO6_CICD-1/src/cat/s21_cat"
PATH_2="/home/gitlab-runner/builds/Px5du6p_/0/students/DO6_CICD.ID_356283/agathaze_student.21_school.ru/DO6_CICD-1/src/grep/s21_grep"

# Копирование файлов на удалённый сервер
scp -o StrictHostKeyChecking=no $PATH_1 $PATH_2 $REMOTE_USER@$REMOTE_HOST:/tmp

# Проверка на наличие ошибок при копировании
if [ $? -ne 0 ]; then
	    echo "Ошибка при копировании файлов"
	        exit 1
fi

# Перемещение файлов в целевую директорию на удалённом сервере
ssh -o StrictHostKeyChecking=no $REMOTE_USER@$REMOTE_HOST "mv /tmp/s21_cat $REMOTE_DIR; mv /tmp/s21_grep $REMOTE_DIR"

# Проверка на наличие ошибок при перемещении
if [ $? -ne 0 ]; then
	    echo "Ошибка при перемещении файлов"
	        exit 1
fi

# Сообщение об успешной операции
echo "Файлы успешно скопированы/перемещены"

