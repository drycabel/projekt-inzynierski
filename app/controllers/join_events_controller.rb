class JoinEventsController < ApplicationController
    def create
        # binding.pry
        # warunek ktory sprawdza czy dana osoba nie jest juz zjoinowana lub nie jest ownerem
        # czy chce uczestniczyc w dwoch eventach w tym samym czasie
        # jezli ok => stworz membership
        # przenisc join do karty
        # w show info o evencie
        service = EventJoiner.new(current_user, params[:event_id])
        if service.joined_successfully?
            redirect_to event_path(service.event), notice: service.msg
        else
            redirect_to events_path, alert: service.msg
        end
    end


end