class User::New < User
    def unconfirm
        morph(User::Unconfirmed)
    end

    def new?
        true
    end

end