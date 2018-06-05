module Bot
  module Notable
    def start_note
      note
      to_librarian
    end

    def note
      @note ||= Memo.new(body: '')
    end

    def librarian?
      mode == 'librarian'
    end

    def add_note(text)
      @note.body += text
    end

    def save_note!
      note.save!
      @note = nil
      to_bot
    end

    def last_note
      notes.last
    end
  end
end
