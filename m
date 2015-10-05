From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] Revert "backlight: pwm: Handle EPROBE_DEFER while
 requesting the PWM"
Date: Mon, 5 Oct 2015 13:19:12 +0200
Message-ID: <20151005131912.4da38169@bbrezillon>
References: <1443295482-18687-1-git-send-email-robert.jarzmik@free.fr>
	<87bncjemdk.fsf@belgarion.home>
	<560CE816.1060307@atmel.com>
	<20151005093543.GB30219@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:57790 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750821AbbJELTP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2015 07:19:15 -0400
In-Reply-To: <20151005093543.GB30219@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Thierry,

On Mon, 5 Oct 2015 11:35:43 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Thu, Oct 01, 2015 at 10:00:22AM +0200, Nicolas Ferre wrote:
> > Le 30/09/2015 21:29, Robert Jarzmik a =C3=A9crit :
> > > Robert Jarzmik <robert.jarzmik@free.fr> writes:
> > >=20
> > >> This reverts commit 68feaca0b13e453aa14ee064c1736202b48b342f.
> > >> This commit breaks legacy platforms, for which :
> > >>  (a) no pwm table is added (legacy platforms)
> > >>  (b) in this case, in pwm_get(), pmw_lookup_list is empty, and t=
herefore
> > >>      chosen =3D=3D NULL, and therefore pwm_get() returns NULL, a=
nd pwm_get()
> > >>      returns -EPROBE_DEFER
> > >>  (c) as a consequence, this code is unreachable in pwm_bl.c :
> > >>      if (IS_ERR(pb->pwm)) {
> > >> 	ret =3D PTR_ERR(pb->pwm);
> > >>  	dev_info(&pdev->dev, "%s:%d(): %d\n", __func__, __LINE__, ret)=
;
> > >>  	if (ret =3D=3D -EPROBE_DEFER)
> > >>  		goto err_alloc;
> > >>
> > >>  	dev_err(&pdev->dev, "unable to request PWM, trying legacy API\=
n");
> > >>  	pb->legacy =3D true;
> > >>  	pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
> > >>
> > >> As this code is unreachable, all legacy platforms relying on pwm=
_id are
> > >> broken, amongst which pxa have been tested as broken.
> > >>
> > >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > > Thierry, would you have a look please ?
> > > As I said before, all legacy platform relying on pwm_id are broke=
n. I'd like to
> > > be sure this lands in the next -rc series.
> >=20
> > Well, as I answered on the linux-pwm mailing-list (I was not in cop=
y) here:
> > http://article.gmane.org/gmane.linux.pwm/2744
> > I wonder if it's not easier to fix the platforms and add the pwm ta=
bles...
> >=20
> > Otherwise, Boris proposed this fix:
> > 8<-----------------------------------------------------------
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backl=
ight/pwm_bl.c
> > index eff379b..00483d4 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -273,15 +273,15 @@ static int pwm_backlight_probe(struct platfor=
m_device *pdev)
> >  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
> >  	if (IS_ERR(pb->pwm)) {
> >  		ret =3D PTR_ERR(pb->pwm);
> > -		if (ret =3D=3D -EPROBE_DEFER)
> > -			goto err_alloc;
> > =20
> >  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n"=
);
> >  		pb->legacy =3D true;
> >  		pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
> >  		if (IS_ERR(pb->pwm)) {
> >  			dev_err(&pdev->dev, "unable to request legacy PWM\n");
> > -			ret =3D PTR_ERR(pb->pwm);
> > +			if (ret !=3D -EPROBE_DEFER)
> > +				ret =3D PTR_ERR(pb->pwm);
> > +
> >  			goto err_alloc;
> >  		}
> >  	}
> >=20
> > which is not tested and may add an extra non-valid error log.
>=20
> This is a little risky in my opinion. Not only does it print two erro=
r
> messages for non-legacy platforms (that would be another regression i=
f
> you want to be nit-picking), but it is subtly buggy. If you have a
> system with multiple PWM providers, you could end up failing the firs=
t
> pwm_get() with -EPROBE_DEFER but then continue to the legacy case, an=
d
> this could succeed because data->pwm_id =3D=3D 0, and that other prov=
ider
> could be exporting the PWM with this ID. If I remember correctly this
> was one of the reasons why the offending commit was merged in the fir=
st
> place.

Just for the record, when I proposed this fix to Nicolas, I clearly
stated that this was not the way to go, and that fixing the offending
platforms to use PWM lookup table was the only sane solution, though I
didn't thought about the invalid PWM id case leading to buggy behavior.

Best Regards,

Boris

--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
