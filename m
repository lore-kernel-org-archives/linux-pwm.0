From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: berlin: Don't use broken prescaler values
Date: Mon, 9 Jul 2018 18:57:24 +0200
Message-ID: <20180709165724.GB26651@ulmo>
References: <a4e1449967f3dbc95770b9ac2bbc1fd116e3cac7.1528306926.git.tommyhebb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a4e1449967f3dbc95770b9ac2bbc1fd116e3cac7.1528306926.git.tommyhebb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Hebb <tommyhebb@gmail.com>
Cc: linux-kernel@vger.kernel.org, Antoine Tenart <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, Jisheng.Zhang@synaptics.com, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 01:42:10PM -0400, Thomas Hebb wrote:
> The Berlin PWM driver is currently broken on at least BG2CD. The
> symptoms manifest as a very non-linear and erratic mapping from the duty
> cycle configured in software to the duty cycle produced by hardware.
>=20
> The cause of the bug is software's configuration of the prescaler, and
> in particular its usage of the six prescaler values between the minimum
> value of 1 and the maximum value of 4096. As it turns out, these six
> values do not actually slow down the PWM clock; rather, they emulate
> slowing down the clock by internally multiplying the value of TCNT.
>=20
> This would be a fine trick, if not for the fact that the internal,
> scaled TCNT value has no extra bits beyond the 16 already exposed to
> software in the register. What this means is that, for a prescaler of 4,
> the software must ensure that the top two bits of TCNT are not set,
> because hardware will chop them off; for a prescaler of 8, the top three
> bits must not be set, and so forth. Software does not currently ensure
> this, resulting in a TCNT several orders of magnitude lower than
> intended any time one of those six prescalers are selected.
>=20
> Because hardware chops off the high bits in its internal shift, the
> middle six prescalers don't actually allow *anything* that the first
> doesn't. In fact, they are strictly worse than the first, since the
> internal shift of TCNT prevents software from setting the low bits,
> decreasing the resolution, without providing any extra high bits.
>=20
> By skipping the useless prescalers entirely, this patch both fixes the
> driver's behavior and increases its performance (since, when the 4096
> prescaler is selected, it now does only a single shift rather than the
> seven successive divisions it did before).
>=20
> Tested on BG2CD.
>=20
> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
> ---
>  drivers/pwm/pwm-berlin.c | 45 ++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)

Applied, thanks.

Thierry

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDk/QACgkQ3SOs138+
s6GzSg/+JeatRGdrJmsErClcFd4iadL/LxRhrcxR+qX12x/xu1eaVmqdxhTIUDW/
BD2ZwnNIeTs8cDsBEgc2M2Y3+40Qc5XKY6sk/IHHHI4Dkid0dW6PAK+fwpE+nyY+
9UAg2oVG7e5NO7T93SDF4iZdUFYMFve1EHPdayacf+BaLSAHfQSTfNq9EPgShIqq
f9xSNXheIW20D26NNjVxFqXAQzxXDO4+tTNHZC8qyTr9Eulk0MZCjkBzh49COeCw
fpumSqUrohGkBu6RkEgjAYwsIRZzT/mW+SGsOCQOBU5NfYuRsRl4h4jP7dEQXFBU
LIRmbzFaJYVkFMhsT5P9XMcw/sAeSegpV/9YuKMS/7IH4UWN0S+YIVjN0mGWFt45
8UE/S9c3C2zLMEtEFetAX+c+lg2xFWI46Jg+JPGtvuI1YFZ71xU6IWajK+ugK5ie
GwtrGY/V1Q9S45R+18Ypau4mUIPovX7i3HrtFtCNxpceEC9TIfrbi33f1QFdpNSE
sRWP699As3Qp7E9p4tdl6XpssC3GhohyvMNdBnr9D97gjtbp+ZC8bUDEhr0mMumb
vdoC5B34gXUpW9yWwrQQzVWT4d8D9Q1HdR+rXhvI720uiAyqukedZgV1evM1lMN+
VqHCqQ+mFU644jHWKAuMoOW638Gr1UDreQcGLExNW7u4zlp7hGc=
=jPBn
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
