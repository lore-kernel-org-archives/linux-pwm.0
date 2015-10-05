From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: pwm: reject legacy pwm request for device
 defined in dt
Date: Mon, 5 Oct 2015 13:46:30 +0100
Message-ID: <20151005124630.GC17172@x1>
References: <1434292172-22129-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <20150921232225.GF11284@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33926 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbbJEMqe (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2015 08:46:34 -0400
Received: by wicfx3 with SMTP id fx3so118033430wic.1
        for <linux-pwm@vger.kernel.org>; Mon, 05 Oct 2015 05:46:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150921232225.GF11284@x1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, 22 Sep 2015, Lee Jones wrote:

> On Sun, 14 Jun 2015, Vladimir Zapolskiy wrote:
>=20
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
> > ---
> >  drivers/video/backlight/pwm_bl.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> Applied, thanks.

Slight change of plan, as the patch does not apply.

Please rebase it on top of the backlight tree and resubmit with my
Ack.

> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backl=
ight/pwm_bl.c
> > index 57cb9ec..9991cdb 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -271,15 +271,16 @@ static int pwm_backlight_probe(struct platfor=
m_device *pdev)
> >  	}
> > =20
> >  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
> > -	if (IS_ERR(pb->pwm)) {
> > +	if (IS_ERR(pb->pwm) && !pdev->dev.of_node) {
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
> > +		dev_err(&pdev->dev, "unable to request PWM\n");
> > +		ret =3D PTR_ERR(pb->pwm);
> > +		goto err_alloc;
> >  	}
> > =20
> >  	dev_dbg(&pdev->dev, "got pwm for backlight\n");
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
