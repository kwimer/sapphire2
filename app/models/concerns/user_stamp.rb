module UserStamp
  extend ActiveSupport::Concern

  module ClassMethods
    def user_stamp(model = :user)
      send :belongs_to, model, class_name: 'User', optional: true
      send :before_validation, :"set_#{model}_stamp", on: :create

      define_method "set_#{model}_stamp" do
        self.send :"#{model}=", User.current unless send(model)
      end
    end
  end

end
