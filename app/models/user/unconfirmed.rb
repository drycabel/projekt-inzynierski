class User::Unconfirmed < User
    def confirm
        morph(User::Confirmed)
    end

    def unconfirmed?
        true
    end
end