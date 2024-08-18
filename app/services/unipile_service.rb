class UnipileService
  API_BASE_URL = "https://api6.unipile.com:13646/api/v1"

  def initialize(user)
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

  def send_linkedin_message(account_id, text, attendees_ids, subject = nil, voice_message = nil)
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
      attendees_ids: attendees_ids
    }
    body[:subject] = subject if subject
    body[:voice_message] = voice_message if voice_message

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
end