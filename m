From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL 5.5 418/542] pwm: Remove set but not set variable
 'pwm'
Date: Fri, 14 Feb 2020 16:46:00 -0500
Message-ID: <20200214214600.GB4193448@kroah.com>
References: <20200214154854.6746-1-sashal@kernel.org>
 <20200214154854.6746-418-sashal@kernel.org>
 <20200214174014.lfnhsl6d7nyfkfbm@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730578AbgBNVyb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 14 Feb 2020 16:54:31 -0500
Content-Disposition: inline
In-Reply-To: <20200214174014.lfnhsl6d7nyfkfbm@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, yu kuai <yukuai3@huawei.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On Fri, Feb 14, 2020 at 06:40:14PM +0100, Uwe Kleine-König wrote:
> Hello Sasha,
> 
> On Fri, Feb 14, 2020 at 10:46:50AM -0500, Sasha Levin wrote:
> > From: yu kuai <yukuai3@huawei.com>
> > 
> > [ Upstream commit 9871abffc81048e20f02e15d6aa4558a44ad53ea ]
> > 
> > Fixes gcc '-Wunused-but-set-variable' warning:
> > 
> > 	drivers/pwm/pwm-pca9685.c: In function ‘pca9685_pwm_gpio_free’:
> > 	drivers/pwm/pwm-pca9685.c:162:21: warning: variable ‘pwm’ set but not used [-Wunused-but-set-variable]
> > 
> > It is never used, and so can be removed. In that case, hold and release
> > the lock 'pca->lock' can be removed since nothing will be done between
> > them.
> > 
> > Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
> > Signed-off-by: yu kuai <yukuai3@huawei.com>
> > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index 168684b02ebce..b07bdca3d510d 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -159,13 +159,9 @@ static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
> >  static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
> >  {
> >  	struct pca9685 *pca = gpiochip_get_data(gpio);
> > -	struct pwm_device *pwm;
> >  
> >  	pca9685_pwm_gpio_set(gpio, offset, 0);
> >  	pm_runtime_put(pca->chip.dev);
> > -	mutex_lock(&pca->lock);
> > -	pwm = &pca->chip.pwms[offset];
> > -	mutex_unlock(&pca->lock);
> 
> Even though I bet this change won't introduce a regression, it only
> fixes a harmless warning. So I wonder if it objectively qualifies to be
> applied for stable.

See my response to another one of these types of patches.  In order
words, I agree, these aren't needed unless they are prereqs for other
real fixes.

thanks,

greg k-h
