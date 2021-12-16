
l: 	#log
	@echo $(shell sar -u 5 | awk '{ print $$1" "$$3 }' > cpu.log 2>&1 &)
	@echo $(shell sar -r 5 | awk '{ print $$1" "$$4 }' > memory.log 2>&1 &)
	
k:	#stop
	pkill -SIGINT sar
	sleep 4

div=1024

o:	
	tail -1 cpu.log
	@echo -e 'tail -1 memory.log\nAverage: ' 
	@sum= expr $(shell tail -1 memory.log | awk '{print $$2}') \/ $(div)

p: k o
