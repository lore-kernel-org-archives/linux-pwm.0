From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH Resend 2/2] pwm: pxa: Use of_match_ptr helper
Date: Thu, 23 Jan 2014 13:48:00 +0100
Message-ID: <20140123124759.GB28527@ulmo.nvidia.com>
References: <1390474715-6587-1-git-send-email-sachin.kamat@linaro.org>
 <1390474715-6587-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:51823 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaAWMsE (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jan 2014 07:48:04 -0500
Received: by mail-bk0-f43.google.com with SMTP id mx11so331832bkb.2
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2014 04:48:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1390474715-6587-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pwm@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2014 at 04:28:35PM +0530, Sachin Kamat wrote:
> Use the helper instead of defining NULL for CONFIG_OF
> disabled case.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/pwm/pwm-pxa.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> index 8d995731cef8..685ae2c96b77 100644
> --- a/drivers/pwm/pwm-pxa.c
> +++ b/drivers/pwm/pwm-pxa.c
> @@ -19,6 +19,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/pwm.h>
> +#include <linux/of.h>
>  #include <linux/of_device.h>
> =20
>  #include <asm/div64.h>
> @@ -140,13 +141,12 @@ static struct of_device_id pwm_of_match[] =3D {
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, pwm_of_match);
> -#else
> -#define pwm_of_match NULL
>  #endif
> =20
>  static const struct platform_device_id *pxa_pwm_get_id_dt(struct device =
*dev)
>  {
> -	const struct of_device_id *id =3D of_match_device(pwm_of_match, dev);
> +	const struct of_device_id *id;
> +	id =3D of_match_device(of_match_ptr(pwm_of_match), dev);

Because of this, I find it actually more elegant to define pwm_of_match
to NULL for non-DT.

Thierry

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4Q9/AAoJEN0jrNd/PrOhkdkP/02PlStLfq25/D3u/Gtja8v4
546oeVHvoaUuUMayrC5I+FDlZRWirwb3DVB3ptJmMfPerwmnfUiHpxS0+R7M+q8T
MpgE3oG77YVKymrhYxEz+aJBO76ezq9rZefOEex4Hhi1CeGgUrfRj98WCZZkP7D4
4s9xPn1uUYSHLJUuH2dcy/uLCg1ieKlzO/YCRIw/vNhBPwVGV5Dr6Wxw03PL1iHZ
oPLQbEfYCZV74sEyl+ga9ZPefD1HjlUk02gIj+7hL7lkkY1Cb0Nts3YFYA3Tyknq
xn3PpM9xnR7o/uwvITX55qlJJahZP44SiWBQzWarxKGAbYid/Gy6GJrBRjvmP4//
fpDH2Vewz45fAHTjiydZPQ63k6qhYFXDI/1vFLMuHaEJfVhvRMuo5Id3YYHgLcCE
xed/h6J1nYhojQgyMpzyusWLLmyS6QUgwMptuGk4DpNa2IrAM8X/w2MymPMIa2TG
VBKjXF9zbhL/ZhWMyB/lda+y+YLcUiuAB+imORm1zqQ0vUvjsr3gTjx12JIBdNC+
TLH/xSjIedWhpgD4FrrDOj3/yRh7vooAxvjv00tok27Mr6/dKcUYtd2/AuA22yxl
UkRj7xiHIP6N75grBlIaSQvgKBh/9KKFbAQYjjJ2fonXPQnRjEp2jttVxjHce9+/
oCz43qtbjJKpt34gKXnh
=DV8m
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
