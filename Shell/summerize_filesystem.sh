#!/bin/sh

skip_file=('.' '..' '//proc' '//dev' '//tmp' '//sys' '//run')

log_file_size() {
	ls -lh $1 | awk '{ \
			print "file " $5 " "$9 \
		}'
}

log_dir_size() {
	
	for dir in ${skip_file[*]}
	do
		if [ $1 == $dir ]; then
			return
		fi
	done
	
	echo "DIR " `du -sh $1`

	for file in `ls $1`
	do
		if [ -h "$1/$file" ];then
			#echo "skip link file"
			continue
		elif [ -d "$1/$file" ];then
			log_dir_size "$1/$file"
		else
			log_file_size "$1/$file"
		fi
	done
}

echo "start summerize total size of $1"

log_dir_size $1
