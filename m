From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4] pwm-backlight: Avoid backlight flicker when probed
 from DT
Date: Tue, 10 Nov 2015 18:32:57 +0100
Message-ID: <20151110173257.GA21727@ulmo>
References: <1446483356-14338-1-git-send-email-p.zabel@pengutronix.de>
 <3447562.c3gSANEMio@phil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3447562.c3gSANEMio@phil>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, YH Huang <yh.huang@mediatek.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>, kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>, Ajay Kumar <ajaykumar.rs@samsung.com>
List-Id: linux-pwm@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2015 at 03:18:10PM +0100, Heiko Stuebner wrote:
> Hi Philipp,
>=20
> Am Montag, 2. November 2015, 17:55:56 schrieb Philipp Zabel:
> > If the driver is probed from the device tree, and there is a phandle
> > property set on it, and the enable GPIO is already configured as output,
> > and the backlight is currently disabled, keep it disabled.
> > If all these conditions are met, assume there will be some other driver
> > that can enable the backlight at the appropriate time.
> >=20
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
>=20
> this patch improves the white screen when booting a veyron chromebook
> a lot. I still see a small white flash, but that can probably come from
> the WIP edp driver.

Some panels require a couple of frames before they actually enable. You
may want to look at the datasheet of your panel to see if it has some
specific requirement and update the panel driver with that.

=46rom a high-level view the way that this is supposed to work is that
your encoder driver (e.g. eDP) "prepares" the panel, then starts sending
frames and finally "enables" the panel. With something like the simple
panel driver you can influence this by setting the delay.enable field in
the panel descriptor.

See struct panel_desc in drivers/gpu/drm/panel/panel-simple.c

Thierry

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWQipHAAoJEN0jrNd/PrOhUdMP+wSo2k1dy4iq+yX1ZPzYNn+U
brGXKxrub2AQSmn3FW5KuptPEQ8ZCoqMZDIfhaXBLMyy+6gOEu4CQ7iNI0TL2yU8
OUQZXb0xk2v1pPAPHMBwcxaG04CRcEuXoilq/snbzNSy4MzIWsoLaL6uXnu7lHN/
WJtN+leipSBslMhvJOXmgor74m1VEy+F+06oNb2gEKBcJF/0oQuaLIGKCCeZB8KH
f9lY5jm9M2evaqMCoTHAJ2R7/LDwyw3QJmYowwUnR8Ip8aZEBV0mrrHVnedgDDDu
b22ZGurbzpdumSeOPsnMRhkW2TfhHC0dCUnMM67d/v0gJuXqKCleBWVnpmkaYzfX
rQKenESYhjXtcoej9vm321zOXfCO4vqQ7LFko/SO2+jphAjb4y7WS+RruZ7/ABV8
c79lOXH8hRl7qreVAFuJoGQSrcx8F9NqRVEfwFGtESns5FiE1Do+cUewt4EZt5V4
TKm4iP8KXiOqG3a11XLhFTEpj7ATwLqx6k/ijByqdbOGZyQIn0Azd9IYnfEqaiKw
n9VgJULMlb5tc1HD5caoyrrh2Rc6pKMNzAcjMo106kYTYRKMDr5K25MPQ23nXk7/
Ofn5VixeOnaRfCIayncHlq+gEjLibwggM1FhWytmakITLkSPfaagSkv1l3h/0W8i
ajEY70SNxCDuhrVti8UN
=tCx/
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
