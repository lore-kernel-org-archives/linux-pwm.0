From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 0/4] pwm: add support for ChromeOS EC PWM
Date: Mon, 18 Jul 2016 11:10:29 +0200
Message-ID: <20160718091029.GA32259@ulmo.ba.sec>
References: <1468625324-41229-1-git-send-email-briannorris@chromium.org>
 <20160718084928.GA17074@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36723 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbcGRJKd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Jul 2016 05:10:33 -0400
Content-Disposition: inline
In-Reply-To: <20160718084928.GA17074@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Brian Norris <briannorris@chromium.org>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2016 at 09:49:28AM +0100, Lee Jones wrote:
> On Fri, 15 Jul 2016, Brian Norris wrote:
> > This is the 4th (and final?) version of my series to support the new Ch=
romeOS
> > EC PWM API, so we can control, e.g., a PWM backlight when its PWM is at=
tached
> > to the EC. It uses Boris's latest "atomic" hooks for the PWM API (i.e.,=
 the
> > ->apply() callback), which were recently merged.
> >=20
> > Pulled and adapted the cros_ec_cmd_xfer_status() helper from this patch=
, with
> > some minor modifications:
> >=20
> > https://lkml.org/lkml/2016/4/12/342
> >=20
> > Note that after some style bikeshedding, I proposed to put off rewritin=
g the
> > entire cros_ec_commands.h header at the moment, due to the shared natur=
e of
> > this file. Follow up here:
> >=20
> > https://bugs.chromium.org/p/chromium/issues/detail?id=3D621123
> >=20
> > As this touches MFD (sort of), drivers/platform/chrome/, and drivers/pw=
m/, I'm
> > still not sure who it should all go through: Lee, Thierry, or Olof?
>=20
> I usually take this type of submission through the MFD tree, although
> it's too late in the day to make it into v4.8.
>=20
> Which Acks are you missing?

I'm willing to take this through the PWM tree if you're okay with the
MFD changes. I can put the MFD changes into a separate branch and you
could pull that in if you needed to resolve any dependencies, which I
think would be quite unlikely if you've already closed your tree.

Thierry

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXjJ0CAAoJEN0jrNd/PrOhYaEQAKMnQwoVT5HnT22oLX6ls4HL
n3wgye7zuxRRAR/fY4aVVJgYUdLVEBHgS4Ty48DBUqw8xtjLVYXDs2QaEpiTLkR5
odwV+NdVFcalv+x8WuR1E+npa2x7Y+yY6q2vzIK06ndM4nK/cRvI01apAHSfBdBK
qQI6Pq/cd4KDWCBLBDF55ndvhb5XM1UUOIZCcV6+se/hJ2a/9IeXJqCkblbAAesk
iEuyRCy5yvL3h6tBWybFYQDy4wO5YUsRiynNQnIFJ4/OWx8TM/ZiGr7blnrfmzOt
xJ0hpknTDC10Yhg8QXwQ5ZeT0SV4yONNJwEpxItfK0tkBeT4Mvc3Z+7hbdlI/f2k
HznWdBPvEjqet5uEfk+DZ10zRqZ9ANiT04an7y46DhQ+OBXdWc7xey0vdKeEhKd5
VEtedul6lAdHHnpA3E2ZN55XahbwFLnXGyemMiQgiudaVPtw20Ccfvyv6qwWWy2/
C36F4lR576Pd63gi8DEJt/FyXolKbHHBwIAzxR7urLcHwXFtNMWmpxC8sX7mVWte
Wjp4FCuQITuaQzZ2Jnvv8IhyxGdpzczyoB0B1RvacgE1la+c0JfxvnKtPJG2mhOj
PcKfjgWc6S5IUbwb9rqMDqRchfIZ302STgeWcmVWbUZjTTLoVuFSuHsVEJEsvrgV
h+B4j56a3PbcBXG4KsHg
=qoRx
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
