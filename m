From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6/6] hwmon: pwm-fan: Update the duty cycle inorder to
 control the pwm-fan
Date: Wed, 8 Apr 2015 09:53:51 -0700
Message-ID: <20150408165351.GA22846@roeck-us.net>
References: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
 <1427387955-5129-7-git-send-email-linux.amoon@gmail.com>
 <20150408104415.07e1c821@amdc2363>
 <20150408153214.GA15942@roeck-us.net>
 <CANAwSgSD52sDpP7NH2hhiZX-=LZF6Qo-X3enqsqM+5XAMfyP=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANAwSgSD52sDpP7NH2hhiZX-=LZF6Qo-X3enqsqM+5XAMfyP=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Apr 08, 2015 at 09:32:05PM +0530, Anand Moon wrote:
> Hi Guenter,
> 
> Initially the board bootup the cooling level state is 0.
> So update the duty cycle and this power off the fan.
> As their is no state change the fan will not spin.
> 
> Once the temperature sensor is reached to alert temperature it changes state.
> With the state change the fan cools the CPU and then stop's
> 
> I have observed this state change with tmon utility in linux/tools/thermal/tmon/
> 
Sorry, I am missing something. I still don't see what problem you are fixing
with this patch. What behavior is wrong with the current code, and how does your
patch fix it ?

Guenter

> -Anand Moon
> 
> On 8 April 2015 at 21:02, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Wed, Apr 08, 2015 at 10:44:15AM +0200, Lukasz Majewski wrote:
> >> Hi Anand,
> >>
> >> > Below changes depend on following patch.
> >> > https://patchwork.kernel.org/patch/5944061/
> >> >
> >> > Update the pwm_config with duty then update the pwm_disable
> >> > to poweroff the cpu fan.
> >> >
> >
> > Unfortunately, the patch does not include an explanation why it is needed.
> >
> > The original code presumably did not update the duty cycle because
> > pwm was about to be disabled anyway. That kind of made sense to me.
> > Updating the duty cycle to 0 just to disable the pwm channel right
> > afterwards does not immediately make sense.
> >
> > Given that, I would expect to see a rationale here. Why is this patch needed ?
> > Does it fix a bug ? If yes, pelase describe the bug. If not, what is the
> > purpose of this patch ?
> >
> > Maybe that is all explained in patch 0/6, which I was not copied on. Even
> > if so, the reationale will be needed in the changelog to explain to future
> > developers why this change was made.
> >
> > Thanks,
> > Guenter
> >
> >> > Tested on OdroidXU3 board.
> >> >
> >> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >> > ---
> >> >  drivers/hwmon/pwm-fan.c | 10 ++++------
> >> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >> >
> >> > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> >> > index 7c83dc4..f25c841 100644
> >> > --- a/drivers/hwmon/pwm-fan.c
> >> > +++ b/drivers/hwmon/pwm-fan.c
> >> > @@ -44,26 +44,24 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx,
> >> > unsigned long pwm) int ret = 0;
> >> >
> >> >     mutex_lock(&ctx->lock);
> >> > +
> >
> > [ please refrain from unnecessary whitespace changes ]
> >
> >> >     if (ctx->pwm_value == pwm)
> >> >             goto exit_set_pwm_err;
> >> >
> >> > -   if (pwm == 0) {
> >> > -           pwm_disable(ctx->pwm);
> >> > -           goto exit_set_pwm;
> >> > -   }
> >> > -
> >> >     duty = DIV_ROUND_UP(pwm * (ctx->pwm->period - 1), MAX_PWM);
> >> >     ret = pwm_config(ctx->pwm, duty, ctx->pwm->period);
> >> >     if (ret)
> >> >             goto exit_set_pwm_err;
> >> >
> >> > +   if (pwm == 0)
> >> > +           pwm_disable(ctx->pwm);
> >> > +
> >> >     if (ctx->pwm_value == 0) {
> >> >             ret = pwm_enable(ctx->pwm);
> >> >             if (ret)
> >> >                     goto exit_set_pwm_err;
> >> >     }
> >> >
> >> > -exit_set_pwm:
> >> >     ctx->pwm_value = pwm;
> >> >  exit_set_pwm_err:
> >> >     mutex_unlock(&ctx->lock);
> >>
> >> Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>
> >>
> >> BTW: I've added Guenter to CC.
> >>
> >> --
> >> Best regards,
> >>
> >> Lukasz Majewski
> >>
> >> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
