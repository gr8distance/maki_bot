module Bot
  module Status
    def self.included(base)
      base.class_eval do
        @@status.each do |state|
          # NOTE: 現在の状態を確認するメソッド
          def define_bot_status_changer
            define_method "#{state}?".to_sym do
              @state == state
            end
          end

          # NOTE: 現在の状態を変更するメソッド
          def define_bot_status_updater
            define_method "to_#{state}".to_sym do
              @state = state
            end
          end
        end
      end
    end
  end
end
