Return-Path: <thierry.reding@gmail.com>
Date: Fri, 23 Aug 2013 11:24:57 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: renesas-tpu: Add DT support
Message-ID: <20130823092456.GK3535@ulmo>
References: <1374791261-9850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20130814094436.GD2084@ulmo>
 <1966878.F7c9U0lHrH@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcXnUX77nabWBLF4"
Content-Disposition: inline
In-Reply-To: <1966878.F7c9U0lHrH@avalon>
List-ID: <linux-pwm.vger.kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org


--HcXnUX77nabWBLF4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2013 at 01:36:38PM +0200, Laurent Pinchart wrote:
> Hi Thierry,
>=20
> On Wednesday 14 August 2013 11:44:36 Thierry Reding wrote:
> > On Fri, Jul 26, 2013 at 12:27:41AM +0200, Laurent Pinchart wrote:
> > > Specify DT bindings for the TPU PWM controller and add OF support to =
the
> > > driver.
> > >=20
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > >=20
> > >  .../devicetree/bindings/pwm/renesas,tpu-pwm.txt    | 28 ++++++++++++=
+++
> > >  drivers/pwm/pwm-renesas-tpu.c                      | 41 ++++++++++++=
+----
> > >  2 files changed, 62 insertions(+), 7 deletions(-)
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt>=20
> > > This patch depends on the "[PATCH v2 0/4] Add PWM polarity flag macro=
 for
> > > DT" series that is scheduled for merge in the PWM tree, and should th=
us
> > > go in via the same tree.
> > >=20
> > > The code has been tested on an Armadillo800EVA with additional platfo=
rm
> > > patches that I'm going to submit next.
> >=20
> > Applied, thanks.
>=20
> Thank you. I can't find the patches in git://gitorious.org/linux-pwm/linu=
x-
> pwm.git, have you applied them elsewhere ?

Sorry, I had applied the patch, but forgotten to push it out. Should be
there now.

Thierry

--HcXnUX77nabWBLF4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSFypoAAoJEN0jrNd/PrOhcUAQAJXiycSNGlm8q7Ba8vv+y22C
xDG2SV7iudXsH4EZXCJkSyR3OKZRnIJUyU/mZ5AuVnGn+yeDLyigV6Anh17WHHQO
bX/eLdY+A2YXsZExkpHuM5qx6WVffby2dwET8WsxB9U/25CtoU0nfnh6VKxZ4r+5
tWee1JyeSrS0RyQYLKKarakwIqr9ia1kL66lzUL4BjU7k1deKt4//jiJ4LttqMej
392BjF/AVHaHv9YLd7IlL1zXHwpLnu4QYbzKBC0WkLgsNABYtRY++Jyy8ITzFszU
Jap3GFzV839Lx1ZYI+ausPZ/VQDlJ3HVU3Rvm9RGUpCjfJl2qC5afT6CNi2xecLe
42vldQrMCAWx4APF2C4bdMKx7RzPx/+X3fEhVA4kOTVl6A6fFyA8Fk0BaRB6yznS
8SjVCdov4+P7ISyOhsIG+jMJLGp4eW2BrmOsgdn9cuGpaZswVz8Py15GNpGN6Pq5
WqSytrcLjclo0svfhph6Cn5cEYIWJNdZ6M69EVwxOK6y97E9cch4Oy/iaX7zV1JU
8CUNW1M/dIpASu8XhTWIhZDFKKdpoSYtPdeZU6/y/FLTjqPP3IBt8fAYiHnZAPJV
RRKrAhd1NgitASammnSoR54hgMc6hk0BTOgLpHBqetpAesSydLNodqn/SrJdmc/x
XEXLTv0wG3vTfPrIKg4E
=iJrV
-----END PGP SIGNATURE-----

--HcXnUX77nabWBLF4--
