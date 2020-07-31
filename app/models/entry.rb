class Entry < ActiveRecord::Base
    belongs_to :user

    validates :category, presence: true
    validates :date, presence: true
    validates :rating, presence: true
    validates :content, presence: true 
    validates :contact, presence: true

    # format: { /(^(0?[1-9]|1[0-2])/(0?[1-9]|1[0-9]|2[0-9]|3[01])/\d{4}$/ }


end







# ^                              #Beginning of expression
# (                              #Beginning of "Month Group"
# 0?[1-9]|1[0-2]                 #Any value from 01-12 (with the leading zeroes being optional)
# )                              #End of "Month Group"
# /                              #An explicit '/' separator
# (                              #Beginning of "Day Group"
# 0?[1-9]|1[0-9]|2[0-9]|3[01]    #Any value from 01-31 (with leading zeroes being optional)
# )                              #End of "Day Group"
# /                              #An explicit '/' separator 
# \d{4}                          #Any four digit year 0000-9999
# $                              #End of expression