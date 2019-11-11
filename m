From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/4] pwm: omap-dmtimer: remove pwmchip in .remove before
 making it unfunctional
Date: Mon, 11 Nov 2019 21:00:05 +0100
Message-ID: <20191111200005.c37mecp44idxskjq@pengutronix.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <dd3fe743-ee4a-153a-c044-40587568a494@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dd3fe743-ee4a-153a-c044-40587568a494@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Neil Brown <neilb@suse.de>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de, Neil Armstrong <narmstrong@baylibre.com>
List-Id: linux-pwm@vger.kernel.org

Hello Markus,

On Mon, Nov 11, 2019 at 02:30:42PM +0100, Markus Elfring wrote:
> > In the old code (e.g.) mutex_destroy() was called before
> > pwmchip_remove(). Between these two calls it is possible that a pwm
> > callback is used which tries to grab the mutex.
> 
> How do you think about to add a more “imperative mood” for your
> change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c#n151

I described the old behaviour and like my wording.

> > +++ b/drivers/pwm/pwm-omap-dmtimer.c
> > @@ -351,6 +351,11 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
> >  static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
> >  {
> >  	struct pwm_omap_dmtimer_chip *omap = platform_get_drvdata(pdev);
> > +	int ret;
> > +
> > +	ret = pwmchip_remove(&omap->chip);
> > +	if (ret)
> > +		return ret;
> >
> >  	if (pm_runtime_active(&omap->dm_timer_pdev->dev))
> >  		omap->pdata->stop(omap->dm_timer);
> 
> How do you think about to use the following statement variant?
> 
> +	int ret = pwmchip_remove(&omap->chip);

I think that between the declarations and code should be an empty line
and between the assignment to ret and the respective check there
shouldn't be one.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
