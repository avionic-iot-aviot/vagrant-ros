# vagrant-ros

Copied from ArduPilot Vagrant.

Just vagrant up from the directory and vagrant ssh to get a ROS ready vagrant machine


# SSH Connection

From root dir

```
ssh -p 2222 -X -i .vagrant/machines/xenial64/virtualbox/private_key vagrant@127.0.0.1 
```

If you want to use `screen`
```
screen -d -R
```

# Run simulator

```
sim_vehicle.py --map --console -v ArduCopter
```

# Run Ros

```
roscore
```

# Run MAVRos

```
roslauch /home/vagrant/aviot/apm.launch
```