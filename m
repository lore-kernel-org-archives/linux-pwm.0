From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: sun4i: Add support for pwm controller on sun5i SoCs
Date: Fri, 6 Nov 2015 14:53:04 +0100
Message-ID: <20151106135304.GD31835@ulmo>
References: <1444556997-28885-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35034 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932918AbbKFNxG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2015 08:53:06 -0500
Content-Disposition: inline
In-Reply-To: <1444556997-28885-1-git-send-email-hdegoede@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2015 at 11:49:57AM +0200, Hans de Goede wrote:
> The pwm controller on sun5i SoCs is identical to the one found on sun7i
> SoCs. On the A13 package only one of the 2 pins is routed to the outside,
> so only advertise one pwm there.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sun4i.txt          |  2 ++
>  drivers/pwm/pwm-sun4i.c                            | 25 ++++++++++++++++=
++++--
>  2 files changed, 25 insertions(+), 2 deletions(-)

Applied, thanks (with s/pwm/PWM/).

Thierry

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWPLDAAAoJEN0jrNd/PrOhb3oQALRtz7zqLhEfszaypB0pV87y
rsOn5y20puJA+V2OPEYtQpAYKFnH+LiXA0tesAFpt7q+eKNZVTWxW1oOgg1oPp6p
hgiR44mzwtVqfPL8XqQdd70aYRIRpM2Efo8ogj7w1K4VVTJrYyBDsYoTg/FVuLoB
XUifk6fe0HQzZA5u5mhAGwEb6x5E1P8rELu4CBVtqKc+5T7Co9nH1pNKCGom5lAl
XebALqQ6OQwG6stEdXsQzByfVlI75fNsqBXNOxN5+tDg2imJBNiroVvcGEUxnbcu
QVkVSGXCI7VC4BhVtRQWWjbLLjB2EuIduOr6RsD8PvCl12JhoDBt6aX+Sax+hfIP
X2l9mKrjY6qisY/zvYj9C9gBs8DfdmiBMBwtd3Q5lHC8He8JYmemeyPl2E7mWxdp
rfomRxgdzF7Z+Q6Dd2FhmFhf4IpDoFyuS0AKWMBOXkKjIdkjA0vqao7spRhexLTA
x3ojX+W1SdousacMrYCHHWNbWbID4AUTRgNQXIhmucpimImgFcjwoXPB7a2OPzsH
GABiH7hfyy4U+9EMoodlYfSnMOqxVc6bWWw0nROKL9GVZKTXXX374tV20cq2WPHV
QPjBYGm9a2JNTPT6jjXCUDSGmVy1yyjIZXJiWkITtUqXpF/uFrWjeUkpGj39Y0Th
bPPogyHcf6+49Eo4ds3Q
=3puj
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
