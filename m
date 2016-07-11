From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2 v2] pwm: add a driver for the STMPE PWM
Date: Mon, 11 Jul 2016 09:59:50 +0200
Message-ID: <20160711075950.GB5823@ulmo.ba.sec>
References: <1459891357-28352-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35146 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030318AbcGKH7x (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jul 2016 03:59:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so350570wmg.2
        for <linux-pwm@vger.kernel.org>; Mon, 11 Jul 2016 00:59:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1459891357-28352-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 05, 2016 at 11:22:37PM +0200, Linus Walleij wrote:
> This adds a driver for the STMPE 24xx series of multi-purpose
> I2C expanders. (I think STMPE means ST Microelectronics
> Multi-Purpose Expander.) This PWM was designed in accordance with
> Nokia specifications and is kind of weird and usually just
> switched between max and zero dutycycle. However it is indeed
> a PWM so it needs to live in the PWM subsystem.
>=20
> This PWM is mostly used for white LED backlight.
>=20
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Use pwm_is_enabled() instead of local state tracking.
> - Convert to builtin_platform_driver_probe() and tag the init
>   code with _init, we're not going modular with this driver.
> - Get rid of some pointless (u8) casts
> - Convert an if () else if () else if () ladder into a switch
>   statement.
> - Make a set of #defines for the PWM state machine instruction
>   words.
> - Don't brag about the driver being initialized.
> ChangeLog v1->v2:
> - Split off the MFD hunk from the patch: no need to worry about
>   that, it can be merged orthogonally to the MFD tree.
> ---
>  drivers/pwm/Kconfig     |   7 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-stmpe.c | 299 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 307 insertions(+)
>  create mode 100644 drivers/pwm/pwm-stmpe.c

Sorry, this went completely under my radar. I've applied it now, fixing
up some checkpatch warnings and addressing some of the comments that had
been made by Vladimir.

Linus, can you please check that the driver still works? Or if there's
anything I've changed that you think is completely wrong?

Thanks,
Thierry

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXg1HuAAoJEN0jrNd/PrOhm04P/Rbvm2FTxpySrRGFoAi1DnTa
AdEiyWD/+O6pYvdhtKkICK2U1SNihU73DVbcwloPtpJ7fOoAcWnba7qMl1gSzAf8
820I43pm27HHkxnwa+oVqmqLVpkWXTNPQD8xM0XKhcwAVdwkA5wv+5RvaM3gVu7z
V9xoCOyMF80i4HzTcJcT6HEPn6i6xKfijfPNFsmNvFwO52trSM3Uq5Ow8lLIZoE2
fiMr5R1+NGnKgKTRiK1oaznYA0ecFht+cgxB1X2+q4WdcpRxPbsQoGyzJsckgc8j
m/hrVE/HehYCcA4VuasbWTbCEuzWaqhJAizW0mIv02WsyaNZ0fc4l7WTKixrLgEk
2qz8LG4wWx9laHd9Bs8bhAIwFzPsyXAg1woG2/qSM3HMmBEyfxYO23KQ7BebpC9B
ZBTINbPDTsx/Anqp+HT6rfZlqDqmS5U7VkN3gAMvygjfXmkwHZ8Vm2X8RIopI9Eo
yzOWok5h7mw+NoolEfLYNGFxr5H/ALfs6cdG6T2r9VEBNtqh27khJGPvY1TkznJk
D1jSDWHfOOwvSdok57K/mapWGoj7ZQpH2fbr7EqKTTMfwNTLaDVYAtrQW/Kuo1kv
DfEDcwSe4V0ykEJKpDwPKHinPC5L/pjcSXAGThC6ghy7u56bHH/1KZjLsvrtucG5
eEVr3Ft4Wt2oBqNWJNry
=4qgC
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
