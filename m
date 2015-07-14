From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 14/15] regulator: pwm: implement ->enable(),
 ->disable() and ->is_enabled methods
Date: Tue, 14 Jul 2015 12:08:19 +0100
Message-ID: <20150714110819.GU11162@sirena.org.uk>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-15-git-send-email-boris.brezillon@free-electrons.com>
 <20150714105019.GR11162@sirena.org.uk>
 <20150714130222.1bdfedc5@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fFZg0b+WaoCdn4Fq"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150714130222.1bdfedc5@bbrezillon>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--fFZg0b+WaoCdn4Fq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2015 at 01:02:22PM +0200, Boris Brezillon wrote:
> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > On Wed, Jul 01, 2015 at 10:22:00AM +0200, Boris Brezillon wrote:
> > > Implement the ->enable(), ->disable() and ->is_enabled methods and remove
> > > the PWM call in ->set_voltage_sel().

> > This doesn't apply, please check and resend.

> This series was made on top of Linus' tree (4.2-rc1 IIRC) and patch 14
> and 15 were not meant to be applied without Thierry's approval (they
> depend on other changes in the PWM framework).
> I can rebase them on top of linux-next (or just on top of Linus'
> 4.2-rc2) if Thierry is okay with that, but I don't think rebasing them
> on your regulator's for-next branch is a good idea.

What is the dependency for the enable patch?

--fFZg0b+WaoCdn4Fq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpO2jAAoJECTWi3JdVIfQCzAH/jtVAxZM4A2VDq6+8+KcbB4Q
FHI8enaYP9PYo645nK+Os5OdcAD3mEaVOWgscWVOZC77jJc2EfVhEbOGXFkPVBEY
UQiNm2Ho/bAxflmKYO3ejouir17ApUIrOJHE5ED04WqBWWyoUD5EartUF3puL7CV
VCUl34VE2tdJ/juFH8RsNUf2r3UJv2mF6Bm+iem5RO46briQFve8PCoFmXqfCyM+
3b7gHVQdwj3XNPh4MnU7VhB9NpkIT0tEbCHtQoyIOa8uc/aQwfyvrERfhiNHNUMk
b1KHUXMH3xjT/TMd8K+glb45vISmS9BY47/h5FYvayAGUnRBI8IcFiSr7U+todI=
=CduC
-----END PGP SIGNATURE-----

--fFZg0b+WaoCdn4Fq--
