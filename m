From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] Revert "backlight: pwm: Handle EPROBE_DEFER while
 requesting the PWM"
Date: Mon, 5 Oct 2015 17:25:16 +0200
Message-ID: <20151005172516.59b3ba55@bbrezillon>
References: <1443295482-18687-1-git-send-email-robert.jarzmik@free.fr>
	<87bncjemdk.fsf@belgarion.home>
	<560CE816.1060307@atmel.com>
	<20151005093543.GB30219@ulmo>
	<20151005131912.4da38169@bbrezillon>
	<20151005125803.GA30025@ulmo>
	<20151005153024.3a245b0b@bbrezillon>
	<20151005140741.GA10625@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:33483 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750935AbbJEPZT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2015 11:25:19 -0400
In-Reply-To: <20151005140741.GA10625@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 5 Oct 2015 16:07:41 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Mon, Oct 05, 2015 at 03:30:24PM +0200, Boris Brezillon wrote:
> > On Mon, 5 Oct 2015 14:58:03 +0200
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> >=20
> > > On Mon, Oct 05, 2015 at 01:19:12PM +0200, Boris Brezillon wrote:
> > > > Hi Thierry,
> > > >=20
> > > > On Mon, 5 Oct 2015 11:35:43 +0200
> > > > Thierry Reding <thierry.reding@gmail.com> wrote:
> > > >=20
> > > > > On Thu, Oct 01, 2015 at 10:00:22AM +0200, Nicolas Ferre wrote=
:
> > > > > > Le 30/09/2015 21:29, Robert Jarzmik a =C3=A9crit :
> > > > > > > Robert Jarzmik <robert.jarzmik@free.fr> writes:
> > > > > > >=20
> > > > > > >> This reverts commit 68feaca0b13e453aa14ee064c1736202b48b=
342f.
> > > > > > >> This commit breaks legacy platforms, for which :
> > > > > > >>  (a) no pwm table is added (legacy platforms)
> > > > > > >>  (b) in this case, in pwm_get(), pmw_lookup_list is empt=
y, and therefore
> > > > > > >>      chosen =3D=3D NULL, and therefore pwm_get() returns=
 NULL, and pwm_get()
> > > > > > >>      returns -EPROBE_DEFER
> > > > > > >>  (c) as a consequence, this code is unreachable in pwm_b=
l.c :
> > > > > > >>      if (IS_ERR(pb->pwm)) {
> > > > > > >> 	ret =3D PTR_ERR(pb->pwm);
> > > > > > >>  	dev_info(&pdev->dev, "%s:%d(): %d\n", __func__, __LINE=
__, ret);
> > > > > > >>  	if (ret =3D=3D -EPROBE_DEFER)
> > > > > > >>  		goto err_alloc;
> > > > > > >>
> > > > > > >>  	dev_err(&pdev->dev, "unable to request PWM, trying leg=
acy API\n");
> > > > > > >>  	pb->legacy =3D true;
> > > > > > >>  	pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight")=
;
> > > > > > >>
> > > > > > >> As this code is unreachable, all legacy platforms relyin=
g on pwm_id are
> > > > > > >> broken, amongst which pxa have been tested as broken.
> > > > > > >>
> > > > > > >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > > > > > > Thierry, would you have a look please ?
> > > > > > > As I said before, all legacy platform relying on pwm_id a=
re broken. I'd like to
> > > > > > > be sure this lands in the next -rc series.
> > > > > >=20
> > > > > > Well, as I answered on the linux-pwm mailing-list (I was no=
t in copy) here:
> > > > > > http://article.gmane.org/gmane.linux.pwm/2744
> > > > > > I wonder if it's not easier to fix the platforms and add th=
e pwm tables...
> > > > > >=20
> > > > > > Otherwise, Boris proposed this fix:
> > > > > > 8<---------------------------------------------------------=
--
> > > > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/vid=
eo/backlight/pwm_bl.c
> > > > > > index eff379b..00483d4 100644
> > > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > > > @@ -273,15 +273,15 @@ static int pwm_backlight_probe(struct=
 platform_device *pdev)
> > > > > >  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
> > > > > >  	if (IS_ERR(pb->pwm)) {
> > > > > >  		ret =3D PTR_ERR(pb->pwm);
> > > > > > -		if (ret =3D=3D -EPROBE_DEFER)
> > > > > > -			goto err_alloc;
> > > > > > =20
> > > > > >  		dev_err(&pdev->dev, "unable to request PWM, trying legac=
y API\n");
> > > > > >  		pb->legacy =3D true;
> > > > > >  		pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
> > > > > >  		if (IS_ERR(pb->pwm)) {
> > > > > >  			dev_err(&pdev->dev, "unable to request legacy PWM\n");
> > > > > > -			ret =3D PTR_ERR(pb->pwm);
> > > > > > +			if (ret !=3D -EPROBE_DEFER)
> > > > > > +				ret =3D PTR_ERR(pb->pwm);
> > > > > > +
> > > > > >  			goto err_alloc;
> > > > > >  		}
> > > > > >  	}
> > > > > >=20
> > > > > > which is not tested and may add an extra non-valid error lo=
g.
> > > > >=20
> > > > > This is a little risky in my opinion. Not only does it print =
two error
> > > > > messages for non-legacy platforms (that would be another regr=
ession if
> > > > > you want to be nit-picking), but it is subtly buggy. If you h=
ave a
> > > > > system with multiple PWM providers, you could end up failing =
the first
> > > > > pwm_get() with -EPROBE_DEFER but then continue to the legacy =
case, and
> > > > > this could succeed because data->pwm_id =3D=3D 0, and that ot=
her provider
> > > > > could be exporting the PWM with this ID. If I remember correc=
tly this
> > > > > was one of the reasons why the offending commit was merged in=
 the first
> > > > > place.
> > > >=20
> > > > Just for the record, when I proposed this fix to Nicolas, I cle=
arly
> > > > stated that this was not the way to go, and that fixing the off=
ending
> > > > platforms to use PWM lookup table was the only sane solution, t=
hough I
> > > > didn't thought about the invalid PWM id case leading to buggy b=
ehavior.
> > >=20
> > > As chance would have it, this bubbled to the top of my inbox toda=
y:
> > >=20
> > > 	http://patchwork.ozlabs.org/patch/483993/
> >=20
> > AFAICT, this is not valid either. This patch is assuming -EPROBE_DE=
=46ER
> > can only be returned in the DT case, which is not the case: it is a=
lso
> > returned if the PWMs were declared with a lookup table but the driv=
er
> > is not registered yet (module not loaded, or driver registration
> > taking place after the PWM backlight driver).
>=20
> Right, the non-DT, slightly less legacy case...
>=20
> > If we were about to differentiate the missing PWM definition from
> > the missing driver case, we should do something like this [1].
> >=20
> > Best Regards,
> >=20
> > Boris
> >=20
> > [1]http://code.bulix.org/2oozbq-89125
>=20
> Haha, I came up with exactly this earlier and I've been trying to thi=
nk
> of ways in which it could potentially break.

=46rom a quick glance, I don't see any obvious problem in this approach=
=2E

>=20
> Thierry
>=20
> --- >8 ---
> From f7fee34e0c414b4268c59e97937c51e0c91a74cf Mon Sep 17 00:00:00 200=
1
> From: Thierry Reding <thierry.reding@gmail.com>
> Date: Mon, 5 Oct 2015 14:38:32 +0200
> Subject: [PATCH] pwm: Return -ENODEV if no PWM lookup match is found
>=20
> When looking up a PWM using the lookup table, assume that all entries
> will have been added already, so failure to find a match means that n=
o
> corresponding entry has been registered.
>=20
> This fixes an issue where -EPROBE_DEFER would be returned if the PWM
> lookup table is empty. After this fix, -EPROBE_DEFER is reserved for
> situations where no provider has yet registered for a matching entry.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Not sure it has any value since I proposed the same patch, but here
is my

Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/pwm/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 3f9df3ea3350..94e5af123660 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -719,8 +719,10 @@ struct pwm_device *pwm_get(struct device *dev, c=
onst char *con_id)
>  		}
>  	}
> =20
> -	if (!chosen)
> +	if (!chosen) {
> +		pwm =3D ERR_PTR(-ENODEV);
>  		goto out;
> +	}
> =20
>  	chip =3D pwmchip_find_by_name(chosen->provider);
>  	if (!chip)



--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
