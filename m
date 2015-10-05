From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] Revert "backlight: pwm: Handle EPROBE_DEFER while
 requesting the PWM"
Date: Mon, 5 Oct 2015 14:58:03 +0200
Message-ID: <20151005125803.GA30025@ulmo>
References: <1443295482-18687-1-git-send-email-robert.jarzmik@free.fr>
 <87bncjemdk.fsf@belgarion.home>
 <560CE816.1060307@atmel.com>
 <20151005093543.GB30219@ulmo>
 <20151005131912.4da38169@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:32883 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbbJEM6G (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2015 08:58:06 -0400
Content-Disposition: inline
In-Reply-To: <20151005131912.4da38169@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2015 at 01:19:12PM +0200, Boris Brezillon wrote:
> Hi Thierry,
>=20
> On Mon, 5 Oct 2015 11:35:43 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Thu, Oct 01, 2015 at 10:00:22AM +0200, Nicolas Ferre wrote:
> > > Le 30/09/2015 21:29, Robert Jarzmik a =C3=A9crit :
> > > > Robert Jarzmik <robert.jarzmik@free.fr> writes:
> > > >=20
> > > >> This reverts commit 68feaca0b13e453aa14ee064c1736202b48b342f.
> > > >> This commit breaks legacy platforms, for which :
> > > >>  (a) no pwm table is added (legacy platforms)
> > > >>  (b) in this case, in pwm_get(), pmw_lookup_list is empty, and the=
refore
> > > >>      chosen =3D=3D NULL, and therefore pwm_get() returns NULL, and=
 pwm_get()
> > > >>      returns -EPROBE_DEFER
> > > >>  (c) as a consequence, this code is unreachable in pwm_bl.c :
> > > >>      if (IS_ERR(pb->pwm)) {
> > > >> 	ret =3D PTR_ERR(pb->pwm);
> > > >>  	dev_info(&pdev->dev, "%s:%d(): %d\n", __func__, __LINE__, ret);
> > > >>  	if (ret =3D=3D -EPROBE_DEFER)
> > > >>  		goto err_alloc;
> > > >>
> > > >>  	dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n"=
);
> > > >>  	pb->legacy =3D true;
> > > >>  	pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
> > > >>
> > > >> As this code is unreachable, all legacy platforms relying on pwm_i=
d are
> > > >> broken, amongst which pxa have been tested as broken.
> > > >>
> > > >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > > > Thierry, would you have a look please ?
> > > > As I said before, all legacy platform relying on pwm_id are broken.=
 I'd like to
> > > > be sure this lands in the next -rc series.
> > >=20
> > > Well, as I answered on the linux-pwm mailing-list (I was not in copy)=
 here:
> > > http://article.gmane.org/gmane.linux.pwm/2744
> > > I wonder if it's not easier to fix the platforms and add the pwm tabl=
es...
> > >=20
> > > Otherwise, Boris proposed this fix:
> > > 8<-----------------------------------------------------------
> > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> > > index eff379b..00483d4 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -273,15 +273,15 @@ static int pwm_backlight_probe(struct platform_=
device *pdev)
> > >  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
> > >  	if (IS_ERR(pb->pwm)) {
> > >  		ret =3D PTR_ERR(pb->pwm);
> > > -		if (ret =3D=3D -EPROBE_DEFER)
> > > -			goto err_alloc;
> > > =20
> > >  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
> > >  		pb->legacy =3D true;
> > >  		pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
> > >  		if (IS_ERR(pb->pwm)) {
> > >  			dev_err(&pdev->dev, "unable to request legacy PWM\n");
> > > -			ret =3D PTR_ERR(pb->pwm);
> > > +			if (ret !=3D -EPROBE_DEFER)
> > > +				ret =3D PTR_ERR(pb->pwm);
> > > +
> > >  			goto err_alloc;
> > >  		}
> > >  	}
> > >=20
> > > which is not tested and may add an extra non-valid error log.
> >=20
> > This is a little risky in my opinion. Not only does it print two error
> > messages for non-legacy platforms (that would be another regression if
> > you want to be nit-picking), but it is subtly buggy. If you have a
> > system with multiple PWM providers, you could end up failing the first
> > pwm_get() with -EPROBE_DEFER but then continue to the legacy case, and
> > this could succeed because data->pwm_id =3D=3D 0, and that other provid=
er
> > could be exporting the PWM with this ID. If I remember correctly this
> > was one of the reasons why the offending commit was merged in the first
> > place.
>=20
> Just for the record, when I proposed this fix to Nicolas, I clearly
> stated that this was not the way to go, and that fixing the offending
> platforms to use PWM lookup table was the only sane solution, though I
> didn't thought about the invalid PWM id case leading to buggy behavior.

As chance would have it, this bubbled to the top of my inbox today:

	http://patchwork.ozlabs.org/patch/483993/

I think that conflicts with Nicolas' -EPROBE_DEFER patch, but I think
reverting Nicolas' patch and then applying the above on top might fix
this nicely for everybody.

Thierry

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWEnPXAAoJEN0jrNd/PrOhjG4P+gJUHKoD5B9bOjIjQDclHcvR
LfuOX5I3eHn/kTW7HUOo7MhoSVmMVRBbVvh9BUZyA6eoay8CbcM/nV7WsGR+yPmH
6a5vSXrw4FqJU22iAnZ4QkAUkNXFJLvwIIqoZCZHSH2akY+veMYjhY0Yjnd6ESuc
TxqZK6BYeGp5beAISD/udkmrxcOKEiPFXq74Vt9HJRoS2nFBWiGfTXdAlPXW31AC
HJLooQJ0freGNv9F5eyYZWZKQUv4XXuT7VaVQhuvOF6GRVUu1+xMC+lo5BzzHpXv
h/tIINq7rj08iDLDBOCH63RlkM4pe6sL4JHjHnOezYRrzaIzyf5st4pW89Rm5ZVM
wYVJ7n5kUcVdJPZ17k3k88+RGaSOymCo/xEQ9Qo/N+GzUf2Gv0s3ehMp/SYbbvBQ
O1sgV2q+UidBfzK0Ju7Kmud5TFPuuMPosgLP6K2g23L/bCvqx8AZ/pBKPMSu0F0H
JNk/67VOWtqPOyKQTNmOZRF4ed8jTzHgQC90AoSPHKThLcnzMSIuG+AXzkOL9r5E
HJnjrtXSGS5xBOp/SR3PYQa6Yw+Nye8wfCyEwG6qQjR+ejiDejpdGHF/NN64Foys
+vLh/B29AqgATf6KaHtewjnrR1tvR8OlGP2wSlApcAIrChUnxH2IQVmmwUiFco+/
D9hDoaSXA7EvryBRc60W
=yide
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
