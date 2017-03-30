defmodule PhoAuth.Jwt do

  def encode("HS256", payload_params \\ %{}, secret) do
    h = Poison.encode!(%{alg: "HS256", typ: "JWT"})
    p = Poison.encode!(payload_params)
    h64 = base_encode(h)
    p64 = base_encode(p)
    enc = base_encode(:crypto.hmac(:sha256, secret, "#{h64}.#{p64}"))
    {:ok, "#{h64}.#{p64}.#{enc}"}
  end

  def valid(token, secret) do
    [header64, body64, _] = String.split(token, ".", parts: 3)
    checked =
      with {:ok, header_bin} <- base_decode(header64),
      {:ok, body_bin} <- base_decode(body64),
      {:ok, header} <- Poison.decode(header_bin),
      {:ok, body} <- Poison.decode(body_bin),
      {:ok, cmp_token} <- encode(Map.get(header, "alg"), body, secret),
      true <- token == cmp_token,
      do: {:ok, %{header: header, body: body}}

    case checked do
      {:ok, _} -> checked
      _ -> {:error}
    end
  end

  defp base_encode(data), do: Base.url_encode64(data, [padding: false])
  defp base_decode(data), do: Base.url_decode64(data, [padding: false])
end
