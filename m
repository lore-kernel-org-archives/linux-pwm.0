Return-path: <kernel-bounces@pengutronix.de>
Date: Mon, 15 Oct 2018 14:33:06 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
Message-ID: <20181015123306.nw7zjp2ouefp46yh@pengutronix.de>
References: <20181009075345.GB5565@ulmo>
 <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
 <20181010122607.GA21134@ulmo>
 <20181011101914.dapsvczsd4lteugk@pengutronix.de>
 <20181011120007.GA22811@ulmo>
 <c11b425a-0907-d489-81a9-92289dc51028@ysoft.com>
 <20181012094557.ktasxus2zrbsp5rx@pengutronix.de>
 <20181012101143.GC9162@ulmo>
 <20181014113400.nm6ajbjnju2h6dz3@pengutronix.de>
 <20181015092213.GB12357@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181015092213.GB12357@ulmo>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Gavin Schenk <g.schenk@eckelmann.de>, =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-ID: <linux-pwm.vger.kernel.org>

On Mon, Oct 15, 2018 at 11:22:13AM +0200, Thierry Reding wrote:
> On Sun, Oct 14, 2018 at 01:34:00PM +0200, Uwe Kleine-König wrote:
> > Hello Thierry,
> > 
> > On Fri, Oct 12, 2018 at 12:11:43PM +0200, Thierry Reding wrote:
> > > On Fri, Oct 12, 2018 at 11:45:57AM +0200, Uwe Kleine-König wrote:
> > > > On Thu, Oct 11, 2018 at 01:15:44PM +0000, Vokáč Michal wrote:
> > > [...]
> > > > > >> Sidenote: With the current capabilities of the pwm framework there is no
> > > > > >> technical reason to expose to the hardware drivers that the pwm user uses
> > > > > >> inverted logic. The framework could just apply
> > > > > >>
> > > > > >> 	duty = period - duty;
> > > > > >>
> > > > > 
> > > > > I prefer to utilize as much HW capabilities as possible. And it seems
> > > > > like most PWM chips support HW output inversion (to some extent) so to
> > > > > me it seems perfectly OK that that information can be propagated from
> > > > > the upper SW levels to the lowest one.
> > > > 
> > > > If the hardware capability is useful I fully agree. But if inversion can
> > > > be accomplished by a chip that doesn't support inversion in hardware by
> > > > just using duty = period - duty (and so can be accomplished by a chip
> > > > that has inversion support without making use of it) then the drivers
> > > > shouldn't be confronted with it.
> > > 
> > > These two are orthogonal problems. If all you care about is the power
> > > output of the PWM (as is the case for backlights, LEDs or fans, for
> > > example), then inverted polarity has the same effect as duty = period -
> > > duty.
> > > 
> > > However, the two don't result in identical waveforms.
> > 
> > OK, let's find the difference then. Consider a pwm that is off at start,
> > then it's configured to run at 66% duty cycle at time A and then it's
> > disabled again at time B.
> > 
> > The resulting wave form is:
> > 
> > ______________       __       __       __       _____________________
> >               \_____/  \_____/  \_____/  \_____/
> >             A                                B
> >               ^        ^        ^        ^
> > 
> > With the ^ markers pointing out where the periods started.
> > 
> > Correct?
> > 
> > Now with the duty = period - duty trick the wave would look as follows:
> > 
> > 
> > _________________       __       __       __       __________________
> >                  \_____/  \_____/  \_____/  \_____/
> >             A                                B
> >               ^        ^        ^        ^
> > 
> > Apart from a shift I cannot see any difference. I confirm that this
> > might be bad if there are two (or more) PWMs that are expected to run in
> > sync, but given that the current API doesn't provide the possibility to
> > map such a use case this is irrelevant.
> > 
> > Another difference I confirm there might be is that this might result in
> > one more (or less) periods depending on timing and the capabilities of
> > the hardware. Is this bad? I'd say it isn't.
> > 
> > What am I missing?
> 
> I don't think that's entirely correct. For normal PWM with 66% duty
> cycle you'd get something like this:
> 
>      ____    ____    ____
>     /    \__/    \__/    \__   (1)
>     ^       ^       ^
> 
> For "emulated" inversion (duty cycle = period - duty cycle, i.e. 33%
> duty cycle) you'd get this:
> 
>      __      __      __
>     /  \____/  \____/  \____   (2)
>     ^       ^       ^
> 
> For a truly inversed PWM (duty cycle = 33%), it would look like this:
> 
>           __      __      __
>     \____/  \____/  \____/     (3)
>     ^       ^       ^
> 
> If you emulate inversion of the truly inversed PWM, you'd get this:
> 
>         ____    ____    ____
>     \__/    \__/    \__/       (4)
>     ^       ^       ^
> 
> As you can see, all of the above are slightly different. As you can see,
> and you already noted that, the emulated inversion (2) and the true
> inversion (3) are almost identical, except that they have a phase shift
> that is equivalent to the duty cycle. The same is true of (1) and (4).
> The phase shift doesn't affect the power output of the signal, so (1)
> and (4) as well as (2) and (3) have the same power output. This is the
> reason why the difference doesn't matter for backlight or LEDs, because
> brightness is proportional to the power output.
> 
> However, you can also see that (2) and (3) are different in how the
> period starts. (2) starts with a rising edge while (3) starts with a
> falling edge.
> 
> Now, for any use-cases where the only thing we care about is the power
> output, my opinion is that consumers should implement the inversion. If
> the hardware is capable of inversion, then by all means they should use
> that in the implementation. But, a lot of hardware is not capable of
> doing the inversion, so they can still fall back to emulating the
> inversion. Either way, the important point here is that the consumer
> driver (pwm-backlight, leds-pwm, ...) knows that only power output is
> relevant, so it is the consumer drivers that should make the decision.
> 
> On the other hand, other use-cases may rely on the exact shape of the
> PWM signal, so if the edges are important, then they need to rely on the
> hardware inversion for proper functionality. My understanding is that we
> don't have any of those users in the kernel, but my recollection is that
> people use the sysfs interfaces to make use of this.

Your figures suggest that the first edge is different, too, but that's
wrong because you didn't take the idle state into account that was
active before the first period. If the output was already high before
there cannot be a raising edge. When this is corrected in your figures
they look as follows:

1) uninverted 
       ____    ____    ____
   ___/    \__/    \__/    \__
      ^       ^       ^

2) emulated inversion

   ______      __      __
         \____/  \____/  \____
      ^       ^       ^

3) hw inversion:
    __      __      __
      \____/  \____/  \____/
      ^       ^       ^

4) hw + emulated inversion:

          ____    ____    ____
   ______/    \__/    \__/       (4)
      ^       ^       ^

So the order of the edges is identical for hardware inversion and
software inversion.

The only difference is that with hardware inversion the first edge might
come earlier. But with the current PWM API you cannot make use of this
"advantage" because there is no way for the user to sync the period of
the PWM to anything else (e.g. another PWM). Also typically for a motor
control you want two PWMs running with a phase shift like:

         ___     ___     ___
    ____/   \___/   \___/
        ^  ___  ^  ___  ^
    ______/   \___/   \___/
          ^       ^       ^

So independant of inversion or not the periods of the two signals must
be shifted by (say) $period/2. How do you achive that? I'd say the best
you can do is:

	local_irq_disable();
	pwm_enable(pwm1);
	delay(period / 2);
	pwm_enable(pwm2);
	local_irq_enable();

Now given that it can take some time until pwm_enable() returns, this is
poor timing and you'd have to reduce the delay (by experimenting). If
you want to do that from userspace via sysfs you cannot even disable
irqs and the timing depends on how many ethernet packages are processed
between your two syscalls.

Trying this without additional hardware capabilities (e.g. a counter
shared by two PWMs) is broken. As the PWM API doesn't expose such
capabilities changing how inversion is implemented won't break any user
that isn't already broken before.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
