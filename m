From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Date: Tue, 17 Mar 2020 18:40:43 +0100
Message-ID: <20200317174043.GA1464607@ulmo>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35236 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCQRkt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 13:40:49 -0400
Content-Disposition: inline
In-Reply-To: <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Paul Barker <pbarker@konsulko.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Claudiu Beznea <claudiu.beznea@microchip.com>, Fabio Estevam <festevam@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@baylibre.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Maxime Ripard <mripard@kernel.org>, NXP Linux Team <linux-imx@nxp.com>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2020 at 02:32:25PM +0200, Oleksandr Suvorov wrote:
> The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> Rename it to PWM_POLARITY_INVERTED.

It isn't misspelled. "inversed" is a synonym for "inverted". Both
spellings are correct.

And as you noted in the cover letter, there's a conflict between the
macro defined in dt-bindings/pwm/pwm.txt. If they end up being included
in the wrong order you'll get a compile error.

The enum was named this way on purpose to make it separate from the
definition for the DT bindings. Note that DT bindings are an ABI and can
never change, whereas the enum pwm_polarity is part of a Linux internal
API and doesn't have the same restrictions as an ABI.

As far as I'm concerned this is completely unnecessary churn that's
potentially going to come back and bite us, so I see no reason to accept
this.

Thierry

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5xC5cACgkQ3SOs138+
s6Fzrg//W6eAtrfA02CGekiB6CchW1v901SEIXd0i/BUbGhUbBXgNAk0CdFr1oZF
oWh3FArEd2Ugq3qvpgf4UqWlO/2IptBucOUVSwQ5Imuc+eS/JKxC3lriUcpyI519
b5+MI+QPztSa8Nae3cVvDVd1zs+s5QE1J9TOJTINsayE0yxs2QDk7px+T2hP6S5y
fZmxD7DxmhzzTjY9pUb7B8Km/c+g3iLZ2dOrjizHPQ0D6gjni2sAljxJXKBkExBG
nSSO7pOuxA1Koi0/lKAQGtxKl1QbfH5aerdiSj8wi74C4DXTG/yHIU0x4YKpbu1d
C0nSwCafh3P/dIz0ja7iv+8y02HB43gdu9tyA6dlVzIs7UAS/upZfwtLCI49zdOL
Qq28oqgpytPujRWyFSdT7EisrlmqA4TlG6jvndwdhKiurjM98oNob5FiUYz/QebP
cX0mZQFNM8UJjzhu51wkfu3NwtdIBXMWv+EhD8Kh7Ash60aI7LE2HltEC5Y/KqiW
uprdNVNa09YyyZLgE0W1rDU4rsdPw+yxp/XR/vzPWR4eivXlrbPtkBxcZcZfHAmj
Yg13OeYRbxUgR1Jx4vGYyRgV2wSNSyDcwqZ0vU0Z8C4C3qLFNqQPllTPonTSdcnX
gQU9NZOlpo00W4TwrlO7I+3Ww9qNIvnHhMwcaOQGIca6+ZVYyfQ=
=EuQk
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
