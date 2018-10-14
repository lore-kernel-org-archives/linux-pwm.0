Return-path: <kernel-bounces@pengutronix.de>
Date: Sun, 14 Oct 2018 13:34:00 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
Message-ID: <20181014113400.nm6ajbjnju2h6dz3@pengutronix.de>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20181009075345.GB5565@ulmo>
 <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
 <20181010122607.GA21134@ulmo>
 <20181011101914.dapsvczsd4lteugk@pengutronix.de>
 <20181011120007.GA22811@ulmo>
 <c11b425a-0907-d489-81a9-92289dc51028@ysoft.com>
 <20181012094557.ktasxus2zrbsp5rx@pengutronix.de>
 <20181012101143.GC9162@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181012101143.GC9162@ulmo>
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

Hello Thierry,

On Fri, Oct 12, 2018 at 12:11:43PM +0200, Thierry Reding wrote:
> On Fri, Oct 12, 2018 at 11:45:57AM +0200, Uwe Kleine-König wrote:
> > On Thu, Oct 11, 2018 at 01:15:44PM +0000, Vokáč Michal wrote:
> [...]
> > > >> Sidenote: With the current capabilities of the pwm framework there is no
> > > >> technical reason to expose to the hardware drivers that the pwm user uses
> > > >> inverted logic. The framework could just apply
> > > >>
> > > >> 	duty = period - duty;
> > > >>
> > > 
> > > I prefer to utilize as much HW capabilities as possible. And it seems
> > > like most PWM chips support HW output inversion (to some extent) so to
> > > me it seems perfectly OK that that information can be propagated from
> > > the upper SW levels to the lowest one.
> > 
> > If the hardware capability is useful I fully agree. But if inversion can
> > be accomplished by a chip that doesn't support inversion in hardware by
> > just using duty = period - duty (and so can be accomplished by a chip
> > that has inversion support without making use of it) then the drivers
> > shouldn't be confronted with it.
> 
> These two are orthogonal problems. If all you care about is the power
> output of the PWM (as is the case for backlights, LEDs or fans, for
> example), then inverted polarity has the same effect as duty = period -
> duty.
> 
> However, the two don't result in identical waveforms.

OK, let's find the difference then. Consider a pwm that is off at start,
then it's configured to run at 66% duty cycle at time A and then it's
disabled again at time B.

The resulting wave form is:

______________       __       __       __       _____________________
              \_____/  \_____/  \_____/  \_____/
            A                                B
              ^        ^        ^        ^

With the ^ markers pointing out where the periods started.

Correct?

Now with the duty = period - duty trick the wave would look as follows:


_________________       __       __       __       __________________
                 \_____/  \_____/  \_____/  \_____/
            A                                B
              ^        ^        ^        ^

Apart from a shift I cannot see any difference. I confirm that this
might be bad if there are two (or more) PWMs that are expected to run in
sync, but given that the current API doesn't provide the possibility to
map such a use case this is irrelevant.

Another difference I confirm there might be is that this might result in
one more (or less) periods depending on timing and the capabilities of
the hardware. Is this bad? I'd say it isn't.

What am I missing?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
