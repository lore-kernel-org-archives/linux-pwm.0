From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 00/15] pwm: add support for atomic update
Date: Mon, 20 Jul 2015 09:43:41 +0200
Message-ID: <20150720074339.GA29614@ulmo>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2015 at 10:21:46AM +0200, Boris Brezillon wrote:
> Hello Thierry,
>=20
> This series adds support for atomic PWM update, or ITO, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.
>=20
> This implementation is still experimental, and I may have missed some key
> aspect, so any feedback are welcome.
>=20
> Also note that I haven't protected the state update with any locking.
> That's because the existing config does not protect against concurrent
> access to a requested PWM device (see the pwm_config implementation).
> I guess the PWM framework assume the user will implement the proper locki=
ng
> scheme if it has to concurrently access the device.

Actually the reason why no protection is needed is because there can
ever only be a single user of a PWM channel. pwm_request() will only
hand out a handle to the PWM channel if it hasn't been requested
before.

And in the unlikely case where a single user wants to use the same PWM
channel from different threads, then it will have to use locking for
other reasons already, so accesses to the PWM can be serialized using
the same mechanism.

Thierry

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrKaoAAoJEN0jrNd/PrOhVakP/iFXChf7Z9UgjeIEltssemh3
89xZdncLMo2MoyPwU3XgI6tg5C4PgEROhr9PWvDbPs8aZjDhyDb6Z1qSK6kNPlkh
oCCP/isBEEvQeMRETZyKn7CTIUZbNB0HfKYLLKHiH2TQIumGMKt0leotRPLtzGOE
yJB74jgeUWP8d4Jt280VLm5HUqF6ZPnfTN/WNMlM2RYZG7MbrDyYRRsSHdV1IgGC
aYHQJjYPDmTEfVPLi9V9Wc6lSSOf5YoTRLWPjJPamJYtF8+ZJrXMff9J73veGzya
sNtHFqXkZU55EZWr/Bonbzy5k6dG3gAUZ0EeYS+kSExB5/kcRs0F/o8SCGBeQ6Cm
lkZKaRW+HWZ50ZC+BCODSgjU0v+miTf3eRvCeBzBcB4JPj0N5HAqY3D9yeQvNUc9
BQWRkaMzMdl7k+mqYAOCpaiWCNJQlVLBu2WD/DPDoI2Y6d4e0ammZ313DGtbyISB
M5dBJxH0NRTW4n7Wh1oyBMkm7XMKmT/huNhXEe3TWWULTH9OUyZ1Dkh2bpdnHbfp
l9Fk2PSGZ3jtG+QMlcEP5qwQ1sCWsZSmNJahJApXspZ/k/G2LFFW2o+ZcW72Kuph
cG6yiCHljD8KEBUOjNQYmlW8JZI4H/Q+Xe1MRlEJh0EQxvD14t6IQmcfpOTM39xm
Rhhlak2e8UzKNKp92YbU
=/182
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
