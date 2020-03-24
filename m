From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v11 10/12] backlight: pwm_bl: Use 64-bit division function
Date: Tue, 24 Mar 2020 11:07:10 +0000
Message-ID: <20200324110710.GL5477@dell>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <17fc1dcf8b9b392d1e37dc7e3e67409e3c502840.1584667964.git.gurus@codeaurora.org>
 <20200320133123.GD5477@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54840 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgCXLGX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Mar 2020 07:06:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id c81so2689367wmd.4
        for <linux-pwm@vger.kernel.org>; Tue, 24 Mar 2020 04:06:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200320133123.GD5477@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

On Fri, 20 Mar 2020, Lee Jones wrote:

> On Thu, 19 Mar 2020, Guru Das Srinagesh wrote:
> 
> > Since the PWM framework is switching struct pwm_state.period's datatype
> > to u64, prepare for this transition by using div_u64 to handle a 64-bit
> > dividend instead of a straight division operation.
> > 
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: linux-pwm@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > 
> > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  drivers/video/backlight/pwm_bl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Can this patch be taken on its own?

Hellooooo ...

> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index efb4efc..3e5dbcf 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -625,7 +625,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >  		pb->scale = data->max_brightness;
> >  	}
> >  
> > -	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
> > +	pb->lth_brightness = data->lth_brightness * (div_u64(state.period,
> > +				pb->scale));
> >  
> >  	props.type = BACKLIGHT_RAW;
> >  	props.max_brightness = data->max_brightness;
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
