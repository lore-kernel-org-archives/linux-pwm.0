From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH RESEND 2/3] pwm: kona: Add support for Broadcom iproc
 pwm controller
Date: Mon, 4 Jul 2016 15:37:12 +0200
Message-ID: <20160704153712.2117077c@bbrezillon>
References: <1459261350-23851-1-git-send-email-yendapally.reddy@broadcom.com>
 <1459261350-23851-3-git-send-email-yendapally.reddy@broadcom.com>
 <20160510144024.GA7149@ulmo.ba.sec>
 <20160623223252.6b674ca3@bbrezillon>
 <20160628125223.GA5662@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160628125223.GA5662@ulmo.ba.sec>
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Scott Branden <sbranden@broadcom.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

This is my last answer to this thread, after that I'll stop bothering
you: after all, you're the PWM subsystem maintainer, and I have nothing
to say about how you want to maintain your subsytem ;-).

On Tue, 28 Jun 2016 14:52:23 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Thu, Jun 23, 2016 at 10:32:52PM +0200, Boris Brezillon wrote:
> > Hi,
> > 
> > On Tue, 10 May 2016 16:40:24 +0200
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> >   
> > > On Tue, Mar 29, 2016 at 10:22:29AM -0400, Yendapally Reddy Dhananjaya Reddy wrote:  
> > > > Update the kona driver to support Broadcom iproc pwm controller
> > > > 
> > > > Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> > > > ---
> > > >  drivers/pwm/Kconfig        |   6 +-
> > > >  drivers/pwm/pwm-bcm-kona.c | 183 +++++++++++++++++++++++++++++++++++++++------
> > > >  2 files changed, 163 insertions(+), 26 deletions(-)
> > > > 
> > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > index c182efc..e45ea33 100644
> > > > --- a/drivers/pwm/Kconfig
> > > > +++ b/drivers/pwm/Kconfig
> > > > @@ -76,9 +76,11 @@ config PWM_ATMEL_TCB
> > > >  
> > > >  config PWM_BCM_KONA
> > > >  	tristate "Kona PWM support"
> > > > -	depends on ARCH_BCM_MOBILE
> > > > +	depends on ARCH_BCM_MOBILE || ARCH_BCM_IPROC
> > > > +	default ARCH_BCM_IPROC    
> > > 
> > > Why the default? Typically you'd enable this in one or more of the
> > > default configurations. default ARCH_* is really only useful if the
> > > driver is essential. PWM doesn't usually fall into this category.
> > >   
> > > > diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> > > > index c634183..ef152e3a 100644
> > > > --- a/drivers/pwm/pwm-bcm-kona.c
> > > > +++ b/drivers/pwm/pwm-bcm-kona.c
> > > > @@ -19,6 +19,7 @@
> > > >  #include <linux/math64.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of.h>
> > > > +#include <linux/of_device.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/pwm.h>
> > > >  #include <linux/slab.h>
> > > > @@ -47,30 +48,90 @@
> > > >  
> > > >  #define PWM_CONTROL_OFFSET			(0x00000000)
> > > >  #define PWM_CONTROL_SMOOTH_SHIFT(chan)		(24 + (chan))
> > > > -#define PWM_CONTROL_TYPE_SHIFT(chan)		(16 + (chan))
> > > > +#define PWM_CONTROL_TYPE_SHIFT(shift, chan)	(shift + chan)    
> > > 
> > > You need to put the parameters into parentheses to avoid expansion from
> > > potentially messing up the expression.
> > >   
> > > >  #define PWM_CONTROL_POLARITY_SHIFT(chan)	(8 + (chan))
> > > >  #define PWM_CONTROL_TRIGGER_SHIFT(chan)		(chan)
> > > >  
> > > >  #define PRESCALE_OFFSET				(0x00000004)
> > > > -#define PRESCALE_SHIFT(chan)			((chan) << 2)
> > > > -#define PRESCALE_MASK(chan)			(0x7 << PRESCALE_SHIFT(chan))
> > > > +#define PRESCALE_SHIFT				(0x00000004)
> > > > +#define PRESCALE_MASK				(0x00000007)    
> > > 
> > > Hmm... this looks odd. Why are you dropping the chan parameter here?
> > >   
> > > >  #define PRESCALE_MIN				(0x00000000)
> > > >  #define PRESCALE_MAX				(0x00000007)
> > > >  
> > > > -#define PERIOD_COUNT_OFFSET(chan)		(0x00000008 + ((chan) << 3))
> > > > +#define PERIOD_COUNT_OFFSET(offset, chan)	(offset + (chan << 3))    
> > > 
> > > Need parentheses here as well.
> > >   
> > > >  #define PERIOD_COUNT_MIN			(0x00000002)
> > > >  #define PERIOD_COUNT_MAX			(0x00ffffff)
> > > > +#define KONA_PERIOD_COUNT_OFFSET		(0x00000008)
> > > >  
> > > > -#define DUTY_CYCLE_HIGH_OFFSET(chan)		(0x0000000c + ((chan) << 3))
> > > > +#define DUTY_CYCLE_HIGH_OFFSET(offset, chan)	(offset + (chan << 3))
> > > >  #define DUTY_CYCLE_HIGH_MIN			(0x00000000)
> > > >  #define DUTY_CYCLE_HIGH_MAX			(0x00ffffff)
> > > > +#define KONA_DUTY_CYCLE_HIGH_OFFSET		(0x0000000c)
> > > > +
> > > > +#define PWM_CHANNEL_CNT				(0x00000006)
> > > > +#define SIGNAL_PUSH_PULL			(0x00000001)
> > > > +#define PWMOUT_TYPE_SHIFT			(0x00000010)
> > > > +
> > > > +#define IPROC_PRESCALE_OFFSET			(0x00000024)
> > > > +#define IPROC_PRESCALE_SHIFT			(0x00000006)
> > > > +#define IPROC_PRESCALE_MAX			(0x0000003f)
> > > > +
> > > > +#define IPROC_PERIOD_COUNT_OFFSET		(0x00000004)
> > > > +#define IPROC_PERIOD_COUNT_MIN			(0x00000002)
> > > > +#define IPROC_PERIOD_COUNT_MAX			(0x0000ffff)
> > > > +
> > > > +#define IPROC_DUTY_CYCLE_HIGH_OFFSET		(0x00000008)
> > > > +#define IPROC_DUTY_CYCLE_HIGH_MIN		(0x00000000)
> > > > +#define IPROC_DUTY_CYCLE_HIGH_MAX		(0x0000ffff)
> > > > +
> > > > +#define IPROC_PWM_CHANNEL_CNT			(0x00000004)
> > > > +#define IPROC_SIGNAL_PUSH_PULL			(0x00000000)
> > > > +#define IPROC_PWMOUT_TYPE_SHIFT			(0x0000000f)
> > > > +
> > > > +/*
> > > > + * pwm controller reg structure
> > > > + *
> > > > + * @prescale_offset: prescale register offset
> > > > + * @period_offset: period register offset
> > > > + * @duty_offset: duty register offset
> > > > + * @no_of_channels: number of channels
> > > > + * @out_type_shift: out type shift in the register
> > > > + * @signal_type: push-pull or open drain
> > > > + * @prescale_max: prescale max
> > > > + * @prescale_shift: prescale shift in register
> > > > + * @prescale_ch_ascending: prescale ch order in prescale register
> > > > + * @duty_cycle_max: value of max duty cycle
> > > > + * @duty_cycle_min: value of min duty cycle
> > > > + * @period_count_max: max period count val
> > > > + * @period_count_min: min period count val
> > > > + * @smooth_output_support: pwm smooth output support
> > > > + */
> > > > +struct kona_pwmc_reg {
> > > > +	u32 prescale_offset;
> > > > +	u32 period_offset;
> > > > +	u32 duty_offset;
> > > > +	u32 no_of_channels;
> > > > +	u32 out_type_shift;
> > > > +	u32 signal_type;
> > > > +	u32 prescale_max;
> > > > +	u32 prescale_shift;
> > > > +	bool prescale_ch_ascending;
> > > > +	u32 duty_cycle_max;
> > > > +	u32 duty_cycle_min;
> > > > +	u32 period_count_max;
> > > > +	u32 period_count_min;
> > > > +	bool smooth_output_support;
> > > > +};    
> > > 
> > > This is rather tedious. It looks to me like this isn't very similar to
> > > the existing driver. Register offsets move around, bitfield positions
> > > change, feature set is different. Might be better off turning this into
> > > a separate driver after all.
> > >   
> > > > +static const struct kona_pwmc_reg kona_pwmc_reg_data = {
> > > > +	.prescale_offset = PRESCALE_OFFSET,
> > > > +	.period_offset = KONA_PERIOD_COUNT_OFFSET,
> > > > +	.duty_offset = KONA_DUTY_CYCLE_HIGH_OFFSET,
> > > > +	.no_of_channels = PWM_CHANNEL_CNT,
> > > > +	.out_type_shift = PWMOUT_TYPE_SHIFT,
> > > > +	.signal_type = SIGNAL_PUSH_PULL,
> > > > +	.prescale_max = PRESCALE_MAX,
> > > > +	.prescale_shift = PRESCALE_SHIFT,
> > > > +	.prescale_ch_ascending = false,
> > > > +	.duty_cycle_max = DUTY_CYCLE_HIGH_MAX,
> > > > +	.duty_cycle_min = DUTY_CYCLE_HIGH_MIN,
> > > > +	.period_count_max = PERIOD_COUNT_MAX,
> > > > +	.period_count_min = PERIOD_COUNT_MIN,
> > > > +	.smooth_output_support = true,
> > > > +};
> > > > +
> > > > +static const struct kona_pwmc_reg iproc_pwmc_reg_data = {
> > > > +	.prescale_offset = IPROC_PRESCALE_OFFSET,
> > > > +	.period_offset = IPROC_PERIOD_COUNT_OFFSET,
> > > > +	.duty_offset = IPROC_DUTY_CYCLE_HIGH_OFFSET,
> > > > +	.no_of_channels = IPROC_PWM_CHANNEL_CNT,
> > > > +	.out_type_shift = IPROC_PWMOUT_TYPE_SHIFT,
> > > > +	.signal_type = IPROC_SIGNAL_PUSH_PULL,
> > > > +	.prescale_max = IPROC_PRESCALE_MAX,
> > > > +	.prescale_shift = IPROC_PRESCALE_SHIFT,
> > > > +	.prescale_ch_ascending = true,
> > > > +	.duty_cycle_max = IPROC_DUTY_CYCLE_HIGH_MAX,
> > > > +	.duty_cycle_min = IPROC_DUTY_CYCLE_HIGH_MIN,
> > > > +	.period_count_max = IPROC_PERIOD_COUNT_MAX,
> > > > +	.period_count_min = IPROC_PERIOD_COUNT_MIN,
> > > > +	.smooth_output_support = false,
> > > > +};    
> > > 
> > > This looks like you could possible support a lot more hardware with this
> > > driver because it's now almost completely parameterized.
> > > 
> > > I don't see much sense in keeping this in the same driver and I think
> > > it'd be better to write a new one from scratch, even if that means
> > > slight duplication.
> > > 
> > > Or you'll have to make a very compelling argument as to why this is the
> > > better option.  
> > 
> > Sorry to enter the discussion just now (Brian CCed me in an answer he
> > made to v4 of this series).
> > 
> > Honestly, I'd have the exact opposite argument: if you have a look at
> > newer versions of this patch, you'll see that more than 90% of the code
> > is duplicated, and re-using the same logic with different field
> > positions is quite common in other drivers. Actually the counter
> > argument to your suggestion are bug fixes: when you find a bug, you'll
> > have to remember fixing it for all implementations. Having a common
> > code base has IMO more pros than cons.
> > 
> > BTW, if you switch to regmap, you have this field-position
> > customization for free (see reg_field).  
> 
> My point was that with the above structures you have an almost
> completely parameterized driver. There's probably a number of other PWM
> controllers that you could support using those structure, or by adding
> to them. The question then becomes: where do we draw the line? When is
> a new driver warranted, and when is it not.

Well, there's a difference between trying to provide a completely
generic PWM driver and trying to factorize code for 2 almost identical
IPs (only the field position and width changes here).
The generic PWM driver approach is clearly an utopia because all PWM
IPs have their own requirements in term of clock source selection,
PWM configuration and sequencing constraints.

I agree that the decision to factorize common code is subjective, and
that the maintainer (you in this case) will always have the final word.

> 
> Your argument regarding bug fixes has some weight, but these drivers are
> really trivial, so bug fixes will be equally trivial to port between
> them.

Well, it's not only about bug fixes, but driver maintenance in general.
Let's take the recent atomic PWM rework: we're now recommending to
implement ->apply() instead of ->enable()/disable()/config(), and Brian
asked Yendapally to rework his implementation to follow this
recommendation. If we had chosen for the kona driver enhancement
instead of duplicating the code in a new driver we would have the
atomic update for the kona IP for free...

> 
> There's also the issue about errata and quirks that may apply to one but
> not all supported versions. The outcome of supporting all those
> combinations can be completely unmaintainable, so I am willing to take a
> bit of duplication if it means that in the end it will make things
> easier for me.

With only 2 revisions/versions supported, I don't expect to see a lot
of different errata, but that's true in general.
