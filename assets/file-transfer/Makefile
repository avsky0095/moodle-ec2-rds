COMM1=$(shell TZ=Asia/Jakarta sar -u 5 | awk '{ print $$1" "$$3 }' > cpu.log 2>&1 &)
COMM2=$(shell TZ=Asia/Jakarta sar -r 5 | awk '{ print $$1" "$$4 }' > memory.log 2>&1 &)

l: 	#log
	@echo $(COMM1)
	@echo $(COMM2)
	
k:	#kill
	pkill -SIGINT sar

j:	#justsee_average
	tail -1 memory.log
	tail -1 cpu.log