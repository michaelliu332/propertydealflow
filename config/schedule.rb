set :environment, 'development'
job_type :runner,  "cd :path && rails runner -e :environment ':task' :output"

every 1.minute do
  runner "Puller.run"
end