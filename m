From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 04/14] pwm: rockchip: Add support for hardware readout
Date: Tue, 7 Jun 2016 10:26:19 -0700
Message-ID: <20160607172619.GB130037@google.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-5-git-send-email-boris.brezillon@free-electrons.com>
 <20160603202006.GC124478@google.com>
 <20160604082426.493b220d@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160604082426.493b220d@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com
List-Id: linux-pwm@vger.kernel.org

On Sat, Jun 04, 2016 at 08:24:26AM +0200, Boris Brezillon wrote:
> On Fri, 3 Jun 2016 13:20:06 -0700 Brian Norris <briannorris@chromium.org> wrote:
> > On Fri, Jun 03, 2016 at 10:23:02AM +0200, Boris Brezillon wrote:
> > > @@ -75,6 +77,19 @@ static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip,
> > >  	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
> > >  }
> > >  
> > > +static void rockchip_pwm_get_state_v1(struct pwm_chip *chip,
> > > +				      struct pwm_device *pwm,
> > > +				      struct pwm_state *state)
> > > +{
> > > +	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
> > > +	u32 enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
> > > +	u32 val;
> > > +
> > > +	val = readl(pc->base + pc->data->regs.ctrl);  
> > 
> > Nit: I just noticed you've been starting to use readl()/writel() in this
> > series, where previously {readl,writel}_relaxed() were being used. Any
> > reason?
> 
> Because I'm lazy and usually don't take the time to think whether it's
> safe of not to use the _relaxed() versions :-). Not sure you'll have a
> noticeable improvement by using _relaxed() for a PWM device by the
> way, but I can change that ;-).

I just figured consistency would be nice.

Brian
