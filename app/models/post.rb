class Post < ApplicationRecord
    validates :content, presence: true
    belongs_to :user
    belongs_to :group
    #Rails 内建的一个API scope可以用来包装一些查询式，
    #可以直接在post_controller 中使用recent
    scope :recent, -> {order("created_at DESC")}
end
