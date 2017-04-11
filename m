From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] drivers: pwm: pwm-atmel: implement suspend/resume
 functions
Date: Tue, 11 Apr 2017 10:50:17 +0200
Message-ID: <20170411105017.43ea5009@bbrezillon>
References: <1491834020-3194-1-git-send-email-claudiu.beznea@microchip.com>
        <20170410163558.494cf9be@bbrezillon>
        <20170410151011.GA18753@ulmo.ba.sec>
        <20170410180137.6b4f3a74@bbrezillon>
        <20170410182726.730ea8f0@bbrezillon>
        <60b4ac51-6cee-04b3-f74a-3d2693e1f021@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52300 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbdDKIuT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2017 04:50:19 -0400
In-Reply-To: <60b4ac51-6cee-04b3-f74a-3d2693e1f021@microchip.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: m18063 <Claudiu.Beznea@microchip.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alexandre.belloni@free-electrons.com, nicolas.ferre@microchip.com

On Tue, 11 Apr 2017 11:33:44 +0300
m18063 <Claudiu.Beznea@microchip.com> wrote:

> On 10.04.2017 19:27, Boris Brezillon wrote:
> > On Mon, 10 Apr 2017 18:01:37 +0200
> > Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> >   
> >> On Mon, 10 Apr 2017 17:10:11 +0200
> >> Thierry Reding <thierry.reding@gmail.com> wrote:
> >>  
> >>> On Mon, Apr 10, 2017 at 04:35:58PM +0200, Boris Brezillon wrote:    
> >>>> On Mon, 10 Apr 2017 17:20:20 +0300
> >>>> Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
> >>>>       
> >>>>> Implement suspend and resume power management specific
> >>>>> function to allow PWM controller to correctly suspend
> >>>>> and resume.
> >>>>>
> >>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>>>> ---
> >>>>>  drivers/pwm/pwm-atmel.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>>  1 file changed, 81 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> >>>>> index 530d7dc..75177c6 100644
> >>>>> --- a/drivers/pwm/pwm-atmel.c
> >>>>> +++ b/drivers/pwm/pwm-atmel.c
> >>>>> @@ -58,6 +58,8 @@
> >>>>>  #define PWM_MAX_PRD		0xFFFF
> >>>>>  #define PRD_MAX_PRES		10
> >>>>>  
> >>>>> +#define PWM_MAX_CH_NUM		(4)
> >>>>> +
> >>>>>  struct atmel_pwm_registers {
> >>>>>  	u8 period;
> >>>>>  	u8 period_upd;
> >>>>> @@ -65,11 +67,18 @@ struct atmel_pwm_registers {
> >>>>>  	u8 duty_upd;
> >>>>>  };
> >>>>>  
> >>>>> +struct atmel_pwm_pm_ctx {
> >>>>> +	u32 cmr;
> >>>>> +	u32 cdty;
> >>>>> +	u32 cprd;
> >>>>> +};
> >>>>> +
> >>>>>  struct atmel_pwm_chip {
> >>>>>  	struct pwm_chip chip;
> >>>>>  	struct clk *clk;
> >>>>>  	void __iomem *base;
> >>>>>  	const struct atmel_pwm_registers *regs;
> >>>>> +	struct atmel_pwm_pm_ctx ctx[PWM_MAX_CH_NUM];      
> >>>>
> >>>> Hm, I'm pretty sure you can rely on the current PWM state and call
> >>>> atmel_pwm_apply() at resume time instead of doing that. See what I did
> >>>> here [1].
> >>>>
> >>>> Thierry, maybe it's time to start thinking about a generic solution to
> >>>> save/restore PWM states.      
> >>>
> >>> Generally speaking I think applying the states are the right way to go.
> >>> Ideally the PWM core could simply resume all of the PWM channels that a
> >>> device exports and the ->apply() callback would be enough to restore
> >>> that. I'm not sure if that's going to work with current implementations,
> >>> though. Your pwm-atmel-hlcdc patch certainly indicates that we're not
> >>> quite there yet.
> >>>
> >>> On the other hand, I'm beginning to think that maybe PWMs are too low-
> >>> level for this kind of suspend/resume. For example if you use the PWM to
> >>> control a backlight brightness, restoring it via the driver core's
> >>> resume hook is potentially going to turn it back on at the wrong time. I
> >>> have a feeling that we might be better off just pushing this up to the
> >>> PWM users. A slight special case might be sysfs, for which no external
> >>> user driver exists. But we already have separate data structures to keep
> >>> track of sysfs-related context, so suspend/resume support could be added
> >>> there.    
> >>
> >> Yep, you're probably right, we should let the PWM user take care of
> >> re-applying the PWM state, because it's the only one having enough
> >> knowledge about what the PWM is really driving to take a wise decision.  
> > 
> > Note that we need drivers to implement both ->apply() and ->get_state()
> > for this approach to work correctly, and we also need some help from
> > the core to reset the PWM states at resume time, otherwise
> > pwm_apply_state() will just compare the old state to the new one, see
> > that they match and never call the ->apply() method.
> > 
> > Another solution would be to remove the memcmp here [1] and
> > unconditionally call ->apply().  
> There are drivers which checks, in ->apply() hooks, the current PWM state
> before applying the new state or take actions based on differences
> b/w current and new PWM states. Removing memcmp without resetting
> the PWM state would lead to wrong states in those drivers.

Indeed. So it just leaves the solution where we implement ->get_state().
Honestly, it shouldn't be too hard to do that in the atmel driver.

Note that for drivers that do not implement ->get_state(), the first
pwm_apply_state() after the system has resumed should be harmless,
because the current PWM should exactly match the one the PWM user is
re-applying.
