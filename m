Return-Path: <str@pengutronix.de>
Date: Wed, 26 Jun 2013 14:09:35 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCH] pwm: pca9685: Fix wrong argument to set MODE1_SLEEP bit
Message-ID: <20130626120935.GA9739@pengutronix.de>
References: <1371662847.5355.2.camel@phoenix>
 <20130626095106.GB27083@manwe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130626095106.GB27083@manwe>
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Axel Lin <axel.lin@ingics.com>, linux-pwm@vger.kernel.org

On Wed, Jun 26, 2013 at 11:51:07AM +0200, Thierry Reding wrote:
> On Thu, Jun 20, 2013 at 01:27:27AM +0800, Axel Lin wrote:
> > Current code actually does not set MODE1_SLEEP bit because the new value for
> > bitmask (0x1) is wrong. To set MODE1_SLEEP bit, we should pass MODE1_SLEEP
> > as the new value for bitmask.
> > 
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > ---
> > Hi Steffen,
> > I don't have this hardware, can you test if this patch works?
> > Thanks,
> > Axel
> > 
> >  drivers/pwm/pwm-pca9685.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Steffen,
> 
> are you able to test or review this? The patch seems good but I'm not
> familiar with the hardware nor do I have a board to test it on.
> 
> Thierry
> 
> > 
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index c9f9e65..3fb775d 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -190,7 +190,7 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> >  
> >  	if (--pca->active_cnt == 0)
> >  		regmap_update_bits(pca->regmap, PCA9685_MODE1, MODE1_SLEEP,
> > -				   0x1);
> > +				   MODE1_SLEEP);
> >  }
> >  
> >  static const struct pwm_ops pca9685_pwm_ops = {
> > @@ -264,7 +264,8 @@ static int pca9685_pwm_remove(struct i2c_client *client)
> >  {
> >  	struct pca9685 *pca = i2c_get_clientdata(client);
> >  
> > -	regmap_update_bits(pca->regmap, PCA9685_MODE1, MODE1_SLEEP, 0x1);
> > +	regmap_update_bits(pca->regmap, PCA9685_MODE1, MODE1_SLEEP,
> > +			   MODE1_SLEEP);
> >  
> >  	return pwmchip_remove(&pca->chip);
> >  }
> > -- 

Hi!

Looks good. I used regmap_update_bits wrong, obviously. I only provided
the value (0x1), but did not apply the correct mask to it, which this
version (with MODE1_SLEEP) does.

So, you may add my

	Reviewed-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Thank you Axel for fixing it,
Steffen


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
