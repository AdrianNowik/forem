module Forem
  class NilUser
    def forem_email
      "nobody@example.com"
    end

    def forem_name
      "[#{I18n.t('general.nil_user')}]"
    end
  end
end
