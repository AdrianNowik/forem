module Forem
  class NilUser
    def forem_email
      "nobody@example.com"
    end

    def forem_name
      "[#{t('general.nil_user')}]"
    end
  end
end
