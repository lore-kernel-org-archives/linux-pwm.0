From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: atmel-hlcdc: add sama5d2 SoC support.
Date: Mon, 5 Oct 2015 17:16:29 +0200
Message-ID: <20151005151629.GA17612@ulmo>
References: <1441805550-11553-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35609 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbbJEPQc (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2015 11:16:32 -0400
Content-Disposition: inline
In-Reply-To: <1441805550-11553-1-git-send-email-nicolas.ferre@atmel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris BREZILLON <boris.brezillon@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2015 at 03:32:30PM +0200, Nicolas Ferre wrote:
> Add sama5d2 hlcdc backlight PWM support. This chip doesn't have to deal w=
ith an
> errata, so it's a simple addition of the mfd compatible string.
>=20
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

Thierry

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWEpRMAAoJEN0jrNd/PrOhy1MQAInhm37sYmyN4vXO4wu5YJ/I
VNT5U8lC0OLp5nYNcIP/ehc/3W/oZ52siIFflobe2eqxbbkMtHMpA+fYKIMVTFRg
mEKUec/YnM4DbZH68lneAeqinVguxIF4mZBR2iuYNcCPAgXjmEEEMHTuQ1iCPLSf
ZoYvmoeS1B0ndL1V5IeF/uoC+HZKoHGpr1rce/cjGSvuI4nPpvGTSW/XTkHWLyzE
rD6CvcfKpWPBsZtKRsdy12G+37K5936qBaha9lU6qXwu3apSMuSOY6Thi9MaezWj
1lP0kSBHQXtWGST2r3E1xMXc/YW6IaEUWM9ON3lc2yfv7Hs06WgUHDQXqOVIMfM/
ikGKOOOnLxlBMOUYwuU7eKF9xjhr51FGRRHCyVnyD+OFs1o+CbpaDXGPk5KlJv0r
qJ4aRdT9TrRvadt49WlT+VR3ow9bLXENRAenoSQbcPjEdLO89HSTbkF+dB2G/+af
0qPM8XCoD+d2DTVod/FyHmt5NALnu9Tnxx9wjKI2oaBTA66xqmNMAP5ewK5QIun5
D+9dt720byYxUqefierd9zE0rxwEYbM8rs/0GytYjLLkOIlktJBRMKumdn9THojx
ZmU73Egg9EYnyeoJptnnSh5wa0jUGBQx+YKCiczEdAsQ2Fyx3v56uonAkzNAQLHQ
u8Sc57MqAqZ2K9zKvjVM
=zxNB
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
