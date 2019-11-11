From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/4] pwm: omap-dmtimer: put_device() after
 of_find_device_by_node()
Date: Mon, 11 Nov 2019 21:09:07 +0100
Message-ID: <20191111200907.vclloogaiu3mqxsn@pengutronix.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <20191111090357.13903-3-u.kleine-koenig@pengutronix.de>
 <812c95a0-7eb6-7ad6-16fa-c9e8339ff213@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <812c95a0-7eb6-7ad6-16fa-c9e8339ff213@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pwm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Neil Brown <neilb@suse.de>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Mon, Nov 11, 2019 at 02:41:58PM +0100, Markus Elfring wrote:
> > This was found by coccicheck:
> >
> > 	drivers/pwm/pwm-omap-dmtimer.c:304:2-8: ERROR: missing put_device;
> > 	call of_find_device_by_node on line 255, but without a corresponding
> > 	object release within this function.
> 
> How do you think about to add a wording according to “imperative mood”
> for your change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c#n151

Are you a bot?

> > +++ b/drivers/pwm/pwm-omap-dmtimer.c
> …
> > @@ -352,7 +352,14 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
> …
> >  	pdata->free(dm_timer);
> > -put:
> > +err_request_timer:
> > +
> > +err_timer_property:
> > +err_platdata:
> > +
> > +	put_device(&timer_pdev->dev);
> 
> Would the use of the label “put_device” be more appropriate?
> 
> 
> > +err_find_timer_pdev:
> > +
> >  	of_node_put(timer);
> …
> 
> Would the use of the label “put_node” be better here?
> 
> 
> > @@ -372,6 +379,8 @@ static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
> >
> >  	omap->pdata->free(omap->dm_timer);
> >
> > +	put_device(&omap->dm_timer_pdev->dev);
> > +
> >  	mutex_destroy(&omap->mutex);
> >
> >  	return 0;
> 
> I suggest to omit a few blank lines.

And I like it the way it is.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
