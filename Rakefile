require "fileutils"

NUM_APPS = 5

task :build do
  %w( base deployer app haproxy ).each do |img|
    sh "docker build -t #{img} docker/#{img}/"
  end
end

task :run do
  serf_ports = "-p 7946/tcp -p 7946/udp"
  sh "docker run -d -p 2222:22 #{serf_ports} -name deployer deployer"

  NUM_APPS.times.each do |i|
    sh "docker run -d -p 80 #{serf_ports} -link deployer:deployer -name app#{i} app"
  end

  sh "docker run -d -p :80 -p 22 #{serf_ports} -link deployer:deployer -name haproxy haproxy"
end

task :start do
  sh "docker start deployer"
  sh "docker start haproxy"
  NUM_APPS.times.each do |i|
    sh "docker start app#{i}"
  end
end

task :stop do
  sh "docker kill $(docker ps -q)"
end

task :clean => :stop do
  sh "docker rm $(docker ps -a -q)"
end

task default: :start
