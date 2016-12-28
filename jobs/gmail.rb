require 'gmail'
require 'date'

def from(email)
    sender = email.message.from.first
    sender ? sender : 'No info available'
end

def subject(email)
    text = email.message.text_part
    if text
        content = text.subject.try(:strip)
        content ? content[0..25] : 'No subject'
    else
        'No subject'
    end
end

def message(email)
    if email.message.text_part
        msg = email.message.text_part.body.raw_source.try(:strip)
        msg ? msg.to_s.gsub('*', '').gsub('=20', ' ')[0..170] + '...' : 'No content'
    else
        'No content'
    end
end

def short_message(email)
    if email.message.text_part
        msg = email.message.text_part.body.raw_source.try(:strip)
        msg ? msg.to_s.gsub('*', '').gsub('=20', ' ')[0..20] + '...' : 'No content'
    else
        'No content'
    end
end
def email_list(list)
    list.map {|email| short_message(email)}
end

class Object
    def to_imap_date
        date = respond_to?(:utc) ? utc.to_s : to_s
        Date.parse(date).strftime('%d-%b-%Y')
    end
end

SCHEDULER.every '1m', first_in: 0 do |job|
    username = 'andrewcod749@gmail.com'
    password = 'iinvrqbfutbwzyid'
    gmail = Gmail.new(username, password)

    puts "Loading emails"
    emails = (gmail.inbox.emails(:unread, :after => Date.today - 5).reverse) [0..5]
    puts 'Done Loading emails'
    email = emails.first
    message = {
        from:    from(email),
        subject: subject(email),
        message: message(email)
    }
    l = email_list(emails)
    puts 'ayy'
    puts l
    send_event('gmail', gmail: message, items: l)
    gmail.logout
end
