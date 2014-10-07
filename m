From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm-backlight: Turn off pwm backlight in probe
Date: Tue, 7 Oct 2014 10:06:27 +0100
Message-ID: <20141007090627.GH25331@lee--X1>
References: <1412623364-14583-1-git-send-email-mpa@pengutronix.de>
 <20141007083548.GD24254@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:58756 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbaJGJGd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 05:06:33 -0400
Received: by mail-ie0-f178.google.com with SMTP id rl12so4950020iec.37
        for <linux-pwm@vger.kernel.org>; Tue, 07 Oct 2014 02:06:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141007083548.GD24254@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Markus Pargmann <mpa@pengutronix.de>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

On Tue, 07 Oct 2014, Thierry Reding wrote:

> On Mon, Oct 06, 2014 at 09:22:44PM +0200, Markus Pargmann wrote:
> > The backlight will be enabled by the panel again if it is used. So =
we
> > can save the default brightness and disable the pwm backlight when
> > probing.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/video/backlight/pwm_bl.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backl=
ight/pwm_bl.c
> > index 336b83be7e2d..b4f433a6f106 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -317,9 +317,11 @@ static int pwm_backlight_probe(struct platform=
_device *pdev)
> >  		data->dft_brightness =3D data->max_brightness;
> >  	}
> > =20
> > -	bl->props.brightness =3D data->dft_brightness;
> > +	bl->props.brightness =3D 0;
> >  	backlight_update_status(bl);
> > =20
> > +	bl->props.brightness =3D data->dft_brightness;
> > +
> >  	platform_set_drvdata(pdev, bl);
> >  	return 0;
> > =20
>=20
> It would be nice if it was that easy. But we can't do this, because i=
t
> will regress for users of this driver that don't use a panel or DRM. =
If
> the PWM backlight driver is used for example in conjunction with a pl=
ain
> fbdev driver it isn't necessarily hooked up with anything and won't b=
e
> enabled automatically. That's really bad if fbdev is the only output =
you
> have since you'd have to blindly type the commands to enable the
> backlight. Furthermore disabling backlight isn't always what you want=
 to
> do. For example if the bootloader already turned it on and you hand o=
ver
> from bootloader to kernel in a seamless way, then you absolutely want=
 to
> keep backlight on all the time.
>=20
> See also[0] for a different proposal to solve the same problem. Back =
at
> the time that received only a very few replies, but it would be nice =
if
> Lee and Bryan could look at it again and see if we can come up with s=
ome
> way to deal with this situation.

I don't have any experience with this stuff.  Jingoo and Bryan are the
_real_ reviewers for Backlight.  I just maintain the patches.  That
and I'm already swamped with MFD.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
