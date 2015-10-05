From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] Revert "backlight: pwm: Handle EPROBE_DEFER while
 requesting the PWM"
Date: Mon, 5 Oct 2015 11:35:43 +0200
Message-ID: <20151005093543.GB30219@ulmo>
References: <1443295482-18687-1-git-send-email-robert.jarzmik@free.fr>
 <87bncjemdk.fsf@belgarion.home>
 <560CE816.1060307@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34487 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbbJEJfq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2015 05:35:46 -0400
Content-Disposition: inline
In-Reply-To: <560CE816.1060307@atmel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, linux-pwm@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2015 at 10:00:22AM +0200, Nicolas Ferre wrote:
> Le 30/09/2015 21:29, Robert Jarzmik a =C3=A9crit :
> > Robert Jarzmik <robert.jarzmik@free.fr> writes:
> >=20
> >> This reverts commit 68feaca0b13e453aa14ee064c1736202b48b342f.
> >> This commit breaks legacy platforms, for which :
> >>  (a) no pwm table is added (legacy platforms)
> >>  (b) in this case, in pwm_get(), pmw_lookup_list is empty, and therefo=
re
> >>      chosen =3D=3D NULL, and therefore pwm_get() returns NULL, and pwm=
_get()
> >>      returns -EPROBE_DEFER
> >>  (c) as a consequence, this code is unreachable in pwm_bl.c :
> >>      if (IS_ERR(pb->pwm)) {
> >> 	ret =3D PTR_ERR(pb->pwm);
> >>  	dev_info(&pdev->dev, "%s:%d(): %d\n", __func__, __LINE__, ret);
> >>  	if (ret =3D=3D -EPROBE_DEFER)
> >>  		goto err_alloc;
> >>
> >>  	dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
> >>  	pb->legacy =3D true;
> >>  	pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
> >>
> >> As this code is unreachable, all legacy platforms relying on pwm_id are
> >> broken, amongst which pxa have been tested as broken.
> >>
> >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > Thierry, would you have a look please ?
> > As I said before, all legacy platform relying on pwm_id are broken. I'd=
 like to
> > be sure this lands in the next -rc series.
>=20
> Well, as I answered on the linux-pwm mailing-list (I was not in copy) her=
e:
> http://article.gmane.org/gmane.linux.pwm/2744
> I wonder if it's not easier to fix the platforms and add the pwm tables...
>=20
> Otherwise, Boris proposed this fix:
> 8<-----------------------------------------------------------
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index eff379b..00483d4 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -273,15 +273,15 @@ static int pwm_backlight_probe(struct platform_devi=
ce *pdev)
>  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
>  	if (IS_ERR(pb->pwm)) {
>  		ret =3D PTR_ERR(pb->pwm);
> -		if (ret =3D=3D -EPROBE_DEFER)
> -			goto err_alloc;
> =20
>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
>  		pb->legacy =3D true;
>  		pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
>  		if (IS_ERR(pb->pwm)) {
>  			dev_err(&pdev->dev, "unable to request legacy PWM\n");
> -			ret =3D PTR_ERR(pb->pwm);
> +			if (ret !=3D -EPROBE_DEFER)
> +				ret =3D PTR_ERR(pb->pwm);
> +
>  			goto err_alloc;
>  		}
>  	}
>=20
> which is not tested and may add an extra non-valid error log.

This is a little risky in my opinion. Not only does it print two error
messages for non-legacy platforms (that would be another regression if
you want to be nit-picking), but it is subtly buggy. If you have a
system with multiple PWM providers, you could end up failing the first
pwm_get() with -EPROBE_DEFER but then continue to the legacy case, and
this could succeed because data->pwm_id =3D=3D 0, and that other provider
could be exporting the PWM with this ID. If I remember correctly this
was one of the reasons why the offending commit was merged in the first
place.

I'm afraid that fixing up the legacy platforms to use PWM lookup tables
will be the only proper fix that doesn't risk breaking everyone else. I
sent out patches to do that for PXA a couple of minutes ago. Looking at
the history of the pwm-pxa driver it seems like quite a few PXA boards
must have been broken ever since v3.6 because of the PWM ID assignment
mismatch, and those should be fixed with the patches I sent as well.

Thierry

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWEkRsAAoJEN0jrNd/PrOh8pwP/1XUYdGsmkIYDQfyfwM0fjRd
EqAfnJlU2emKAUlxnOhmDMlEk4UIadTZMX+/0xVlb7NK0zb8kLR9Go6o+tJAlZj6
XluAV+6Z3zfBPIYNv2nvJqxjyu9wm8uJ6Zlp/B2ENbjCwylsmfLNDXRKQkqEzhcY
Fk/7wTYsvQBbpIbJY6/MAd+sc4sg7dbhd7B2+TDrlJcgNUnDn3OCXg+gRJJJMuzA
1GjGAk/ZQhhLRYlZBrhYDxkOmbjNtZ4Q0RAEuAWqU5Bu+kahuU4tIwllv1gUZPU1
gOQ8FP0nc86YI8SIp4Vw5h/LwLux0Uh4lUn/Qz/nxw4SQ4rbmjEtgFqXzuwXnASH
kBvwI63lEllnntcYpULzTHjZtjyaNYI9rq2ItGK2WqC23GwkOwo+x+KrBAmoZm2n
xogH3iHD1dg4/0/swHcDMq0+U7G8AP9CGoeNNMEx+ipUrPUms5RjkQ60kYNVZg6R
RDfdAVK3H0r17cjdAU1JDsZZQzMktJZXOl4RvOwGy1YHKevTCG2YEgwevrKiFnTG
jMHVzPicHrke/LWDHF+PpVwXYB0q6ec1MV5CHRKGNhQrC1WcOz7VGbnY59TkU6r8
CRSBeK3+Gqub0hdYDoqCseua+XrPDbPCuGZK8ksilFOXidh8T8HYAEiLnSABcFF+
rd8yCmlJ8Ha8bYwqVikZ
=ZUyI
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
