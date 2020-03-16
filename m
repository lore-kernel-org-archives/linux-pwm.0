From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/3] pwm: renesas-tpu: Fix late Runtime PM enablement
Date: Mon, 16 Mar 2020 18:04:40 +0200
Message-ID: <20200316160440.GO4732@pendragon.ideasonboard.com>
References: <20200316103216.29383-1-geert+renesas@glider.be>
 <20200316103216.29383-3-geert+renesas@glider.be>
 <20200316160108.qylpoglfhhqvqqwt@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([213.167.242.64]:38234 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbgCPQEr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 12:04:47 -0400
Content-Disposition: inline
In-Reply-To: <20200316160108.qylpoglfhhqvqqwt@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Mon, Mar 16, 2020 at 05:01:08PM +0100, Uwe Kleine-König wrote:
> On Mon, Mar 16, 2020 at 11:32:15AM +0100, Geert Uytterhoeven wrote:
> > Runtime PM should be enabled before calling pwmchip_add(), as PWM users
> > can appear immediately after the PWM chip has been added.
> > Likewise, Runtime PM should always be disabled after the removal of the
> > PWM chip, even if the latter failed.
> > Fixes: 99b82abb0a35b073 ("pwm: Add Renesas TPU PWM driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/pwm/pwm-renesas-tpu.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> > index 4a855a21b782dea3..8032acc84161a9dd 100644
> > --- a/drivers/pwm/pwm-renesas-tpu.c
> > +++ b/drivers/pwm/pwm-renesas-tpu.c
> > @@ -415,16 +415,17 @@ static int tpu_probe(struct platform_device *pdev)
> >  	tpu->chip.base = -1;
> >  	tpu->chip.npwm = TPU_CHANNEL_MAX;
> >  
> > +	pm_runtime_enable(&pdev->dev);
> > +
> >  	ret = pwmchip_add(&tpu->chip);
> >  	if (ret < 0) {
> >  		dev_err(&pdev->dev, "failed to register PWM chip\n");
> > +		pm_runtime_disable(&pdev->dev);
> >  		return ret;
> >  	}
> >  
> >  	dev_info(&pdev->dev, "TPU PWM %d registered\n", tpu->pdev->id);
> >  
> > -	pm_runtime_enable(&pdev->dev);
> > -
> >  	return 0;
> >  }

This part looks good to me.

> >  
> > @@ -434,12 +435,10 @@ static int tpu_remove(struct platform_device *pdev)
> >  	int ret;
> >  
> >  	ret = pwmchip_remove(&tpu->chip);
> > -	if (ret)
> > -		return ret;
> >  
> >  	pm_runtime_disable(&pdev->dev);
> >  
> > -	return 0;
> > +	return ret;
> >  }
> 
> Maybe I was a bit quick with my reply to the previous patch. I wonder if
> it is right to call pm_runtime_disable if pwmchip_remove failed?

It should at least be explained in the commit message why this is the
right thing to do.

-- 
Regards,

Laurent Pinchart
