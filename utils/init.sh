#!/usr/bin/env bash

readonly BIN_GLOBAL=(
    "node"
    "npm"
    "python"
    "php"
    "pip"
    "mysql"
    "mysqld_safe"
    "mysql_install_db"
)

MYSQL_ADDR="127.0.0.1"
MYSQL_PORT="9876"
MYSQL_USER="root"
MYSQL_DATABASE="fuzzy_query"

PATH_ROOT=`dirname $0`/..
PATH_ROOT=`cd $PATH_ROOT;pwd`
DATA_ROOT=$PATH_ROOT/data

function check_bin() {
    local name="$1"
    local ret=`type $name 2>/dev/null >/dev/null && echo 0 || echo 1`
    if [ "$ret" = "0" ]; then
        return 0
    fi
    return 1
}

function entry_check_bin() {
    echo -e "\033[35m[CHECK BIN]\033[0m"
    for module in ${BIN_GLOBAL[*]}; do
        check_bin $module
        if [ "$?" = "0" ]; then
            echo -e "$module\t\t\033[32minstalled\033[0m"
        else
            is_env_fail=1
            echo -e "$module\t\t\033[31mnot found\033[0m"
        fi
    done
}

function entry_init_py() {
    echo -e "\033[35m[INIT PYTHON]\033[0m"
    check_bin "pip"
    if [ "$?" != "0" ]; then
        return
    fi
    pip list|grep numpy
    if [ "$?" != "0" ]; then
        echo "pip install numpy"
        pip install numpy
    fi
}

function entry_init_mysql() {
    echo -e "\033[35m[INIT MYSQL]\033[0m"
    check_bin "mysql_install_db"
    if [ "$?" != "0" ]; then
        return
    fi
    check_bin "mysql"
    if [ "$?" != "0" ]; then
        return
    fi
    check_bin "mysqld_safe"
    if [ "$?" != "0" ]; then
        return
    fi
    echo -e "\033[32m init mysql env \033[0m"
    mysqlDbDir=$DATA_ROOT/mysql
    mysqlCnfTpl=$DATA_ROOT/mysql.cnf
    mysqlCnfIns=$mysqlDbDir/cnf/mysql.cnf
    rm -rf $mysqlDbDir
    mkdir -p $mysqlDbDir/cnf $mysqlDbDir/data $mysqlDbDir/log $mysqlDbDir/var
    cp $mysqlCnfTpl $mysqlCnfIns
    mysqlBinPath=`which mysql`
    mysqlInstallPath=`dirname "$mysqlBinPath"`
    mysqlInstallPath=`cd "$mysqlInstallPath/..";pwd`
    mysqlDbDirSed="${mysqlDbDir//\//\\/}"
    mysqlInstallPathSed="${mysqlInstallPath//\//\\/}"
    sed -i "s/{mysql_db_dir}/$mysqlDbDirSed/g" $mysqlCnfIns
    sed -i "s/{mysql_install_path}/$mysqlInstallPathSed/g" $mysqlCnfIns
    sed -i "s/{mysql_port}/$MYSQL_PORT/g" $mysqlCnfIns

    echo -e "\033[32mexecute mysql_install_db \033[0m"
    mysql_install_db --defaults-file=$mysqlCnfIns --basedir=$mysqlInstallPath
    echo -e "\033[32mexecute mysqld_safe \033[0m"
    mysqld_safe --defaults-file=$mysqlCnfIns &
    echo -e "\033[32mwait for mysqld loaded \033[0m"
    sleep 5
    echo -e "\033[32mcreate database \033[0m"
    mysql -S $mysqlDbDir/var/mysqld.sock -u$MYSQL_USER -e "create database $MYSQL_DATABASE;"
    echo -e "\033[32mcreate table \033[0m"
    mysql -S $mysqlDbDir/var/mysqld.sock -u$MYSQL_USER -D$MYSQL_DATABASE -e 'CREATE TABLE `fuzzy_query` ( `noIndex` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL , `withIndex` VARCHAR(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL) ENGINE = InnoDB;'
    i=0
    vals=''
    echo -e "\033[32mstart insert data \033[0m"
    for line in `cat $DATA_ROOT/list`
    do
        if [ x"$vals" == x"" ]; then
            vals="('$line', '$line')"
        else
            vals=$vals",('$line', '$line')"
        fi
        i=$[$i + 1]
        if [ $(($i % 500)) == 0 ];then
            sql='INSERT INTO `fuzzy_query` (`noIndex`, `withIndex`) VALUES '"$vals;"
            mysql -S $mysqlDbDir/var/mysqld.sock -u$MYSQL_USER -D$MYSQL_DATABASE -e "$sql"
            echo -en "inserted $i\r"
            vals=''
        fi
    done
    if [ x"$vals" != x"" ]; then
        sql='INSERT INTO `fuzzy_query` (`noIndex`, `withIndex`) VALUES '"$vals;"
        mysql -S $mysqlDbDir/var/mysqld.sock -u$MYSQL_USER -D$MYSQL_DATABASE -e "$sql"
        echo -en "inserted $i\r"
    fi
    echo ""
    echo -e "\033[32madd index \033[0m"
    mysql -S $mysqlDbDir/var/mysqld.sock -u$MYSQL_USER -D$MYSQL_DATABASE -e 'ALTER TABLE `fuzzy_query` ADD INDEX `wd` (`withIndex`);';
    echo -e "\033[32mkill mysql \033[0m"
    kill `cat $mysqlDbDir/var/mysqld.pid`
}

function main() {
    entry_check_bin
    entry_init_py
    entry_init_mysql
}

main "$@"

exit $?