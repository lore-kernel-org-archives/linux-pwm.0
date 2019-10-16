From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm-stm32: document pinctrl sleep
 state
Date: Wed, 16 Oct 2019 08:59:45 +0200
Message-ID: <20191016065945.GA1296874@ulmo>
References: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
 <1570193633-6600-2-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1570193633-6600-2-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: robh+dt@kernel.org, u.kleine-koenig@pengutronix.de, alexandre.torgue@st.com, mark.rutland@arm.com, mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, benjamin.gaignard@st.com, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2019 at 02:53:51PM +0200, Fabrice Gasnier wrote:
> Add documentation for pinctrl sleep state that can be used by
> STM32 timers PWM.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-stm32.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2mv98ACgkQ3SOs138+
s6HF3BAAmYT8qlTIl02DuYkZiIEEQt9hsB26Q0G5lb9hNoOoKx6lZQ+fH6rl2YGG
4qNTgV7tO6d2L3ip18Khcwjix/qAMIquiQS7X98cRjYA72kq3zwY5hj6pRxwF0Z5
qdY0aTeeN2YpT9rhOR0vjmMfVGDgds9wfCLZXvkYGJ1eIHlrWD7MTDBcQeResxLk
IGpnF6avlEnIlnaVKhUExslBOfivCtPho2GT8mXRQwR2UEjT2hQwJf+Sx98retQ9
C9rrKMP900bMgeyBzQ0AZbZk1/U6wW1yeJaIITR0wJFLN+Gg+FMS+lb/fhGYMKwu
9uQUNAYK03J0FUEZp8Esp1W36ua2XVlmEd+7meqo1OQXBG3uVPpIwTJrBmbPON7s
Q5wHH96B8zjwGdwaVXi/opEDrRezm5c3Ek2bE5cuKfE1grspT0TIqrxmfKnJjzEY
p12kGLnyp7UCaRV8EpUlVDo74koFoMtsCJMNB+PkeZfJEcpoAE1P+gJtt7mWzrXa
dH/ZR6ezffrGbHvH9xKqWLoYSBv1r6PbAiNTJLFCzfWUGBujwQut3bTMNJQoEC4Y
cYPLZnLDnw4Sv7tRoF3nlz3zI5RmQy6qQ0ycz/0CXNv1+W5LVgBa1izwHJ5g1Civ
+vcMdBtQEl6PC4APpHq3jfKFRnO/LOfYRuh8YFl0IwUa9dURl2Q=
=xIm6
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
