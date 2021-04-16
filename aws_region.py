#!/usr/bin/python

from ipaddress import ip_network, ip_address
import json
import argparse

parser = argparse.ArgumentParser(description='Get AWS region from IP')
parser.add_argument('ip', help='IP address of URL')
args = parser.parse_args()

def find_aws_region(ip):
  ip_json = json.load(open('/home/klarsen/Pentesting/tools/takeover/ip-ranges.json'))
  prefixes = ip_json['prefixes']
  my_ip = ip_address(ip)
  region = 'Unknown'
  for prefix in prefixes:
    if my_ip in ip_network(prefix['ip_prefix']):
      region = prefix['region']
      break
  return region

print(find_aws_region(args.ip))
