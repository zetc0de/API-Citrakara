class Message < ApplicationRecord
    
    after_create_commit {notify}
    
    private

    def notify
        Notification.create(event: "there's new message for you")
    end
    
end
