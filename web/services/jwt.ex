defmodule PhoAuth.Jwt do

  def encode(:hmac, payload_params \\ %{}, secret) do
    h = Poison.encode!(%{alg: "HS256", typ: "JWT"})
    p = Poison.encode!(payload_params)
    h64 = base_encode(h)
    p64 = base_encode(p)
    enc = base_encode(:crypto.hmac(:sha256, secret, "#{h64}.#{p64}"))
    "#{h64}.#{p64}.#{enc}"
  end

  defp base_encode(data), do: Base.url_encode64(data, [padding: false])
end
