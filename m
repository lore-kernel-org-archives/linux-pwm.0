From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 3/6] pwm: sun4i: Add a quirk for bus clock
Date: Sat, 27 Jul 2019 22:27:24 +0800
Message-ID: <CAGb2v67h3Y1rhCSF-MTmVBOEnbWZKvvFg5DzGUWPqcxLcv-6tg@mail.gmail.com>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-4-jernej.skrabec@siol.net> <20190727104628.jsdvpxvcpzru75v5@flea.home>
Reply-To: wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBW566HUQKGQEVDTM4YI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190727104628.jsdvpxvcpzru75v5-YififvaboMKzQB+pC5nmwQ@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Sat, Jul 27, 2019 at 6:46 PM Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> Hi,
>
> On Fri, Jul 26, 2019 at 08:40:42PM +0200, Jernej Skrabec wrote:
> > H6 PWM core needs bus clock to be enabled in order to work.
> >
> > Add a quirk for it.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 1b7be8fbde86..7d3ac3f2dc3f 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -72,6 +72,7 @@ static const u32 prescaler_table[] = {
> >  };
> >
> >  struct sun4i_pwm_data {
> > +     bool has_bus_clock;
> >       bool has_prescaler_bypass;
> >       bool has_reset;
> >       unsigned int npwm;
> > @@ -79,6 +80,7 @@ struct sun4i_pwm_data {
> >
> >  struct sun4i_pwm_chip {
> >       struct pwm_chip chip;
> > +     struct clk *bus_clk;
> >       struct clk *clk;
> >       struct reset_control *rst;
> >       void __iomem *base;
> > @@ -382,6 +384,16 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
> >               reset_control_deassert(pwm->rst);
> >       }
> >
> > +     if (pwm->data->has_bus_clock) {
> > +             pwm->bus_clk = devm_clk_get(&pdev->dev, "bus");
> > +             if (IS_ERR(pwm->bus_clk)) {
> > +                     ret = PTR_ERR(pwm->bus_clk);
> > +                     goto err_bus;
> > +             }
> > +
> > +             clk_prepare_enable(pwm->bus_clk);
> > +     }
> > +
>
> The patch itself looks fine, but you should clarify which clock is
> being used by the old driver.
>
> My guess is that the "new" clock is actually the mod one, while the
> old one was both the clock of the register interface (bus) and the
> clock of the PWM generation logic (mod).

The H6 datasheet explicitly states:

    The clock source of PWM is OSC24M. The PWM is on APB1 Bus. Ensure
    that open APB1 Bus gating and de-assert reset signal when accessed
    to the PWM.

Older datasheets do not have anything about bus gating or resets. However
with slightly newer ones that have a system bus tree diagram, we can see
that PWM is on APB1 (or APB0/APBS for R_PWM). We can assume there is no
bus gate and thus it is directly attached to APB1, and that we never
modeled this part.

So the new clock is definitely the bus gate. You might want to introduce
a patch renaming sun4i_pwm_data.clk to sun4i_pwm_data.mod_clk before this
one.

ChenYu
