defmodule Ecto.Adapters.SQL.Query do
  @moduledoc """
  Specifies the behaviour to be implemented by the
  connection for handling all SQL queries.
  """

  use Behaviour

  @type result :: {:ok, %{rows: nil | [tuple], num_rows: non_neg_integer}} |
                  {:error, Exception.t}

  @doc """
  Executes the given query with params in connection.

  In case of success, it must return an `:ok` tuple containing
  a map with at least two keys:

    * `:num_rows` - the number of rows affected

    * `:rows` - the result set as a list. `nil` may be returned
      instead of the list if the command does not yield any row
      as result (but still yields the number of affected rows,
      like a `delete` command without returning would)
  """
  defcallback query(pid, query :: binary, params :: list(), opts :: Keyword.t) :: result

  ## Queries

  @doc """
  Receives a query and must return a SELECT query.
  """
  defcallback all(Ecto.Query.t) :: String.t

  @doc """
  Receives a query and values to update and must return an UPDATE query.
  """
  defcallback update_all(Ecto.Query.t) :: String.t

  @doc """
  Receives a query and must return a DELETE query.
  """
  defcallback delete_all(Ecto.Query.t) :: String.t

  @doc """
  Returns an INSERT for the given `fields` in `table` returning
  the given `returning`.
  """
  defcallback insert(prefix ::String.t, table :: String.t,
                     fields :: [atom], returning :: [atom]) :: String.t

  @doc """
  Returns an UPDATE for the given `fields` in `table` filtered by
  `filters` returning the given `returning`.
  """
  defcallback update(prefix :: String.t, table :: String.t, fields :: [atom],
                     filters :: [atom], returning :: [atom]) :: String.t

  @doc """
  Returns a DELETE for the `filters` returning the given `returning`.
  """
  defcallback delete(prefix :: String.t, table :: String.t,
                     filters :: [atom], returning :: [atom]) :: String.t

  ## DDL

  @doc """
  Receives a DDL command and returns a query that executes it.
  """
  defcallback execute_ddl(Ecto.Adapter.Migration.command) :: String.t

  ## Transaction

  @doc """
  Command to begin transaction.
  """
  defcallback begin_transaction :: String.t

  @doc """
  Command to rollback transaction.
  """
  defcallback rollback :: String.t

  @doc """
  Command to commit transaction.
  """
  defcallback commit :: String.t

  @doc """
  Command to emit savepoint.
  """
  defcallback savepoint(savepoint :: String.t) :: String.t

  @doc """
  Command to rollback to savepoint.
  """
  defcallback rollback_to_savepoint(savepoint :: String.t) :: String.t
end
