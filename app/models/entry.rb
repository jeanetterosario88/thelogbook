class Entry < ActiveRecord::Base
    belongs_to :user

    validates :category
        presence: true,

    validates :date
        presence: true,

    validates :rating
        presence: true, 

    validates :content
        presence: true, 

    validates :contact
        presence: true

end