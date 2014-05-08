From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RFT] PWM: twl: actually disable twl6030 PWMs
Date: Thu, 8 May 2014 23:56:11 +0200
Message-ID: <20140508215605.GA30446@ulmo>
References: <1397035286.1002.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:35023 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744AbaEHV6K (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 8 May 2014 17:58:10 -0400
Received: by mail-ee0-f52.google.com with SMTP id e53so2097643eek.11
        for <linux-pwm@vger.kernel.org>; Thu, 08 May 2014 14:58:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397035286.1002.1.camel@phoenix>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-pwm@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2014 at 05:21:26PM +0800, Axel Lin wrote:
> Current twl6030_pwm_disable() implementation writes TWL6030_TOGGLE3_REG t=
wice,
> the second write sets TWL6030_PWMXEN bits so the PWM clock does not disab=
le.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Peter,
> I don't have this h/w handy to test.
> I'd appreciate if you can review and test this patch.
>=20
> Regards,
> Axel
>  drivers/pwm/pwm-twl.c | 8 --------
>  1 file changed, 8 deletions(-)

Applied, thanks.

Thierry

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTa/11AAoJEN0jrNd/PrOhzXEQALjLomwHuHwzZ4/fx8wsx0WI
0n0j0qtxEaXqyJsec4yVD+lLxRzpmyKw4CFtjQQ9siuvjJ90avh8gRvvs8z3e7DO
UfT7EHK/zsCUdiYITUU9XhYs1wcbxULkYeLrX1Tx3jAXozjOCt6Qq90t4OyTRae/
yOkOSPLn4G0O9h7yJG5XeW1hYL/w3qoSiyX8naknwpNNycdd2V6FNKaJ2DoluRju
fr7JTZboUWm7fAplGt/QiC2z2B/2o8PCyJJnR8AOj0g25CZu0vcWquN+UU5F3u++
w6sDtFJoL9FtxltNVniv892e7UUGaivGqXgIt4CrgF80Y6StJn7dIUEjZhaDKjsN
FRZCVab4YKhnuETDmh1SU2ykqlNcXq/vnXdQYG5mglaOTW3hHG3YSgZKyU0asbg1
mQUc2hfgjG22Pr47aOeZL2qfC5855PUSew7JVgyCouO86kHsyF4WNFdqOkQYmSAT
u+4D1+JJ2/cPZ25r1pCt88yeKP7Uv/EIM/DQBFqALK3V54eQo3mubRwKPzhaJqCI
gSdu/uMcncSzinP+adqT8Gwvl4OUcEayfC0FPspfvxBRYXF5SIB3gCDlZE3a0u+V
8sUkifznxGUjnuomUBEc+NmGMjMgtlTHjzSpctqzjOkpL63K0pAhTqihkN06S0Dj
PbbyO+vKloIBQYFRt1XF
=TcZn
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
