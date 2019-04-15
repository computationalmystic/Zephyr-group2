# Lashaen-Server-Software-Engineering

This is the Lashaen Server files for zephyr's LWM2M client demo.

Feel free to ask any questions on how to make set up the server or make modifications.  
I will try and help the best I can.

## How To Run Test Environment
### Requirements
1. [Zephyr Environment](https://docs.zephyrproject.org/latest/getting_started/index.html)
2. [Zephyr Net Tools](https://github.com/zephyrproject-rtos/net-tools)
3. Linux Host

### Getting Zephyr Net-Tools
````
git clone https://github.com/zephyrproject-rtos/net-tools
cd net-tools
make
````

### Setting Up QEMU with Net-Tools
1. Open 3 terminals

2. In terminal 1 navigate to your net-tools directory and run  
  ````./loop-socat.sh````
  
3. In terminal 1 navigate to your net-tools directory and run  
  ````sudo ./loop-slip-tap.sh````
  
4. In terminal 3 set up your zephyr environment.  
    * Go to your zephyr directory and run  
      ````source zephyr-env.sh````
      
5. From the zephyr directory go to samples/net/lwm2m_client  
  ````cd samples/net/lwm2m_client````
  
6. Build the lwm2m_client sample  
  ````west build -b qemu_x86````

7.Run the lwm2m_client sample
  ````west build -t run````
  
**NOTE: This set up will work for other applications as well just change samples/net/lwm2m_client to app directory

### Running Leashan Server
#### Option 1 (Recommended)
````
wget https://hudson.eclipse.org/leshan/job/leshan/lastSuccessfulBuild/artifact/leshan-server-demo.jar
java -jar ./leshan-server-demo.jar
````
To check that it is running properly go to http://localhost:8080
#### Option 2
**Note: I have not tested this way yet. However it is posted [here](https://github.com/eclipse/leshan/blob/master/README.md) as an option

1. Get the server files off of git

2. Compile
  ````mvn clean install````

3. Run  
  ````java -jar leshan-server-demo/target/leshan-server-demo-*-SNAPSHOT-jar-with-dependencies.jar ````

To check that it is running properly go to http://localhost:8080
