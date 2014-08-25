From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: lpss: make it buildable only on X86
Date: Mon, 25 Aug 2014 11:45:09 +0200
Message-ID: <20140825094508.GD2399@ulmo>
References: <1408959511-4360-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:56754 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975AbaHYJpM (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Aug 2014 05:45:12 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so13077045wgh.32
        for <linux-pwm@vger.kernel.org>; Mon, 25 Aug 2014 02:45:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408959511-4360-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 12:38:31PM +0300, Andy Shevchenko wrote:
> There is no sign of this IP block on non-x86 architectures and rather wil=
l not
> be. Thus, make this explicit by applying a direct dependency to X86.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0907416..3865dfb 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -150,6 +150,7 @@ config PWM_LPC32XX
> =20
>  config PWM_LPSS
>  	tristate "Intel LPSS PWM support"
> +	depends on X86
>  	help
>  	  Generic PWM framework driver for Intel Low Power Subsystem PWM
>  	  controller.

Applied, thanks.

Thierry

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT+wWkAAoJEN0jrNd/PrOhTuoQAJfAX2bBSmieDM8Sqsvdi1ho
okHM8T2yFCh5PySdicETzUVaZHT0CFxzyK9xPlhJmMEpoVi0FpTmGJWpJaex4Gy0
Gj5PIYEGivMyeWiPMGL9Q5lS6Y01Xldk2vvwYwhtmoxT67pnav86GOFG/I6Iyj2t
rE+1hUfjIojcHHLulGMHycpPnQcnnu0xi8fQnBm+l9yjk67/N/hCgz27bgTePItP
spfmlbge4qvqmoV2HWb6ej8TnSq0ErXv5tMZf8neYWyo2iE1bSF2Hc95iTIgxBST
Fr9LTeyfZ8zwLtHWSMWn4ypCCg891DlocIyjJr9Yq8+J9wjCLbaNsROYkEcSl0wC
9aKtIXlVtdKb//ca4TSLkzvzxkzfQoEyUWaPQb5EHEltPfJqt82W5nYxI+DLvjvc
0tZdQYF8DQxWCosAHZnkRa6OFcb8qWzNvXnrLxLmtr0a3fAleLr18B5NsEX8MiM8
y3w5LpojqG9v+d4GYa0BPJwqSDr09vWJ1x/XtSDaRHiJSBKrGmQ55Nsn713Rwu8l
FlEE6EZBnaEKqSqXNa+qAkSuGZrw5uUNBXYt8QjcGR1fJ7nI2L3059hhm4firSTX
IYrO2v0ykJVqkNnflF/JLxqkeWsS7i9P0ob6fWI5kw6ftiu+0tFx01LLs0dmLF9d
LTQK1UV8TE565VB4oFvk
=WDtF
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
