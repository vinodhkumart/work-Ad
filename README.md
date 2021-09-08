# Scenario 1:
Please write a simple CLI application in the language of your choice that does the following:

- Print the numbers from 1 to 10 in random order to the terminal.
- Please provide a README that explains in detail how to run the program on
MacOS and Linux.

##Solution:
----------------------------------------------------------------------------------------
I wrote the script to generate random numbers in both bash and python.

##Prerequisites:

- core-utils package to be installed  for shuf (Note: Sort command can be used as well without shuf)
- python package to execute python scripts

##### For Linux #####
---------------------
## Steps to execute the shell scripts##

     git clone https://github.com/vinodhkumart/work-Ad.git
     cd  work-Ad
     chmod +x random.sh
     ./random.sh

##output##

    [ec2-user@myworks work-Ad]$ ./random.sh
    1 4 10 9 7 3 6 8 2 5

## Steps to execute the python script

     git clone https://github.com/vinodhkumart/work-Ad.git
     cd  work-Ad
     python ran.py

##output##

    [ec2-user@myworks work-Ad]$ python ran.py
    [4, 1, 2, 3, 5, 0, 8, 7, 9, 6]

##### For MACOS ##### (Note: This can be used for Linux as well)
---------------------

    git clone https://github.com/vinodhkumart/work-Ad.git
    cd  work-Ad
    chmod +x mac.sh
    ./mac.sh

##output##

    bash-3.2$work-Ad]$ ./mac.sh
    2
    5
    6
    3
    1
    10
    9
    4
    8
    7

# Scenario 2 Solution:
----------------------------------------------------------------------------------------------------------
I prefer using the promethues, Grafana and Alert Manger as a open source monitoring soltuon for this specific scenario. Along with Prometheus/Grafana, I would like to use ELK stack with APM integrated for the purpose of distributed tracing.

Enterprise version: Datadog will be one of the good option.

when I think of SSL offloading, first thing that comes to mind is Performance metrics. I would like to use TSDB based monitoring tool i.e promethues to collect the performance metrics. This is one of the best white box monitoring that wil be used to scrape the metrics.


#How I do :

#  Lets take, I had already configured Prometheus servers already in place or configured newly

##First Monitor: Local Resources based(Node-exporter) - CPU,MEM,DISK etc


- First, configure the server as Target on prometheus server ( edit the prometheus.yaml file with required details)
- Download the node exporter to the server (mostly to /usr/local/bin)
- Create a custom node exporter service in systemd
- Start the node exporter
- curl to prometheus server to check the metrics

Once the metrics added, Add best suited grafana metrics to monitor the services


# Metrics to watchout

- CPU monitoring - CPU stats for user,syste and IO
- Memory monitoring - Mem stats
- Disk stats specially I/O metrics  & Disk usage

# Example: Listed few but there are lot of metrics exists 

node_cpu_seconds_total
node_load1
node_cpu{mode="iowait","instance=ssl.example.com"}
node_disk_io_now
node_disk_read_bytes_total
node_disk_read_time_seconds_total
node_disk_written_bytes_total
node_disk_writes_completed_total
node_filesystem_avail_bytes
node_filesystem_device_error
node_filesystem_free_bytes
node_load
node_memory_MemTotal_bytes
node_memory_MemFree_bytes
node_memory_Mapped_bytes


##Second Monitor: Proxy server based Metrics based on different tools like haproxy,nginx,F5 etc as They do have different exporters available 

#HTTP: (Source: https://prometheus.io/docs/instrumenting/exporters/)
HAProxy exporter (official)
Nginx metric library
Nginx VTS exporter
Other LB exporters(Enterprise)

# How I do:

Specific exporter  service scrapes the proxy server stats and export them via HTTP for prometheus consumption.

- First, configure the server as Target on prometheus server ( edit the prometheus.yaml file with required details)
- Download the  proxy exporter to the server (mostly to /usr/local/bin)
- Create a custom proxy exporter service in systemd
- Start the proxy exporter
- curl to prometheus server to check the metrics


Once the metrics added, Add best suited grafana metrics to monitor the services.

# Metrics to watchout

- Frotend/Backend
- Traffic related - Inbound/Outbound
- Connections - Open/closed
- Round time trip - for tracking source and destination packet traffic details - Throughput
- HTTP errors(4xx, 5xx)
- HTTP codes (2xx, 3xx, 4xx, 5xx, other);

# Example: Listed few but there are lot of metrics exists

- process_start_time_seconds
- frontend_http_responses_total
- frontend_requests_denied_total
- frontend_request_errors_total
- frontend_bytes_in_total / frontend_bytes_out_total
- backend_http_responses_total
- backend_connection_errors_total
- http_connect_time_average_seconds
- http_queue_time_average_seconds

##Thid Monitor: ssl_exporter - ssl related

Depoy the ssl exporter in the server which can scrape the metrics related to SSL . Process will be same as above for installation and deployment.

## Metrics 

- sl_tls_connect_success
- ssl_cert_not_after
- probe_ssl_earliest_cert_expiry-time
- probe_http_status_code

## Network monitor

Wireshark to analyze tcpdump

##CHALLENGES of monitoring

- Identify which types of Ciphers used and which version of TLS being used
- Collect metrics like connected via TLS1.1 but tried to send data using TLS1.2 cryptography will triggeer some confusion kind of attacks
- decryption difficult - Monitoring might fail to read which type of http requests 
- Key sizes of requests
- external facing monitoring applications
- Limitations of scraping metrics based on the exporters we use.
