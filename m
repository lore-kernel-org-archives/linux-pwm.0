From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 0/4] pwm: add support for ChromeOS EC PWM
Date: Mon, 25 Jul 2016 16:29:31 +0200
Message-ID: <20160725142931.GR21170@ulmo.ba.sec>
References: <1468625324-41229-1-git-send-email-briannorris@chromium.org>
 <20160718084928.GA17074@dell>
 <20160718091029.GA32259@ulmo.ba.sec>
 <20160718132426.GB17074@dell>
 <20160718140400.GA22297@ulmo.ba.sec>
 <20160719073717.GE17074@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b0op/nKJ9CeIhp9z"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35084 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbcGYO3g (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Jul 2016 10:29:36 -0400
Content-Disposition: inline
In-Reply-To: <20160719073717.GE17074@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Brian Norris <briannorris@chromium.org>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>


--b0op/nKJ9CeIhp9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2016 at 08:37:17AM +0100, Lee Jones wrote:
> On Mon, 18 Jul 2016, Thierry Reding wrote:
>=20
> > On Mon, Jul 18, 2016 at 02:24:26PM +0100, Lee Jones wrote:
> > > On Mon, 18 Jul 2016, Thierry Reding wrote:
> > >=20
> > > > On Mon, Jul 18, 2016 at 09:49:28AM +0100, Lee Jones wrote:
> > > > > On Fri, 15 Jul 2016, Brian Norris wrote:
> > > > > > This is the 4th (and final?) version of my series to support th=
e new ChromeOS
> > > > > > EC PWM API, so we can control, e.g., a PWM backlight when its P=
WM is attached
> > > > > > to the EC. It uses Boris's latest "atomic" hooks for the PWM AP=
I (i.e., the
> > > > > > ->apply() callback), which were recently merged.
> > > > > >=20
> > > > > > Pulled and adapted the cros_ec_cmd_xfer_status() helper from th=
is patch, with
> > > > > > some minor modifications:
> > > > > >=20
> > > > > > https://lkml.org/lkml/2016/4/12/342
> > > > > >=20
> > > > > > Note that after some style bikeshedding, I proposed to put off =
rewriting the
> > > > > > entire cros_ec_commands.h header at the moment, due to the shar=
ed nature of
> > > > > > this file. Follow up here:
> > > > > >=20
> > > > > > https://bugs.chromium.org/p/chromium/issues/detail?id=3D621123
> > > > > >=20
> > > > > > As this touches MFD (sort of), drivers/platform/chrome/, and dr=
ivers/pwm/, I'm
> > > > > > still not sure who it should all go through: Lee, Thierry, or O=
lof?
> > > > >=20
> > > > > I usually take this type of submission through the MFD tree, alth=
ough
> > > > > it's too late in the day to make it into v4.8.
> > > > >=20
> > > > > Which Acks are you missing?
> > > >=20
> > > > I'm willing to take this through the PWM tree if you're okay with t=
he
> > > > MFD changes. I can put the MFD changes into a separate branch and y=
ou
> > > > could pull that in if you needed to resolve any dependencies, which=
 I
> > > > think would be quite unlikely if you've already closed your tree.
> > >=20
> > > Are you saying that you're willing to take these straight into the
> > > merge-window, with no soak in -next?
> >=20
> > There's still a bit of time to let it soak in -next, but I'm not overly
> > concerned given that this is purely additions of code, so there can't be
> > any regressions.
>=20
> No problem my side then.  Apply away.
>=20
> Before doing so, can you see if there are any clashes with my
> mfd-for-next branch?  If conflicts occur, please construct an
> immutable tag I can pull from.  That way, I can base my branch on it
> and deal with the fallout myself.

It merges cleanly into your mfd-for-next branch, so I've gone and
applied patches 1 and 2 to a for-4.8/mfd branch, which I can provide a
stable tag from if you still need it, and patches 3 and 4 to the
for-4.8/drivers branch.

Thanks,
Thierry

--b0op/nKJ9CeIhp9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXliJLAAoJEN0jrNd/PrOhWq8QALU4Q1KFB4bYp5NDQvZWSTSP
MeiDe4+rTqPjWR6quVm+UIkndRjOntsd6QvpbemxyW4dyZSJRDabxndGlcsbmlYo
dFFZ3ftzUbLu68YuUjLzssq+LwWOYgGOFu7/jWSBWLLDcwhrUl89LbOLxtvYJepU
phCNSg9WFYO3arW3I4O1Jv8o11KBM+yGpYXOjPBc/nd5QlEiZWbvxbXAc+057HLV
NolughdDk4P04UpWeP5rosfyiApPSCMV/Mtj8ogHNBuwtFeiBzaeiXlQFpwrkZJP
08NkmBY6jA/wN6tH9PcauWudfaOs6WJd6+PcMXeTsFXDXRnowaKMbMBSsJkDevZL
3nCPLXF7/zXIbSJu0JzClw+bnZxwjB9kKZoWvA1zTtdPTLm68WN3fxqgG6GBoueY
fyxxMcFZ7x2EZvTXPg0fT62lT63hSVs7PdbYPE7dY5G8sMjw7imto4FHXSnHJqal
GsAOXd0+RWroKguGUadth90Qz8yf8P+BZnekbpqIQNAYGHKFqBdNPOA3A0Kav1E6
qh2hbQGzw7uoMQZE3hgvh/1SqwbC5ihs+4mbDoLKveY7RVwbI8BFBleDG2tebAmY
ymt8FzZ6wKbA8rSf9E4gL9x4uJiYkITSy2yBeFQF8waXI1W6686AE8QiN/Vpk5/x
8CtdUzyXeqSf9KSC9ueD
=q3VE
-----END PGP SIGNATURE-----

--b0op/nKJ9CeIhp9z--
