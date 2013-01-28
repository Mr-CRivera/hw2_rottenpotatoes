desc 'Detiene y arranca el servidor de WEBrick'

task :stopserver do  #Detiene el servidor
  pid_file = 'tmp/pids/server.pid'
  if File.file?(pid_file)
    print "...deteniendo el servidor de WEBrick con kill\n\n"
    pid = File.read(pid_file).to_i
    Process.kill "INT", pid
  end #if
  File.file?(pid_file) && File.delete(pid_file)
end #stopserver


task :startserver do #Arranca el servidor
  print "...arrancando el servidor WEBrick detached con 'rails server -d'\n\n"
  exec "rails server -d"
end #startserver

