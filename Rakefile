require "fileutils"
require "pty"

IMAGES = Dir["*/Dockerfile"].map { |f| f.split("/").first }

task :build do
  IMAGES.each do |img|
    sys "docker build -t #{img} docker/#{img}/"
  end
end

task :start do
  deployer = sys("docker run -d -p 2222:22 deployer").chomp
  serf_ip = sys("docker inspect #{deployer} | grep IPAddress", stdout: false).chomp
  serf_ip.gsub!(/[^\d\.]/,'')
  env = "-e SERF_HOST=#{serf_ip}"

  apps = 5.times.map do
    sys "docker run -d -p 80 #{env} app"
  end

  # load_balancer = sys "docker run -d :80 #{env} load_balancer", stdout: true
end

task :stop do
  sys "docker kill $(docker ps -q)", stdout: false
end

task :clean => :stop do
  sys "docker rm $(docker ps -a -q)", stdout: false
end

task default: :start

def sys cmd, options = {}
  out = ""
  # puts cmd
  puts_stdout = options.fetch :stdout, true

  PTY.spawn(cmd) do |stdout, stdin, pid|
    begin
      stdout.each do |line|
        puts line if puts_stdout
        out << line
      end
    rescue Errno::EIO
    end
  end

  out
rescue PTY::ChildExited
end
