require IEx

defmodule Numbers.Engine do
  @moduledoc """
  Functions for playing the numbers hand game.

  Rules:
  Each player starts with 1 of 5 possible fingers up on each hand.
  On each turn, one player gives the number of up fingers on one hand to one of the other player's hands.
  If a hand has exactly 5 fingers up, all are knocked down.
  If a hand plus the given fingers is more than 5, the new number is old + added mod 5
  If a player has an even number of fingers on one hand, and no fingers on the other hand,
  they may use their turn to split their fingers evenly.
  The goal is to knock both the other player's hands to 0.
  """

  @player %{left: 1, right: 1}
  @players %{1 => @player, 2 => @player}

  @doc """
  Play a game of Chopsticks, passing in the number of turns and function to get the move.
  """
  def play(turns, get_move, get_move_2 \\ nil) do
    turn(turns, 1, @players, get_move, get_move_2 || get_move)
  end

  def turn(turns_left, player_number, players, get_move, get_move_2) do
    p1 = players[1]
    p2 = players[2]
    current_player = players[player_number]

    cond do
      turns_left == 0 ->
        0
      lost?(p1) ->
        2
      lost?(p2) ->
        1
      true ->
        {player_direction, opponent_direction} = get_move.(player_number, players)

        next_number = next_player_number(player_number)
        next_player = players[next_number]

        updated_players =
          %{}
          |> Map.put(player_number, current_player)
          |> Map.put(
            next_number,
            add_to_hand(next_player, opponent_direction, current_player[player_direction])
          )

        turn(turns_left - 1, next_number, updated_players, get_move_2, get_move)
    end
  end

  def next_player_number(1), do: 2
  def next_player_number(2), do: 1

  def add_to_hand(player, direction, add_count) do
    {_, player} = Map.get_and_update!(player, direction, fn
      hand_count ->
        {hand_count, add_fingers(hand_count, add_count)}
    end)

    player
  end

  def add_fingers(hand_count, add_count) do
    new_count = hand_count + add_count

    cond do
      new_count > 5 -> new_count - 5
      new_count === 5 -> 0
      true -> new_count
    end
  end

  def lost?(player) do
    player.left === 0 && player.right === 0
  end
end
