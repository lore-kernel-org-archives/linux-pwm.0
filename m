From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 03/15] pwm: add pwm_get_polarity helper function
Date: Mon, 20 Jul 2015 09:52:09 +0200
Message-ID: <20150720075209.GD29614@ulmo>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-4-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435738921-25027-4-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2015 at 10:21:49AM +0200, Boris Brezillon wrote:
> Some drivers are directly accessing the ->polarity field in pwm_device.
> Add an helper to retrieve the current polarity so that we can easily move
> this field elsewhere (required to support atomic update).
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  include/linux/pwm.h | 5 +++++
>  1 file changed, 5 insertions(+)

Applied thanks.

Thierry

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrKioAAoJEN0jrNd/PrOhanIP/0BUxXg7th6WFzZDcnlGFzp+
cq7cOP9ic2jyzUUPGaXTqB3k0pSnXooubXMlgWkDynsLPDzaj2qD2b3uH9iLN9dy
fJhZtU2RpCoWw5271/z0pC4auHNV6YvbxTquMngXC/zaF18UPSwr7tyGapMDVQOA
HH0D75i8z3Qfib/xoxYFP2lzomOny/LAO2vlSnNzku5lYpbBy2ZgCdDfSsqW4Wbi
20g9cYhMeuQSQdqas0MguM2WiSmked6dZXvSS1tu4q1XKBjLoIf7A6aXjfcbdVKZ
8aSRbIcC9nS1/X1zc9qf0BfS0SRAz8YGM/1rQ3YIrm/NqGaty4fZucEwQ38CXZJL
3HaPyocmMJ361gclukbsGcG0Cz7mVbnK6uCr4DFZuKuLhN2QENrbQL52kOGR3nP1
XLcUBxDt8Hc9tuj3HQ5xMmcu1Fva+tmjCGHonsqfjfRlROERo9u+gDZJrAO6lgtM
aXWBDHPPvqraaNz97cJHAshkC/I7wkDrVosRiBtoMnejAo/4ZYVoFjH4ygun3uCA
k0uS/uYPbwzmFSpGGLHy6eQ/3f11V7VuNIuNEWGmzXdogwAXckHdtXvNoTe8dR5L
ooa6viN7Xx5m71MRMFNWqNBP4bSVYWr+ckUJIXcuSpV+3ncDX6/9oB4dApzJUeYn
xorful0JUkCfX6icbT0i
=OtfN
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
