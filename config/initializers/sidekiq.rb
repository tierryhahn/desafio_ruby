Sidekiq.configure_server do |config|
    config.on(:startup) do
      schedule_file = "config/sidekiq.yml"
  
      if File.exist?(schedule_file)
        Sidekiq::Scheduler.reload_schedule!(YAML.load_file(schedule_file))
      end
    end
  end
  
  Sidekiq.configure_client do |config|

  end