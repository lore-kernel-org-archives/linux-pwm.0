From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 1/2] pwm: sunxi: allow the pwm to finish its pulse before
 disable
Date: Tue, 3 Jan 2017 17:55:54 +0100
Message-ID: <20170103165554.6vq7fyhtpx7olqyf@piout.net>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
 <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
 <20160826221900.GG3165@lukather>
 <afcb938d-d2df-4740-6c85-cdf2766f671c@schinagl.nl>
 <20161212122427.4ixo7terrlvnuqmd@lukather>
 <627ddbeb-d199-e2df-2073-090216a9fb0b@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <627ddbeb-d199-e2df-2073-090216a9fb0b@schinagl.nl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 03/01/2017 at 16:59:57 +0100, Olliver Schinagl wrote :
> On 12-12-16 13:24, Maxime Ripard wrote:
> > On Thu, Dec 08, 2016 at 02:23:39PM +0100, Olliver Schinagl wrote:
> > > Hey Maxime,
> > > 
> > > first off, also sorry for the slow delay :) (pun not intended)
> > > 
> > > On 27-08-16 00:19, Maxime Ripard wrote:
> > > > On Thu, Aug 25, 2016 at 07:50:10PM +0200, Olliver Schinagl wrote:
> > > > > When we inform the PWM block to stop toggeling the output, we may end up
> > > > > in a state where the output is not what we would expect (e.g. not the
> > > > > low-pulse) but whatever the output was at when the clock got disabled.
> > > > > 
> > > > > To counter this we have to wait for maximally the time of one whole
> > > > > period to ensure the pwm hardware was able to finish. Since we already
> > > > > told the PWM hardware to disable it self, it will not continue toggling
> > > > > but merly finish its current pulse.
> > > > > 
> > > > > If a whole period is considered to much, it may be contemplated to use a
> > > > > half period + a little bit to ensure we get passed the transition.
> > > > > 
> > > > > Signed-off-by: Olliver Schinagl<oliver@schinagl.nl>
> > > > > ---
> > > > >   drivers/pwm/pwm-sun4i.c | 11 +++++++++++
> > > > >   1 file changed, 11 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > > > index 03a99a5..5e97c8a 100644
> > > > > --- a/drivers/pwm/pwm-sun4i.c
> > > > > +++ b/drivers/pwm/pwm-sun4i.c
> > > > > @@ -8,6 +8,7 @@
> > > > >   #include <linux/bitops.h>
> > > > >   #include <linux/clk.h>
> > > > > +#include <linux/delay.h>
> > > > >   #include <linux/err.h>
> > > > >   #include <linux/io.h>
> > > > >   #include <linux/module.h>
> > > > > @@ -245,6 +246,16 @@ static void sun4i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> > > > >   	spin_lock(&sun4i_pwm->ctrl_lock);
> > > > >   	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > > > >   	val &= ~BIT_CH(PWM_EN, pwm->hwpwm);
> > > > > +	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> > > > > +	spin_unlock(&sun4i_pwm->ctrl_lock);
> > > > > +
> > > > > +	/* Allow for the PWM hardware to finish its last toggle. The pulse
> > > > > +	 * may have just started and thus we should wait a full period.
> > > > > +	 */
> > > > > +	ndelay(pwm_get_period(pwm));
> > > > Can't that use the ready bit as well?
> > > 
> > > I started to implement our earlier discussed suggestions, but I do not think
> > > they will work. The read bit is not to let the user know it is ready with
> > > all of its commands, but only if the period registers are ready. I think it
> > > is some write lock while it copies the data into its internal control loop.
> > > From the manual:
> > > PWM0 period register ready.
> > > 0: PWM0 period register is ready to write,
> > > 1: PWM0 period register is busy.
> > > 
> > > 
> > > So no, I don't think i can use the ready bit here at all. The only thing we
> > > can do here, but I doubt it's worth it, is to read the period register,
> > > caluclate a time from it, and then ndelay(pwm_get_period(pwm) - ran_time)
> > > 
> > > The only 'win' then is that we could are potentially not waiting the full
> > > pwm period, but only a fraction of it. Since we are disabling the hardware
> > > (for power reasons) anyway, I don't think this is any significant win,
> > > except for extreme situations. E.g. we have a pwm period of 10 seconds, we
> > > disable it after 9.9 second, and now we have to wait for 10 seconds before
> > > the pwm_disable is finally done. So this could in that case be reduced to
> > > then only wait for 0.2 seconds since it is 'done' sooner.
> > > 
> > > However that optimization is also not 'free'. We have to read the period
> > > register and calculate back the time. I suggest to do that when reworking
> > > this driver to work with atomic mode, and merge this patch 'as is' to
> > > atleast fix te bug where simply not finish properly.
> > 
> > That whole discussion made me realise something that is really
> > bad. AFAIK, pwm_get_period returns a 32 bits register, which means a
> > theorical period of 4s. Busy looping during 4 seconds is already very
> > bad, as you basically kill one CPU during that time, but doing so in a
> > (potentially) atomic context is even worse.
> Well technically, isn't it a 16 bit register? (half for the period, other
> half for the duty cycle?) Anyway, I think the delay can be far exceeding 4
> seconds (though I haven't checked what the PWM delay max option is).
> 

That's 196.8s.

But you can rely on the RDY bit because what you want to
achieve actually relies on the fact that the duty cycle will be set to 0
before disabling the channel.


> Anyway, you are right, we should absolutely not do this!
> 
> > 
> > NACK.
> Absolutely! But what do you suggest? Would usleep (or msleep) instead of the
> ndelay work properly?
> 

We can probably set up a timer and disable the channel when it expires.
Obviously it will be necessary to cancel the timer if the channel is
reenabled in the mean time.

Or maybe we can make all the functions blocking and forget about
synchronizing both channels.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
