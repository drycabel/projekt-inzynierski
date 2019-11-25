class User::Unconfirmed < User
    def confirm
        morph(User::Confirmed)
    end
end