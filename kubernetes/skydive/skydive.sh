#!/bin/bash
set -x

ip=`kubectl get endpoints skydive-analyzer -n skydive --template "{{(index ((index .subsets 0).addresses) 0).ip}}"`
pods=`kubectl get pods --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' -n nodejs-ex`




for p in ${pods}
do
	# *** kubectl cp is too slow ***
	#kubectl cp -n nodejs-ex -c compute skydive ${p}:/usr/bin/ 
	podIP=`kubectl get pods ${p} --template '{{.status.podIP}}' -n nodejs-ex`

	subnet=`echo ${podIP} | cut -d . -f 1-3`

	kubectl exec -it -n nodejs-ex -c compute ${p} -- ip link add dev veth0 type veth peer name veth1
	kubectl exec -it -n nodejs-ex -c compute ${p} -- ip link set mtu 1450 dev veth0
	kubectl exec -it -n nodejs-ex -c compute ${p} -- ip link set mtu 1450 dev veth1
	kubectl exec -it -n nodejs-ex -c compute ${p} -- ip link set veth0 master br1

	kubectl exec -it -n nodejs-ex -c compute ${p} -- ip link set veth0 up
	kubectl exec -it -n nodejs-ex -c compute ${p} -- ip link set veth1 up  

# ** NOTE ** This ip address could colide with another pod 
	kubectl exec -it -n nodejs-ex -c compute ${p} -- ip a add ${subnet}.222/24 dev veth1
	kubectl exec -it -n nodejs-ex -c compute ${p} -- ip r add default via ${subnet}.1 dev veth1 
	kubectl exec -it -n nodejs-ex -c compute ${p} -- ip r add 10.244.0.0/16 via ${subnet}.1 dev veth1
#kubectl exec -it -n nodejs-ex -c compute ${p} -- ip r add 10.244.1.0/24 dev veth1 src 10.244.1.11

	kubectl exec -it -n nodejs-ex -c compute ${p} -- chmod +x /usr/bin/skydive 
	kubectl exec -n nodejs-ex -c compute ${p} -- /bin/bash -c "SKYDIVE_ANALYZERS=${ip}:8082 nohup /usr/bin/skydive agent --listen=0.0.0.0:8081 1>/dev/null 2>/dev/null &"
done

