From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
Subject: Re: [PATCH 3/6] pwm: sun4i: Add a quirk for bus clock
Date: Sat, 27 Jul 2019 16:15:49 +0200
Message-ID: <2870898.N5hf0jI4cO@jernej-laptop>
References: <20190726184045.14669-1-jernej.skrabec@siol.net> <20190726184045.14669-4-jernej.skrabec@siol.net> <20190727104628.jsdvpxvcpzru75v5@flea.home>
Reply-To: jernej.skrabec-gGgVlfcn5nU@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDQNBWPU7YERBF5Z6HUQKGQED7Y65JY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190727104628.jsdvpxvcpzru75v5-YififvaboMKzQB+pC5nmwQ@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Dne sobota, 27. julij 2019 ob 12:46:28 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> On Fri, Jul 26, 2019 at 08:40:42PM +0200, Jernej Skrabec wrote:
> > H6 PWM core needs bus clock to be enabled in order to work.
> > 
> > Add a quirk for it.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> > ---
> > 
> >  drivers/pwm/pwm-sun4i.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 1b7be8fbde86..7d3ac3f2dc3f 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -72,6 +72,7 @@ static const u32 prescaler_table[] = {
> > 
> >  };
> >  
> >  struct sun4i_pwm_data {
> > 
> > +	bool has_bus_clock;
> > 
> >  	bool has_prescaler_bypass;
> >  	bool has_reset;
> >  	unsigned int npwm;
> > 
> > @@ -79,6 +80,7 @@ struct sun4i_pwm_data {
> > 
> >  struct sun4i_pwm_chip {
> >  
> >  	struct pwm_chip chip;
> > 
> > +	struct clk *bus_clk;
> > 
> >  	struct clk *clk;
> >  	struct reset_control *rst;
> >  	void __iomem *base;
> > 
> > @@ -382,6 +384,16 @@ static int sun4i_pwm_probe(struct platform_device
> > *pdev)> 
> >  		reset_control_deassert(pwm->rst);
> >  	
> >  	}
> > 
> > +	if (pwm->data->has_bus_clock) {
> > +		pwm->bus_clk = devm_clk_get(&pdev->dev, "bus");
> > +		if (IS_ERR(pwm->bus_clk)) {
> > +			ret = PTR_ERR(pwm->bus_clk);
> > +			goto err_bus;
> > +		}
> > +
> > +		clk_prepare_enable(pwm->bus_clk);
> > +	}
> > +
> 
> The patch itself looks fine, but you should clarify which clock is
> being used by the old driver.
> 
> My guess is that the "new" clock is actually the mod one, while the
> old one was both the clock of the register interface (bus) and the
> clock of the PWM generation logic (mod).

Well, I checked few datasheets and nowhere is explicitly stated what is the 
bus clock, but I would make same guess as you.

Anyway, since you requested that order of the clocks has to be changed, I have 
to separately obtain clocks if there is bus clock present too or not. If it 
is, both clocks have to be obtained by name, and if not, old code without name 
can be used.

Best regards,
Jernej

> 
> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
