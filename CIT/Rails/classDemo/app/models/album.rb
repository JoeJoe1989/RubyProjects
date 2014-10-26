# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  price      :float
#  release    :date
#  created_at :datetime
#  updated_at :datetime
#

class Album < ActiveRecord::Base
end
