# Use this file to easily define all of your cron jobs.
#
# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#

set :output, "log/cron.log"
set :environment, "development"

every :hour do
    runner "UnipileAutomationJob.perform_now(account_id, email_params, linkedin_message_params, linkedin_connection_params)"
end

# Learn more: http://github.com/javan/whenever