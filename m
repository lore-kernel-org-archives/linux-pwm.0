From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pca9685: depends on I2C rather than REGMAP_I2C
Date: Tue, 17 Dec 2013 10:33:53 +0100
Message-ID: <20131217093352.GB13823@ulmo.nvidia.com>
References: <1387252289.4816.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:45021 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab3LQJfU (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Dec 2013 04:35:20 -0500
Received: by mail-bk0-f45.google.com with SMTP id mx13so2712096bkb.4
        for <linux-pwm@vger.kernel.org>; Tue, 17 Dec 2013 01:35:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387252289.4816.1.camel@phoenix>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-pwm@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 11:51:29AM +0800, Axel Lin wrote:
> REGMAP_I2C is not a visible config option.
> Thus make PWM_PCA9685 depend on I2c and then select REGMAP_I2C.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pwm/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsBqAAAoJEN0jrNd/PrOhojEP/0btNeLayktsCBjaCchLouT/
EDXaUD6eBWzjet/I3zKM6SSF+k6DSM8RbFZgCN/KbhvQyC7DHlAuHSZz31k3pKh3
23h5OzsMkAxvugS+l+YQ7LAMxtRneYqTRw6WkRPjjTwxLyO7AKJXDcwiqZJEQln3
PsRVBjdeJWwvhalMw80fYb3Fl1JlKR62rYDJVZTZtwwPYm1EAMLBsOiRYWs9Rrjb
OI2HnQznQOwZ2+7I78iR/tC5bwgpCQ8xfjHU1jpmQP8Lfj/Y91l31rAq/K7nQTpF
8HmYb60mw5EiWLVbCXsuV6/aKpAXY6ReFGXmDR45GwGZUAT6A0plSGr7AihKCFhb
BuZ9KuDcbvI/CWAo5Ha5Q/iNlxQzCRfzldAXd44Pol74izU1yeVLgd4kYd4JFmcX
LsSTlGFevQ0VfdelCxQBJXgkcDQkUO9z9N7Rj4eu7m6Kcu7/rssARyglIjUXTQ5d
QOVVrh5OOeww9uKBcXQTEub/6rC85TfyfYMQxrZTNpJgIygErjFhHSu2JhScXIgx
fq5NnukFIaIrmaAXIOuBwmn5NK2x0HfnISeLxmE3el/5fTkyBhdsteruVdmhEJrY
fXWz5MxjsvNHrv24G04Z7w5vNIRWrAOscYwDAmRdc35aCjt5/0CSwOFekl4zod1n
veifD4OdmmBjmqsFjnuU
=YS/r
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
