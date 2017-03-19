defmodule PhoAuth.JwtTest do
  use ExUnit.Case
  alias PhoAuth.Jwt

  test "can encode HMAC SHA256 jwt token" do
    # be warned
    # that keys can change order when encoding to JSON
    # which will change the result below
    jwt = Jwt.encode(:hmac, %{sub: "1234567890", name: "John Doe", admin: true}, "secret")
    assert jwt == "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.pcHcZspUvuiqIPVB_i_qmcvCJv63KLUgIAKIlXI1gY8"
  end
end
