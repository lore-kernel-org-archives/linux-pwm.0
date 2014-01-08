From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] pwm: core: Use devm_kzalloc instead of kzalloc
Date: Wed, 8 Jan 2014 04:58:31 +0000
Message-ID: <1af212b11abb47b9bf97dea7329f1151@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1389074700-1825-1-git-send-email-Li.Xiubo@freescale.com>
 <20140107080127.GD20074@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bl2lp0208.outbound.protection.outlook.com ([207.46.163.208]:37240
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750796AbaAHE6r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jan 2014 23:58:47 -0500
In-Reply-To: <20140107080127.GD20074@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> >  drivers/pwm/core.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 2ca9504..74c9f9a 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -80,7 +80,6 @@ static void free_pwms(struct pwm_chip *chip)
> >
> >  	bitmap_clear(allocated_pwms, chip->base, chip->npwm);
> >
> > -	kfree(chip->pwms);
> >  	chip->pwms = NULL;
> >  }
> >
> > @@ -245,7 +244,9 @@ int pwmchip_add(struct pwm_chip *chip)
> >  	if (ret < 0)
> >  		goto out;
> >
> > -	chip->pwms = kzalloc(chip->npwm * sizeof(*pwm), GFP_KERNEL);
> > +	chip->pwms = devm_kzalloc(chip->dev,
> > +				  chip->npwm * sizeof(*pwm),
> > +				  GFP_KERNEL);
> >  	if (!chip->pwms) {
> >  		ret = -ENOMEM;
> >  		goto out;
> 
> Is it guaranteed that pwmchip_add()/free_pwms() will only be called in
> probe() and remove() paths? It is probably safe assumption, but maybe it
> should be mentioned in comments now that we definitely have this
> restricion.
>

Yes, for now they are.
 
Thanks.

--
Best Regards,
Xiubo
