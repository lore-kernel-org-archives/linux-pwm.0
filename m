From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] backlight: pwm: handle EPROBE_DEFER while requesting the
 PWM
Date: Thu, 12 Mar 2015 08:49:02 +0100
Message-ID: <20150312074859.GA30344@ulmo.nvidia.com>
References: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:39421 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955AbbCLHtH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2015 03:49:07 -0400
Content-Disposition: inline
In-Reply-To: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, lee.jones@linaro.org, jg1.han@samsung.com, linux-kernel@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2015 at 10:30:14AM +0100, Nicolas Ferre wrote:
> When trying to request the PWM device with devm_pwm_get(), the EPROBE_DEF=
ER
> flag is not handled properly. It can lead to the PWM not being found.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVAUTnAAoJEN0jrNd/PrOhNqUQALu+6/C/KKFeliOomDZz+M4V
x8CuUp8fLmZoKtrlExD/aCse7NFPREVaXZ1kG6Vz+lC4Ly6AJ2zXKadiVrUw63dA
KGvsTgI5x6XI3VVfsa5jmkvYGhVi9RkHwCuDutTjm+EYTY2v0Zb86JnGKKrCpVYd
RWEqUPuRroZWptk9TJRW6qHDs9+zTl+2B5rukoKRLwIskwmvyCCTRWLDO/n1tgbr
WeWFQgDepEKLj7Ck2TfIpbN+NCNnHSS8nNz1bfXWc3zJy12yJFxFmFhclv78OhX8
MrkWatL8O2a+O/NcWQiNAojxuXaL5FE/eHUyXL3IME15JluUvp2pQhgTy+cvp1hp
eg47wV7BSxFbp49ut3E/9ZqG07hnqz+09VcWKcK7wFwL7fXCydBszkg1c8rW/oe4
UHzTrrbXdCz4dKhyPzP1l4ADdaSsP1IJX8ZkcHT2Ja7THyIQI1w0RxWZVyiWy1td
VkvOw9cpuEBLOYv5+EFzDQeS00sxxATQz/6FJSsdc1VDc6k+XkYoDzJ0BVghtXUV
C+6hrRg5kSbktu1W46WaBH8i40/NDDm2gBVUPo+z1A1kzxXUCslkCw61Uhb3s/Nv
/TdAtnOFJRlwihMGIRKc3cVuHgsOja7y3mVewcTssJsxwWgmmel2Emzuywd/ZNRS
6Hm0EPvPrqiCltS+DoZb
=Ifl7
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
