defmodule PhoAuth.Jwt do

  def header(:hmac), do: %{alg: "HS256", typ: "JWT"}

  def encode(:hmac, payload_params \\ %{}) do
    h = header(:hmac)
  end
end
