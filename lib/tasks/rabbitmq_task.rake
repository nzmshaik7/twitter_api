# Custom rake task to implement RabbitMQ publisher and consumer modules



task :publish => :environment do
	TweetsReadsController
end


task :consume => :environment do
	WorkerJob.delay

end
