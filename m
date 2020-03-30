From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Date: Mon, 30 Mar 2020 17:43:59 +0200
Message-ID: <20200330154359.GC2817345@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
 <20200330130757.GC2431644@ulmo>
 <20200330133450.GA1530@workstation.tuxnet>
 <20200330154036.GB2817345@ulmo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36999 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgC3PoD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 11:44:03 -0400
Content-Disposition: inline
In-Reply-To: <20200330154036.GB2817345@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 05:40:36PM +0200, Thierry Reding wrote:
> On Mon, Mar 30, 2020 at 03:34:50PM +0200, Clemens Gruber wrote:
> > Hi,
> >=20
> > On Mon, Mar 30, 2020 at 03:07:57PM +0200, Thierry Reding wrote:
> > > On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer wrote:
> > > > The interaction of the ALL_LED PWM channel with the other channels =
was
> > > > not well-defined. As the ALL_LED feature does not seem very useful =
and
> > > > it was making the code significantly more complex, simply remove it.
> > > >=20
> > > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > > ---
> > > >  drivers/pwm/pwm-pca9685.c | 115 ++++++----------------------------=
----
> > > >  1 file changed, 17 insertions(+), 98 deletions(-)
> > >=20
> > > Applied, thanks.
> > >=20
> > > Thierry
> >=20
> > I was not reading the mailing list in the last weeks, so I only saw the
> > patch today.
> >=20
> > We are using the ALL_LED channel in production to reduce the delay when
> > all 16 PWM outputs need to be set to the same duty cycle.
> >=20
> > I am not sure it is a good idea to remove this feature.
>=20
> Can you specify what platform this is and where the code is that does
> this. I can't really find any device tree users of this and I don't know
> if there's a good way to find out what other users there are, but this
> isn't the first time this driver has created confusion, so please help
> collect some more information about it's use so we can avoid this in the
> future.
>=20
> I'll back out this particular patch since you're using it. Can you give
> the other three patches a try to see if they work for you?

Nevermind, mixed up the series. I ended up applying only patches 1 and 2
=66rom this because Uwe had some concerns about patches 3 and 4. So no
need to test those until Matthias has fixed them up.

Matthias, I'll keep patch 1 of this applied, but as you noticed, this
ALL_LED features is indeed used, so you can drop then when you resend
the series.

Thierry

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6CE78ACgkQ3SOs138+
s6GlkRAAiNq3PY2visPdWkNSAhUbBF0q009ao0QOM1HGuNHiTxrA5lKIQ/9usaHo
5MRJWV9/Lx1Ye3G6RRad9jfSiJ09+JZbQdiLxpX/8aHMrz7KXRURoYFbNFQBaaJu
yZh2lBn8g4SBUJhfQlR0h0kXEltDHEqlP0Twu4wo++CnWvOqMxZPqQh5Nqn8Bprd
gBV7dtYHQDw5YZVvXgvgM3AqIlQicBJHhAaeCfSc5/wdDK9Iv1/1KQaviemjLpVp
xcPDBTX0Bcu81QWdfRpU6VcMOOj+PUKAYkZh3mdHE8Evc7VfgWw7wcOEjIYgPS6S
5g/346g6A9WJ2EWNvLOxMgp26z8hrIOjKCbWfW7RJGpUN6GMQxSAw3CaOPmnAeM3
SST3qTtNMCr/cZvh7BhcqmVjUC9FJwvUj1EauaNvE7g38Ai9yNV2BXWG+5zRlZeB
N/49D2SOhK7qtxUif7VHxhBonPjx7SDs/KroyRRcAewxaRbHYiK8yNruvTfezhzB
ze23DUB6HtKAEurZ/JghqgkQnoWReswOyt4nUHzqy8YkMee4Jq4lMwY05Fnn+xft
unzZKyb2oBQxQJbi/PvjiummXLtUOCQMn3PABEKh0d3WQ5/I3YFGohaBOcapV00w
KOFLqsSeXMSCSt2f9P6L5eKbWfEc8qGgNVNLh7mlXvHWE4ZvxRo=
=vDVt
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
