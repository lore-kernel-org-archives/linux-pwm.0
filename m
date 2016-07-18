From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 0/4] pwm: add support for ChromeOS EC PWM
Date: Mon, 18 Jul 2016 16:04:00 +0200
Message-ID: <20160718140400.GA22297@ulmo.ba.sec>
References: <1468625324-41229-1-git-send-email-briannorris@chromium.org>
 <20160718084928.GA17074@dell>
 <20160718091029.GA32259@ulmo.ba.sec>
 <20160718132426.GB17074@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36723 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbcGROEG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Jul 2016 10:04:06 -0400
Content-Disposition: inline
In-Reply-To: <20160718132426.GB17074@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Brian Norris <briannorris@chromium.org>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2016 at 02:24:26PM +0100, Lee Jones wrote:
> On Mon, 18 Jul 2016, Thierry Reding wrote:
>=20
> > On Mon, Jul 18, 2016 at 09:49:28AM +0100, Lee Jones wrote:
> > > On Fri, 15 Jul 2016, Brian Norris wrote:
> > > > This is the 4th (and final?) version of my series to support the ne=
w ChromeOS
> > > > EC PWM API, so we can control, e.g., a PWM backlight when its PWM i=
s attached
> > > > to the EC. It uses Boris's latest "atomic" hooks for the PWM API (i=
=2Ee., the
> > > > ->apply() callback), which were recently merged.
> > > >=20
> > > > Pulled and adapted the cros_ec_cmd_xfer_status() helper from this p=
atch, with
> > > > some minor modifications:
> > > >=20
> > > > https://lkml.org/lkml/2016/4/12/342
> > > >=20
> > > > Note that after some style bikeshedding, I proposed to put off rewr=
iting the
> > > > entire cros_ec_commands.h header at the moment, due to the shared n=
ature of
> > > > this file. Follow up here:
> > > >=20
> > > > https://bugs.chromium.org/p/chromium/issues/detail?id=3D621123
> > > >=20
> > > > As this touches MFD (sort of), drivers/platform/chrome/, and driver=
s/pwm/, I'm
> > > > still not sure who it should all go through: Lee, Thierry, or Olof?
> > >=20
> > > I usually take this type of submission through the MFD tree, although
> > > it's too late in the day to make it into v4.8.
> > >=20
> > > Which Acks are you missing?
> >=20
> > I'm willing to take this through the PWM tree if you're okay with the
> > MFD changes. I can put the MFD changes into a separate branch and you
> > could pull that in if you needed to resolve any dependencies, which I
> > think would be quite unlikely if you've already closed your tree.
>=20
> Are you saying that you're willing to take these straight into the
> merge-window, with no soak in -next?

There's still a bit of time to let it soak in -next, but I'm not overly
concerned given that this is purely additions of code, so there can't be
any regressions.

Thierry

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXjOHKAAoJEN0jrNd/PrOh/FsQAJLxtyAFP0FO62ym2VIsEJk1
pEdGmnx+X52SXkDs2jCvNBGdLarQs2MJFT/+yTLqp4HbW2LQcRBakLgk9zbCSwMw
4llZgbxVLcxE6d7X9HIS1UEmmVE4+sv3DJChNDABSWfpr3twkMFGxRGTZzJoluUn
Xr/g3tnYqIZ4EqqGfx9NcvTqdgSnF+pnKtltV6LnEP6x+H+XYRXUKoPC5KX0uiYR
5sRo2iRHaYxQxyL+ttBOcIVce5S6nHnLT81zJaHinGjQUt6lYhloiMq4sbpfHg7n
Wca6Gt5jMkjIoIbJn2cWkibA4IKNKJ7JkZftl6c8WISsM4VDS3WiWlOig6iAyiOE
2oZdSwOcvjumUz7bDsPAK1+nIRUlQDw6ydo8kunLShH2o93YeolH9b8/PSk0sf3m
xzWOwIw+M8phZfVcrKDd+lhJZYJKzUtThJL9aeypdXiW9ikreFZHHsOUSR2zcwrP
wNnr8aHdP8TNMHViw1f37VHaj+T6OnCm7C2eqigWnnChDCIss+2Z/j5CYLVhJy8f
rFcZT/bkSY2mzacChZj1T0GHdMX7ThrC4Y40z7wyE+UCo/dSFXCFSMABpzv4Ayp/
QlIY3rSB5m1edA+ZldettfyL7tDY8ICURcMgqnOQv4VGElplBn+AOm4NKI1R7tNu
SXbEd3VzEI7pJRrCS88m
=fs+M
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
