From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v4] pwm-backlight: Avoid backlight flicker when probed from DT
Date: Fri, 27 Nov 2015 11:18:04 +0100
Message-ID: <5498492.8XSal22i1Y@diego>
References: <1446483356-14338-1-git-send-email-p.zabel@pengutronix.de> <3447562.c3gSANEMio@phil> <20151110173257.GA21727@ulmo>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1597955.2rRO27RILh"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:49773 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248AbbK0KSZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 27 Nov 2015 05:18:25 -0500
In-Reply-To: <20151110173257.GA21727@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, YH Huang <yh.huang@mediatek.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>, kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>, Ajay Kumar <ajaykumar.rs@samsung.com>

--nextPart1597955.2rRO27RILh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

Am Dienstag, 10. November 2015, 18:32:57 schrieb Thierry Reding:
> On Tue, Nov 10, 2015 at 03:18:10PM +0100, Heiko Stuebner wrote:
> > Hi Philipp,
> >=20
> > Am Montag, 2. November 2015, 17:55:56 schrieb Philipp Zabel:
> > > If the driver is probed from the device tree, and there is a phan=
dle
> > > property set on it, and the enable GPIO is already configured as =
output,
> > > and the backlight is currently disabled, keep it disabled.
> > > If all these conditions are met, assume there will be some other =
driver
> > > that can enable the backlight at the appropriate time.
> > >=20
> > > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > > Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> >=20
> > this patch improves the white screen when booting a veyron chromebo=
ok
> > a lot. I still see a small white flash, but that can probably come =
from
> > the WIP edp driver.
>=20
> Some panels require a couple of frames before they actually enable. Y=
ou
> may want to look at the datasheet of your panel to see if it has some=

> specific requirement and update the panel driver with that.
>=20
> From a high-level view the way that this is supposed to work is that
> your encoder driver (e.g. eDP) "prepares" the panel, then starts send=
ing
> frames and finally "enables" the panel. With something like the simpl=
e
> panel driver you can influence this by setting the delay.enable field=
 in
> the panel descriptor.
>=20
> See struct panel_desc in drivers/gpu/drm/panel/panel-simple.c

Thanks for the pointers :-)

Just to follow up a little bit, after moving to Yakir's Analogix-dp dri=
ver=20
from=20the chromeos-one I was using till now, that actually works nicely =
for me=20
and even the short flash is gone.


Heiko
--nextPart1597955.2rRO27RILh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWWC3cAAoJEPOmecmc0R2BLT4IAI9UxE2jpis8B5IIq0UKUYGs
/v1fTkUZp5qmFLB8ZRXHG9MQJP/Vld9MTX04sM8S7pqi21T8tZrma8bnRchI59eE
KcLFcqdKAijrLmRfCXh2BV8HGyejE4JlEeSeaE+95i2mmA3Hvu1rkMOmUWeEe6FT
ffSBT/rOYnhNT60hAzy3aAdoz0940udwBanASy3PKVlbW4mUiV/byOF9QXHDizTi
weJkRUvNg3WzYeJfLSnKEp7pT5YOqIHQFIIbfocO+6cUWyla83WXPKhuEQZRjDjz
bkTP5zeEO72QrrjQO+PyjOVVn3wsFklbEQ1NsRoVShdSpagw8/2veiHJs4vWvUk=
=0gm6
-----END PGP SIGNATURE-----

--nextPart1597955.2rRO27RILh--
