From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] pwm: Add new helper to initialize a pwm_state
 variable with defaults
Date: Wed, 14 Nov 2018 13:32:36 +0100
Message-ID: <20181114123236.GG2620@ulmo>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7572663023398216659=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>, Krzysztof Kozlowski <krzk@kernel.org>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org


--===============7572663023398216659==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eVzOFob/8UvintSX"
Content-Disposition: inline


--eVzOFob/8UvintSX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2018 at 08:41:55PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> This helps to convert drivers from the legacy API to pwm_apply_state with=
out
> having to make the aware of the configured polarity (and in some cases ev=
en
> period).
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  include/linux/pwm.h | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

So if I understand your intention correctly here you want consumers to
be able to get at the default state, which would be the state as it was
"configured" in DT or the PWM lookup table so that you can modify that
state (well, really just setting the duty-cycle) before you actually
send the state to the hardware.

So the difference to pwm_apply_args() is that you don't want the driver
to specifically program a duty cycle of 0 before setting the actual duty
cycle that you want to set.

Is that about right?

Isn't that exactly what pwm_init_state() already does? pwm-backlight
uses it for exactly the same purpose that you seem to be using it in
RX1950 backlight control.

Thierry

--eVzOFob/8UvintSX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvsFeAACgkQ3SOs138+
s6GzZhAAhT75uRCxTxj8Doe5KWWZe6+n4DsyDFq8oXb5oNJuN1Zr6B4v1oFEGQcE
1R5M+Umf5RtCBGUBt30g+h/jMGP/nL7wA7H++U7n0jDdvakLrJ+ZH3yH2AQVPPtd
adF8wB6fGFNEEQZPRvygcq/kVxzXn/i9VTxLGK9Pgk8Bkf36uguZCoRFu/1SJ5lU
uP4nmZnR9fMjcAkrYdvQkkwcrOWEeYRNL4m81EB26DXe+oIx2q89Sz0e2zBMNOAZ
EZXO6JI4Nkii/C4UG7hlrKC/1n5lrvrwlU9YPSSNELLr2IAWzUGjWAhijAn7qKoo
lNM4i7OfGcCHGTxFRmAFQ6KC5SIkZcuX/UeIq6p2Z8rUvKZGmtOTob1ryuT+tyH1
ZnOLjUX+Tq368EAsG361ThHzK5ZoAHGyTELcaFicArOc0YO/ulmKjVN66HsVbu6v
NOX7/gKNotVtr9W7Me2YUFVHpb5FN/dsDBUIE+aVhxJ9XspwHZGlqap8SZVlpmmH
qh2EhU7xy4YOFV0oxN5HtxfRzz4mjrZV2j8KGK2JmdlvoBwAEPS3pjRnGdymbqe2
MPchRYYhZUcsqq31U+A2fD39S7WhBvSeTxYSlT3ojNu4vS7ACVNWpl5/s9qo5OrI
WSzEwZkBSanoUjKCy46P5WZlPF6g/oYW9h2q+H09dL5x2h37aGg=
=alf6
-----END PGP SIGNATURE-----

--eVzOFob/8UvintSX--


--===============7572663023398216659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7572663023398216659==--
