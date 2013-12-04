module Pathfinding
  module Strategy
    class AStar
      attr_accessor :open_set, :closed_set

      def self.solve(maze)
        @closed_set = []
        f_score = {}
        g_score = {}
        start = maze.starting_location
        g_score[start] = 0
        @open_set = [start]
        f_score[start] = g_score[start] + heuristic_cost_estimate(start, maze.goal, maze)

        while !@open_set.empty?
          current = pick_lowest_score(@open_set)
          if current == maze.goal
            puts "Solution found."
            return reconstruct_path(current, maze)
          end
          @open_set.delete current
          @closed_set << current

          maze.neighbors_for(current).each do |n|
            tentative_g_score = g_score[current] + maze.distance_between(current, n)
            tentative_f_score = tentative_g_score + heuristic_cost_estimate(n, maze.goal, maze)
            if @closed_set.include?(n) && tentative_f_score >= f_score[n]
              next
            else
              maze.at(n.first, n.last).parent = current
              g_score[n] = tentative_g_score
              f_score[n] = tentative_f_score
              @open_set << n unless @open_set.include? n
            end
          end
        end
        puts "Failed to find a solution. @open_set is #{@open_set}, @closed_set is #{@closed_set}, fscores were: #{f_score}, gscores were: #{g_score}"
        raise "No route"
      end

      def self.reconstruct_path( node, maze )
        puts "Reconstructing path..."
        path = []
        cell = maze.at(node.first, node.last)
        path << cell
        while cell.parent != nil

          cell = maze.at(cell.parent.first, cell.parent.last)
          path << cell
        end
        path.reverse!
      end

      def self.pick_lowest_score(nodes)
        node = nodes.reduce do |n, (k,v)|
          if n && v < n.last then
            [k,v] 
          else
            n 
          end
        end
      end

      def self.heuristic_cost_estimate(pos, goal, maze)
        maze.distance_between(pos, goal)
      end

    end
  end
end
