class UnipileService
  API_BASE_URL = "https://api6.unipile.com:13646/api/v1"

  def initialize(user = nil)
    @user = user
  end

  def request_automation_link(email, otp_token)
    uri = URI("#{API_BASE_URL}/hosted/accounts/link")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request["Accept"] = "application/json"
    request["Content-Type"] = "application/json"
    request["X-API-KEY"] = "Fy+jNMsR.oPh59qIU9ukBmH6QROHfYjntPKkmB0e4xnPe9X4cqB8="

    request.body = {
      expiresOn: "2025-12-31T23:59:59.999Z",
      name: "UserAccountName",
      success_redirect_url: "https://example.com/success",
      failure_redirect_url: "https://example.com/failure",
      notify_url: "https://example.com/notify",
      disabled_features: ["linkedin_recruiter"],  
      api_url: "https://api6.unipile.com:13646",
      sync_limit: {
        MAILING: "NO_HISTORY_SYNC",
        MESSAGING: {
          chats: 100,
          messages: 50
        }
      },
      type: "create",
      providers: "*"
    }.to_json

    response = http.request(request)
    JSON.parse(response.body)
  end

  def start_linkedin_chat(account_id, text, attendees_ids, subject = nil, voice_message = nil, attachments = [])
    uri = URI("#{API_BASE_URL}/chats")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
  
    request = Net::HTTP::Post.new(uri.request_uri)
    request["Accept"] = "application/json"
    request["Content-Type"] = "application/json"
    request["X-API-KEY"] = "Fy+jNMsR.oPh59qIU9ukBmH6QROHfYjntPKkmB0e4xnPe9X4cqB8="
  
    body = {
      account_id: account_id,
      text: text,
      attendees_ids: attendees_ids,
      subject: subject,
      voice_message: voice_message,
      attachments: attachments
    }.compact
  
    request.body = body.to_json
    response = http.request(request)
    JSON.parse(response.body)
  end

  def send_chat_message(chat_id, text, thread_id = nil)
    uri = URI("#{API_BASE_URL}/chats/#{chat_id}/messages")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request["Accept"] = "application/json"
    request["Content-Type"] = "application/json"
    request["X-API-KEY"] = "Fy+jNMsR.oPh59qIU9ukBmH6QROHfYjntPKkmB0e4xnPe9X4cqB8="

    body = {
      text: text,
      thread_id: thread_id
    }.compact

    request.body = body.to_json
    response = http.request(request)
    JSON.parse(response.body)
  end

  def send_email(account_id, from, to, subject, body, cc = [], bcc = [], reply_to = nil, custom_headers = [], tracking_options = {}, attachments = [])
    uri = URI("#{API_BASE_URL}/emails")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    
    request = Net::HTTP::Post.new(uri.request_uri)
    request["Accept"] = "application/json"
    request["Content-Type"] = "application/json"
    request["X-API-KEY"] = "Fy+jNMsR.oPh59qIU9ukBmH6QROHfYjntPKkmB0e4xnPe9X4cqB8="
    
    request.body = {
      account_id: account_id,
      from: from,
      to: to,
      subject: subject,
      body: body,
      cc: cc,
      bcc: bcc,
      reply_to: reply_to.nil? ? "" : reply_to,
      custom_headers: custom_headers,
      tracking_options: tracking_options,
      attachments: attachments
    }.to_json
    
    response = http.request(request)
    JSON.parse(response.body)
  end

  def list_attendees
    uri = URI("#{API_BASE_URL}/chat_attendees")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.request_uri)
    request["Accept"] = "application/json"
    request["X-API-KEY"] = "Fy+jNMsR.oPh59qIU9ukBmH6QROHfYjntPKkmB0e4xnPe9X4cqB8="

    response = http.request(request)
    JSON.parse(response.body)
  end

  def list_chats
    uri = URI("#{API_BASE_URL}/chats")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.request_uri)
    request["Accept"] = "application/json"
    request["X-API-KEY"] = "Fy+jNMsR.oPh59qIU9ukBmH6QROHfYjntPKkmB0e4xnPe9X4cqB8="

    response = http.request(request)
    JSON.parse(response.body)
  end

  def create_linkedin_connections(cursor, limit, account_id)
    uri = URI("#{API_BASE_URL}/users/relations?cursor=#{cursor}&limit=#{limit}&account_id=#{account_id}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.request_uri)
    request["Accept"] = "application/json"
    request["X-API-KEY"] = ENV['UNIPILE_API_KEY']

    response = http.request(request)
    JSON.parse(response.body)
  end
end