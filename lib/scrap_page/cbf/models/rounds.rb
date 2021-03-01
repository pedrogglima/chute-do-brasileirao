# frozen_string_literal: true

module ScrapPage
  class CBF
    module Models
      # This class scraps a component compose of divs, ul, li, span and img.
      #  that matches a array of strings. After found, it scrap the header & rows.
      # Public methods are:
      #   :rounds: returns [] of Round{:number, :matches[Match]}
      class Rounds
        class Round
          attr_accessor :number,
                        :matches

          def initialize(number, matches)
            @number = number
            @matches = matches || []
          end

          def to_h
            hash_round = {
              number: number,
              matches: []
            }

            matches.each do |match|
              hash_round[:matches] << match.to_h
            end

            hash_round
          end
        end

        class Match
          attr_accessor :opponents,
                        :id_match,
                        :updates,
                        :score,
                        :date,
                        :start_at,
                        :place

          def initialize
            @opponents = []
          end

          def team_score
            score.split(' ')[0].to_i if score
          end

          def opponent_score
            score.split(' ')[2].to_i if score
          end

          def full_date
            if date && start_at
              "#{date} #{start_at}"
            elsif date
              date
            end
          end

          def to_h
            {
              team: opponents[0],
              opponent: opponents[1],
              id_match: id_match,
              number_of_changes: updates,
              team_score: team_score,
              opponent_score: opponent_score,
              date: full_date,
              place: place
            }
          end
        end

        attr_accessor :rounds

        # @params document [Nokogiri::XML::Document]
        def initialize(document)
          @elem_rounds = document.css('div[data-slide-index]')

          @rounds = []
          scrap_rounds
        end

        # returns [] of hash<round>
        def to_h
          array_rounds = []

          rounds.each do |round|
            array_rounds << round.to_h
          end

          array_rounds
        end

        private

        # Each Round has many matches
        def scrap_rounds
          @elem_rounds.children.each do |round|
            next unless round.element?

            # Because index starts on Zero, we add 1 for matching with Rounds ID
            number = round.parent['data-slide-index'].to_i + 1

            round.children.each do |elem|
              next unless elem.element?

              # matches are found on <ul>
              if elem.name == 'ul'
                matches = scrap_matches(elem)
                @rounds << Round.new(number, matches) if number && matches
              end
            end
          end
        end

        def scrap_matches(matches)
          res = []

          matches.children.each do |match|
            next unless match.element?

            mat = Match.new
            # teams are extract from <img>
            opponents = match.css('img')
            # Matches are made by two team
            if opponents.length == 2
              opponents.each do |adver|
                next unless adver.element?

                mat.opponents << scrap_adversarios(adver)
              end
            else
              raise "wrong number of opponents founded: #{opponents.length}"
            end

            # (e.g Qua, 03/02/2021 16:00 -  Jogo: 336 )
            info = find_info(match)
            if info
              # (e.g Jogo: 336) - it's always set on matches
              mat.id_match = info[/Jogo: \d{1,3}$/i].gsub(/^Jogo: /, '')
              # (e.g 03/02/2021) - maybe undefined
              mat.date = info[%r{\d{2}/\d{2}/\d{2,4}}i]
              # (e.g 16:00) - maybe undefined
              mat.start_at = info[/\d{2}:\d{2}/i]
            end

            # Because of problem passing regex, couldn't turn the 5 methods in 1.
            #
            # (e.g 1 alteração) maybe undefined
            mat.updates = find_updates(match)
            # (e.g 16:00) can be found in two places, we take only the first.
            mat.start_at = find_start_at(match) unless mat.start_at
            # (e.g 1 x 1) can be undefined
            mat.score = find_score(match)
            # (e.g Vila Belmiro - Santos - SP) maybe undefined
            mat.place = find_place(match)

            res << mat
          end

          res
        end

        # teams are extract from <img>
        def scrap_adversarios(adversario)
          if adversario.key?('title') &&
             adversario['title'].match?(/^[a-záàâãéèêíïóôõöúç\s]+ - [a-z]{2}$/i)

            # Extract team's name (e.g Santos - SP => Santos)
            return adversario['title'][/^[a-záàâãéèêíïóôõöúç\s]{3,50}/i].strip
          end

          nil
        end

        # Because of problem passing regex, couldn't turn the 5 methods in 1.
        #
        # pass assertive Proc to depth_search
        def find_info(match)
          find = proc do |node|
            if node.text?
              formatted_text = node.text.strip
              unless formatted_text.empty?
                res = formatted_text.match?(
                  /Jogo: \d{1,3}$/i
                )
                next formatted_text if res
              end
            end
            nil
          end

          depth_search(match, find)
        end

        # Because of problem passing regex, couldn't turn the 5 methods in 1.
        #
        # pass assertive Proc to depth_search
        def find_updates(match)
          find = proc do |node|
            if node.text?
              formatted_text = node.text.strip
              unless formatted_text.empty?
                res = formatted_text.match?(
                  /\d{1} (ALTERAÇÃO|ALTERAÇÕES)$/i
                )
                next formatted_text if res
              end
            end
            nil
          end

          depth_search(match, find)
        end

        # Because of problem passing regex, couldn't turn the 5 methods in 1.
        #
        # pass assertive Proc to depth_search
        def find_start_at(match)
          find = proc do |node|
            if node.text?
              formatted_text = node.text.strip
              unless formatted_text.empty?
                res = formatted_text.match?(
                  /^\d{2}:\d{2}$/i
                )
                next formatted_text if res
              end
            end
            nil
          end

          depth_search(match, find)
        end

        # Because of problem passing regex, couldn't turn the 5 methods in 1.
        #
        # pass assertive Proc to depth_search
        def find_score(match)
          find = proc do |node|
            if node.text?
              formatted_text = node.text.strip
              unless formatted_text.empty?
                res = formatted_text.match?(
                  /^\d{1} x \d{1}$/i
                )
                next formatted_text if res
              end
            end
            nil
          end

          depth_search(match, find)
        end

        # Because of problem passing regex, couldn't turn the 4 methods in 1.
        #
        # pass assertive Proc to depth_search
        def find_place(match)
          find = proc do |node|
            if node.text?
              formatted_text = node.text.strip
              unless formatted_text.empty?
                res = formatted_text.match?(
                  /^[a-záàâãéèêíïóôõöúçñ\-\s]+ - [a-záàâãéèêíïóôõöúçñ\s\-]+ - [A-Z]{2}$/i
                )
                next formatted_text if res
              end
            end
            nil
          end

          depth_search(match, find)
        end

        # Search node's children and return first assertion matched.
        #  The assertion must be passed through a proc, and must return nil for #  false assertions and obj for true.
        #
        # @params node [Nokogiri::XML::Element] node to be searched
        # @params proc [Proc] to test assertion
        # @return [Object, nil] whatever obj the proc return. Nil if not found
        def depth_search(node, proc)
          res = nil
          counter = 0
          number_of_children = node.children.length

          while counter < number_of_children
            return res if res

            child = node.children[counter]
            res = proc.call(child)
            return res if res

            res = depth_search(child, proc)
            counter += 1
          end
          res
        end
      end
    end
  end
end
