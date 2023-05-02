require 'dotenv/load'
require 'json'
require 'net/http'

SUCCESS = 200
PROCESSING = 102
FAILED = 400
INVALID_NUMBER = 160
MESSAGE_IS_EMPTY = 170
SMS_NOT_FOUND = 404
SMS_SERVICE_NOT_TURNED = 600

ESKIZ_EMAIL = ENV['ESKIZ_EMAIL']
ESKIZ_PASSWORD = ENV['ESKIZ_PASSWORD']

class SendSmsApiWithEskiz
  def initialize(message, phone, email=ESKIZ_EMAIL, password=ESKIZ_PASSWORD)    @message = message
    @phone = phone
    @spend = nil
    @email = email
    @password = password
  end

  def send
    status_code = custom_validation
    return status_code unless status_code == SUCCESS

    result = calculation_send_sms(@message)
    result == SUCCESS ? send_message(@message) : result
  end

  def custom_validation
    return INVALID_NUMBER if @phone.to_s.size != 9
    return MESSAGE_IS_EMPTY if @message.nil? || @message.empty?

    @message = clean_message(@message)
    SUCCESS
  end

  def authorization
    uri = URI('http://notify.eskiz.uz/api/auth/login')
    res = Net::HTTP.post_form(uri, 'email' => @email, 'password' => @password)
    res_json = JSON.parse(res.body)
    return FAILED unless res_json['data'] && res_json['data']['token']

    res_json['data']['token']
  end

  def send_message(message)
    token = authorization
    return FAILED if token == FAILED
  
    uri = URI('http://notify.eskiz.uz/api/message/sms/send')
    payload = {
      'mobile_phone': '998' + @phone.to_s,
      'message': message,
      'from': '4546',
      'callback_url': 'http://afbaf9e5a0a6.ngrok.io/sms-api-result/'
    }
  
    headers = { 'Authorization': "Bearer #{token}" }
    req = Net::HTTP::Post.new(uri, headers)
    req.set_form_data(payload)
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    puts "Eskiz: #{JSON.parse(res.body)}"
    res.code.to_i
  end
  

  def get_status(id)
    token = authorization
  
    uri = URI("http://notify.eskiz.uz/api/message/sms/status/#{id}")
    headers = { 'Authorization': "Bearer #{token}" }
    res = Net::HTTP.get(uri, headers)
    res_json = JSON.parse(res.body)
  
    if res_json['status'] == 'success'
      if %w[DELIVRD TRANSMTD].include?(res_json['message']['status'])
        return SUCCESS
      elsif res_json['message']['status'] == 'EXPIRED'
        return FAILED
      else
        return PROCESSING
      end
    else
      return FAILED
    end
  end

  def clean_message(message)
    puts "Old message: #{message}"
    message.gsub('ц', 'ts').gsub('ч', 'ch').gsub('ю', 'yu').gsub('а', 'a').gsub('б', 'b').gsub('қ', 'q').gsub('ў', "o'").gsub('ғ', "g'").gsub('ҳ', 'h').gsub('х', 'x').gsub('в', 'v').gsub('г', 'g').gsub('д', 'd').gsub('е', 'e').gsub('ё', 'yo').gsub('ж', 'j').gsub('з', 'z').gsub('и', '
        i').gsub('й', 'y').gsub('к', 'k').gsub('л', 'l').gsub('м', 'm').gsub('н', 'n').gsub('о', 'o').gsub('п', 'p').gsub('р', 'r').gsub('с', 's').gsub('т', 't').gsub('у', 'u').gsub('ф', 'f').gsub('ҳ', 'h').gsub('ҷ', 'j').gsub('ш', 'sh').gsub('Я', 'YA').gsub('а', 'a').gsub('б', 'b').gsub('в', 'v').gsub('г', 'g').gsub('д', 'd').gsub('е', 'e').gsub('ё', 'yo').gsub('ж', 'j').gsub('з', 'z').gsub('и', 'i').gsub('й', 'y').gsub('к', 'k').gsub('л', 'l').gsub('м', 'm').gsub('н', 'n').gsub('о', 'o').gsub('п', 'p').gsub('р', 'r').gsub('с', 's').gsub('т', 't').gsub('у', 'u').gsub('ф', 'f').gsub('х', 'h').gsub('ц', 'ts').gsub('ч', 'ch').gsub('ш', 'sh').gsub('щ', 'sch').gsub('ъ', '').gsub('ь', '').gsub('ы', 'y').gsub('э', 'e').gsub('ю', 'yu').gsub('я', 'ya').gsub('А', 'A').gsub('Б', 'B').gsub('В', 'V').gsub('Г', 'G').gsub('Д', 'D').gsub('Е', 'E').gsub('Ё', 'YO').gsub('Ж', 'J').gsub('З', 'Z').gsub('И', 'I').gsub('Й', 'Y').gsub('К', 'K').gsub('Л', 'L').gsub('М', 'M').gsub('Н', 'N').gsub('О', 'O').gsub('П', 'P').gsub('Р', 'R').gsub('С', 'S').gsub('Т', 'T').gsub('У', 'U').gsub('Ф', 'F').gsub('Х', 'H').gsub('Ц', 'TS').gsub('Ч', 'CH').gsub('Ш', 'SH').gsub('Щ', 'SCH').gsub('Ъ', '').gsub('Ь', '').gsub('Ы', 'Y').gsub('Э', 'E').gsub('Ю', 'YU').gsub('Я', 'YA')
    end
    
    def calculation_send_sms(message)
    message_length = message.length
    message_length += 13 if message_length > 70
    @spend = message_length * 80 # price per 1 character in Uzbek sum
SUCCESS
end
end

msg = 'Hello from Azizdev!'
phone_number = '99xxxxxxx' # raqam faqat operator kodi bilan boshlanishi kerak masalan: 991903704, 931903704
sms = SendSmsApiWithEskiz.new(msg, phone_number)
sms.send
