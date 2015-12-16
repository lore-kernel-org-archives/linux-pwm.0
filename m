From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/3] pwm: bcm2835: improve clock handling
Date: Wed, 16 Dec 2015 16:38:09 +0100
Message-ID: <20151216153809.GC28947@ulmo>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34131 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965505AbbLPPiM (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Dec 2015 10:38:12 -0500
Received: by mail-wm0-f49.google.com with SMTP id l126so45046464wml.1
        for <linux-pwm@vger.kernel.org>; Wed, 16 Dec 2015 07:38:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Remi Pommarel <repk@triplefau.lt>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 01, 2015 at 10:55:38PM +0000, Stefan Wahren wrote:
> With the upcoming PWM clock support the pwm-bcm2835 should take
> more care about the clock handling. But this patch series doesn't
> depend on these clock driver changes.
>=20
> Stefan Wahren (3):
>   pwm: bcm2835: calculate scaler in pwm_config
>   pwm: bcm2835: prevent division by zero
>   pwm: bcm2835: fix email address specifiction
>=20
>  drivers/pwm/pwm-bcm2835.c |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

All three patches applied with Eric's Reviewed-by, thanks.

Thierry

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWcYVcAAoJEN0jrNd/PrOhCj4P/ihDanEUZ0Gyhn7RHF/fcf0t
JPgy7S7LcHvWwGM1JiT5dgJgHXqiE8WO14uzwQy9pMTfPe28Vh/WpVgBmdNhwDoQ
AHkK+mFFrRmN5QQmDm5XacFg09axuof/0YGhwt7kkxM3ypI3UA6VE/WePi6ePNp2
svujwjGmDlklK/KmfuXWSlevOnmTyrdnfEmJIa3TKbm74npsdMkHaFae/NlrV/Y2
PTMaJIGGoRnIkJtxHwzHKkGkbqX8oFI+zqzbMDhLoiEnrtCGfpS4mqBtwEQqE1/E
Lm04ObBCZkVQIT/vbKOs10WnwFEcFfrQkeOi7GcFsqUOBpmUZtJ9KWAMljEl3XQX
5CK9o0GuYT3zicbyBAUObYCT1ehoyULCoraDHY6PRMoca8P3Vaifu/QycsgkJ9XO
G3GufAd91lN2xQT2uC9CATFSZN/IZGoTfgkgQYeA5cho/9SWrB9QbkWOrxHwQCli
q1pnvhdV9e5vA6Q3waZCzzUyvE5XmPWbpPDRhLV28TAU0QPnJcs9j88FnRQLJf0l
fQ0xwDHkVvMnfu90BWI2vOCbcTeqhbT4rxt9Rf2cj5G2lMH6dAL7KwsdjnjxtcN5
bOct92olr5NADdUjfn13JHYd2yh1XW/zBsXSyOFHjkiCGFsy1LLrYsznsy/AFHef
H7AKecablkZhDfpxG7kp
=g6Hc
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
