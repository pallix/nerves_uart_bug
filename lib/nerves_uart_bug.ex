defmodule NervesUartBug do
  @moduledoc """
  Documentation for NervesUartBug.
  """

  @doc """
  Hello world.

  ## Examples

      iex> NervesUartBug.hello
      :world

  """
  def bug do
    {:ok, serial} = Nerves.UART.start_link()
    :ok = Nerves.UART.open(serial, "tnt0", speed: 9600, active: false)
    Task.async(fn -> read_serial_line(serial) end)
  end

  def read_serial_line(serial) do
    case Nerves.UART.read(serial, 50) do
      {:error, err} -> raise Atom.to_string(err)
      {:ok, ""} -> {:timeout, ""}
      {:ok, data} -> IO.inspect(data)
    end
    read_serial_line(serial)
  end

end
