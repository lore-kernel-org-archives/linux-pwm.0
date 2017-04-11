From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] drivers: pwm: pwm-atmel: implement suspend/resume
 functions
Date: Tue, 11 Apr 2017 10:56:05 +0200
Message-ID: <20170411105605.5ea65f75@bbrezillon>
References: <1491834020-3194-1-git-send-email-claudiu.beznea@microchip.com>
        <20170410163558.494cf9be@bbrezillon>
        <ba255c5b-ff6e-a6fd-0546-9dde04026f4c@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ba255c5b-ff6e-a6fd-0546-9dde04026f4c@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: m18063 <Claudiu.Beznea@microchip.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alexandre.belloni@free-electrons.com, nicolas.ferre@microchip.com
List-Id: linux-pwm@vger.kernel.org

On Tue, 11 Apr 2017 11:22:39 +0300
m18063 <Claudiu.Beznea@microchip.com> wrote:

> Hi Boris,
> 
> On 10.04.2017 17:35, Boris Brezillon wrote:
> > On Mon, 10 Apr 2017 17:20:20 +0300
> > Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
> >   
> >> Implement suspend and resume power management specific
> >> function to allow PWM controller to correctly suspend
> >> and resume.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >> ---
> >>  drivers/pwm/pwm-atmel.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 81 insertions(+)
> >>
> >> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> >> index 530d7dc..75177c6 100644
> >> --- a/drivers/pwm/pwm-atmel.c
> >> +++ b/drivers/pwm/pwm-atmel.c
> >> @@ -58,6 +58,8 @@
> >>  #define PWM_MAX_PRD		0xFFFF
> >>  #define PRD_MAX_PRES		10
> >>  
> >> +#define PWM_MAX_CH_NUM		(4)
> >> +
> >>  struct atmel_pwm_registers {
> >>  	u8 period;
> >>  	u8 period_upd;
> >> @@ -65,11 +67,18 @@ struct atmel_pwm_registers {
> >>  	u8 duty_upd;
> >>  };
> >>  
> >> +struct atmel_pwm_pm_ctx {
> >> +	u32 cmr;
> >> +	u32 cdty;
> >> +	u32 cprd;
> >> +};
> >> +
> >>  struct atmel_pwm_chip {
> >>  	struct pwm_chip chip;
> >>  	struct clk *clk;
> >>  	void __iomem *base;
> >>  	const struct atmel_pwm_registers *regs;
> >> +	struct atmel_pwm_pm_ctx ctx[PWM_MAX_CH_NUM];  
> > 
> > Hm, I'm pretty sure you can rely on the current PWM state and call
> > atmel_pwm_apply() at resume time instead of doing that. See what I did
> > here [1].  
> 
> I agree with the approach you propose but the thing is the atmel_pwm_apply()
> take care of both, current PWM state and the new state received as argument
> in order to change only duty factor without disabling the PWM channel (if
> channel is enabled) and then returns. Changing PWM duty and period and polarity
> in the same step without disabling + enabling the PWM channel (with atomic
> approach) may lead to intermediary unwanted output waveforms (the IP doesn't
> support this for ordinary PWM channels). To take advantage of atmel_pwm_apply()
> (in the formit is today) in resume() hook might need to first call it to disable
> channel and then to enable it. Or atmel_pwm_apply() should be changed to also
> disable + enable the channel when user changes the duty factor at runtime.

Nope. Just save the state at suspend time, implement ->get_state() and
use it to retrieve the real PWM state when resuming before restoring
the state you saved during suspend.
But anyway, as Thierry explained, I'm not sure we should take the
're-apply PWM state' action here. It's probably better to leave this
decision to the PWM user.
