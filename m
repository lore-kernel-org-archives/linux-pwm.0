From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] pwm: don't allow duty cycle higher than period
Date: Fri, 27 May 2016 18:40:07 +0200
Message-ID: <20160527184007.384d23b3@bbrezillon>
References: <1464296730-121773-1-git-send-email-briannorris@chromium.org>
	<20160527093439.5ad237c5@bbrezillon>
	<20160527163533.GA80118@google.com>
	<20160527183814.6f8f4ba7@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160527183814.6f8f4ba7@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Doug Anderson <dianders@chromium.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, 27 May 2016 18:38:14 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> On Fri, 27 May 2016 09:35:33 -0700
> Brian Norris <briannorris@chromium.org> wrote:
> 
> > Hi Boris,
> > 
> > On Fri, May 27, 2016 at 09:34:39AM +0200, Boris Brezillon wrote:  
> > > On Thu, 26 May 2016 14:05:30 -0700
> > > Brian Norris <briannorris@chromium.org> wrote:
> > >     
> > > > It doesn't make sense to allow the duty cycle to be larger than the
> > > > period. I can see this behavior by, e.g.:
> > > > 
> > > >   # echo 1 > /sys/class/pwm/pwmchip0/export
> > > >   # cat /sys/class/pwm/pwmchip0/pwm1/period
> > > >   100
> > > >   # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
> > > >   [... driver may or may not reject the value, or trigger some logic bug ...]
> > > > 
> > > > It's better to see:
> > > > 
> > > >   # echo 1 > /sys/class/pwm/pwmchip0/export
> > > >   # cat /sys/class/pwm/pwmchip0/pwm1/period
> > > >   100
> > > >   # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
> > > >   -bash: echo: write error: Invalid argument
> > > > 
> > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > > ---
> > > >  drivers/pwm/core.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > > index dba3843c53b8..9246b60f894a 100644
> > > > --- a/drivers/pwm/core.c
> > > > +++ b/drivers/pwm/core.c
> > > > @@ -463,6 +463,9 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
> > > >  	if (!memcmp(state, &pwm->state, sizeof(*state)))
> > > >  		return 0;
> > > >  
> > > > +	if (state->duty_cycle > state->period)
> > > > +		return -EINVAL;
> > > > +    
> > > 
> > > Argh, I forgot to move the pwm_config() checks [1] into
> > > pwm_apply_state() :-/.    
> > 
> > Oh, I didn't actually notice this was a regression.
> >   
> > > I think we should check all the corner cases (see this diff [2]),    
> > 
> > Now that you mention it, I think you've also dropped some signed
> > (negative value) checking in pwm_config(). I'll squash in your diff +
> > some pwm_config() fixes.  
> 
> ->period and ->duty_cycle are unsigned now ;).  
> 

Never mind, you're right (thought you were talking about checking the
->period and ->duty_cycle values).

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
