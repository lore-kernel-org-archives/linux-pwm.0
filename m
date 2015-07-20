From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH 06/15] pwm: define a new pwm_state struct
Date: Mon, 20 Jul 2015 12:09:26 +0200
Message-ID: <20150720100925.GX29614@ulmo>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-7-git-send-email-boris.brezillon@free-electrons.com>
 <20150720080458.GG29614@ulmo>
 <20150720120116.2358b829@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OtXN0xDA1zr/oUEL"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33664 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbGTKJk (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 06:09:40 -0400
Content-Disposition: inline
In-Reply-To: <20150720120116.2358b829@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>


--OtXN0xDA1zr/oUEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2015 at 12:01:16PM +0200, Boris Brezillon wrote:
> On Mon, 20 Jul 2015 10:04:59 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Wed, Jul 01, 2015 at 10:21:52AM +0200, Boris Brezillon wrote:
> > [...]
> > > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > [...]
> > > +struct pwm_state {
> > > +	unsigned int		period; 	/* in nanoseconds */
> > > +	unsigned int		duty_cycle;	/* in nanoseconds */
> > > +	enum pwm_polarity	polarity;
> > > +};
> >=20
> > No need for the extra padding here.
>=20
> What do you mean by "extra padding" ?
> I just reused the indentation used in the pwm_device struct.

Yeah, I have a local patch to fix that up. I find it useless to pad
things like this, and it has the downside that it will become totally
inconsistent (or cause a lot of churn by reformatting) if ever you add a
field that extends beyond the padding. Single spaces don't have any such
drawbacks and, in my opinion, look just as good.

> Would you prefer something like that ?
>=20
> struct pwm_state {
> 	unsigned int period; 		/* in nanoseconds */
> 	unsigned int duty_cycle;	/* in nanoseconds */
> 	enum pwm_polarity polarity;
> };

Yeah. I'd say even the comments would be more suited in a kerneldoc-
style comment:

	/**
	 * struct pwm_state - state of a PWM channel
	 * @period: PWM period (in nanoseconds)
	 * @duty_cycle: PWM duty cycle (in nanoseconds)
	 * @polarity: PWM polarity
	 */
	struct pwm_state {
		unsigned int period;
		unsigned int duty_cycle;
		enum pwm_polarity polarity;
	};

This is something that users will need to deal with, so eventually
somebody might look at this via some DocBook generated HTML or PDF.

Thierry

--OtXN0xDA1zr/oUEL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrMjUAAoJEN0jrNd/PrOhtxQP/0MJzNi7shUGB3w2pqffHAQo
0PuZoLqqQwurNDUsa4yw3TtYQSeVVuPsiELraE1rBvilB2YiG5wO5LnThUAib1jp
BkIngnEja/tQNQMz7PtO61XB0OkhwwNx/llyUiope6GdznzuP70W4wpRxSUZy65s
v4NUbM5fAR/GTVOU78pumlDowU0b0WnP9/XePw6rcPJqVQN4qusFBCKCkCViGHyc
bOH3B9z7f35oWX4XG8uxA9t2CyvqbQxupAzf24BB4NzL63mzyg3V1kLOztYRFJAo
0W2A98PAZze0DB3lbUTo64YRdE9nCXd+pMca04wZmGf0PR0IU+DHtNi6B6mAoqNy
P/H+ph6+PfSb3AwleEQh7pEuJFtehmG+vzKwU9KORRZWbsj9WaQz01OLwX6vw6AZ
C/NDReKHzQHCKz8RDdPoY+FLIxGC2WDDZIdOKXEOk6yyt9uACSL8N8OkFJ1PMgdi
mFxEeJkUMhb2rb2uSgpRoGm0nj8aaOqFZMtYXDjd4gXt4qd8aCAOK6Q131GcnAxW
zRdM8lPgBqcmjrJPVuql6MMn4MD2tG+7l6TadJgXbeyjuJQ70d7L3STm7HiqLOGE
+bRm94HhXbNL3M6pwC2YQfYpY/l0YkTt4KPuqCh9oHDlD0xEv0HqhJA9L9hEu5Hw
QZLTlVQx3FRI6i8NI66H
=ztxj
-----END PGP SIGNATURE-----

--OtXN0xDA1zr/oUEL--
