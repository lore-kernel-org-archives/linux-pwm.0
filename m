From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] drivers: pwm: pwm-atmel: implement suspend/resume
 functions
Date: Mon, 10 Apr 2017 18:01:37 +0200
Message-ID: <20170410180137.6b4f3a74@bbrezillon>
References: <1491834020-3194-1-git-send-email-claudiu.beznea@microchip.com>
 <20170410163558.494cf9be@bbrezillon>
 <20170410151011.GA18753@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170410151011.GA18753@ulmo.ba.sec>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, Claudiu Beznea <claudiu.beznea@microchip.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Mon, 10 Apr 2017 17:10:11 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Mon, Apr 10, 2017 at 04:35:58PM +0200, Boris Brezillon wrote:
> > On Mon, 10 Apr 2017 17:20:20 +0300
> > Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
> >   
> > > Implement suspend and resume power management specific
> > > function to allow PWM controller to correctly suspend
> > > and resume.
> > > 
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > > ---
> > >  drivers/pwm/pwm-atmel.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 81 insertions(+)
> > > 
> > > diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> > > index 530d7dc..75177c6 100644
> > > --- a/drivers/pwm/pwm-atmel.c
> > > +++ b/drivers/pwm/pwm-atmel.c
> > > @@ -58,6 +58,8 @@
> > >  #define PWM_MAX_PRD		0xFFFF
> > >  #define PRD_MAX_PRES		10
> > >  
> > > +#define PWM_MAX_CH_NUM		(4)
> > > +
> > >  struct atmel_pwm_registers {
> > >  	u8 period;
> > >  	u8 period_upd;
> > > @@ -65,11 +67,18 @@ struct atmel_pwm_registers {
> > >  	u8 duty_upd;
> > >  };
> > >  
> > > +struct atmel_pwm_pm_ctx {
> > > +	u32 cmr;
> > > +	u32 cdty;
> > > +	u32 cprd;
> > > +};
> > > +
> > >  struct atmel_pwm_chip {
> > >  	struct pwm_chip chip;
> > >  	struct clk *clk;
> > >  	void __iomem *base;
> > >  	const struct atmel_pwm_registers *regs;
> > > +	struct atmel_pwm_pm_ctx ctx[PWM_MAX_CH_NUM];  
> > 
> > Hm, I'm pretty sure you can rely on the current PWM state and call
> > atmel_pwm_apply() at resume time instead of doing that. See what I did
> > here [1].
> > 
> > Thierry, maybe it's time to start thinking about a generic solution to
> > save/restore PWM states.  
> 
> Generally speaking I think applying the states are the right way to go.
> Ideally the PWM core could simply resume all of the PWM channels that a
> device exports and the ->apply() callback would be enough to restore
> that. I'm not sure if that's going to work with current implementations,
> though. Your pwm-atmel-hlcdc patch certainly indicates that we're not
> quite there yet.
> 
> On the other hand, I'm beginning to think that maybe PWMs are too low-
> level for this kind of suspend/resume. For example if you use the PWM to
> control a backlight brightness, restoring it via the driver core's
> resume hook is potentially going to turn it back on at the wrong time. I
> have a feeling that we might be better off just pushing this up to the
> PWM users. A slight special case might be sysfs, for which no external
> user driver exists. But we already have separate data structures to keep
> track of sysfs-related context, so suspend/resume support could be added
> there.

Yep, you're probably right, we should let the PWM user take care of
re-applying the PWM state, because it's the only one having enough
knowledge about what the PWM is really driving to take a wise decision.

This goes against my patch adding suspend/resume hooks to the
pwm-atmel-hlcdc driver, but we can easily drop the call to
atmel_hlcdc_pwm_apply() in ->resume() once we have patched the
pwm-backlight driver to take care of that.
