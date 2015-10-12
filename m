From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2] backlight: pwm: reject legacy pwm request for device
 defined in dt
Date: Mon, 12 Oct 2015 15:30:29 +0200
Message-ID: <20151012153029.62f948d2@bbrezillon>
References: <1444652943-19712-1-git-send-email-vladimir_zapolskiy@mentor.com>
	<561BB2BC.9090907@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38786 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752266AbbJLNab convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Oct 2015 09:30:31 -0400
In-Reply-To: <561BB2BC.9090907@atmel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi Vladimir,

On Mon, 12 Oct 2015 15:16:44 +0200
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Le 12/10/2015 14:29, Vladimir Zapolskiy a =C3=A9crit :
> > Platform PWM backlight data provided by board's device tree should =
be
> > complete enough to successfully request a pwm device using pwm_get(=
)
> > API. This change fixes a bug, when an arbitrary (first found) PWM i=
s
> > connected to a "pwm-backlight" compatible device, when explicit PWM
> > device reference is not given.
> >=20
> > Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> > already describes "pwms" as a required property, instead of blind
> > selection of a potentially wrong PWM reject legacy PWM device
> > registration request, leave legacy API only for non-dt cases.
> >=20
> > Based on initial implementation done by Dmitry Eremin-Solenikov.
> >=20
> > Reported-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> > Acked-by: Thierry Reding <thierry.reding@gmail.com>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
>=20
> It seems good to me:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>=20
> (Adding some people to the Cc: list).
>=20
>=20
> > ---
> > The change is based on lee-backlight/for-backlight-next
> >=20
> > Changes from v1 to v2:
> > * rebased on top of Nicolas' commit
> >     68feaca0b13 ("backlight: pwm: Handle EPROBE_DEFER while request=
ing the PWM")
> >=20
> > Links to previous discussions of the change:
> > * https://patchwork.ozlabs.org/patch/483993/
> > * https://patchwork.ozlabs.org/patch/398849/
> >=20
> >  drivers/video/backlight/pwm_bl.c | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backl=
ight/pwm_bl.c
> > index eff379b..ae3c6b6 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -271,19 +271,18 @@ static int pwm_backlight_probe(struct platfor=
m_device *pdev)
> >  	}
> > =20
> >  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
> > -	if (IS_ERR(pb->pwm)) {
> > -		ret =3D PTR_ERR(pb->pwm);
> > -		if (ret =3D=3D -EPROBE_DEFER)
> > -			goto err_alloc;
> > -
> > +	if (IS_ERR(pb->pwm) && PTR_ERR(pb->pwm) !=3D -EPROBE_DEFER
> > +	    && !pdev->dev.of_node) {
> >  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n"=
);
> >  		pb->legacy =3D true;
> >  		pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
> > -		if (IS_ERR(pb->pwm)) {
> > -			dev_err(&pdev->dev, "unable to request legacy PWM\n");
> > -			ret =3D PTR_ERR(pb->pwm);
> > -			goto err_alloc;
> > -		}
> > +	}
> > +
> > +	if (IS_ERR(pb->pwm)) {
> > +		ret =3D PTR_ERR(pb->pwm);
> > +		if (ret !=3D -EPROBE_DEFER)
> > +			dev_err(&pdev->dev, "unable to request PWM\n");
> > +		goto err_alloc;
> >  	}
> > =20
> >  	dev_dbg(&pdev->dev, "got pwm for backlight\n");
> >=20
>=20
>=20

I still think it would be cleaner to do what Thierry proposed here [1].
IMO, embedding the complexity of different error cases depending on the
way PWM devices were defined (OF, pdata, ...) is rather risky and
make the code even more complicated.

Best Regards,

Boris

[1]https://lkml.org/lkml/2015/10/5/319


--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
