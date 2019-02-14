From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Date: Thu, 14 Feb 2019 10:48:53 +0100
Message-ID: <20190214094853.zs45m5k27hgtvyxt@pengutronix.de>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
 <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
 <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
 <67e881c5-0ea7-3d2f-5910-534729097d11@microchip.com>
 <20190107221040.uos5qlnkjmcayv73@pengutronix.de>
 <20190205230125.GE1372@mithrandir>
 <20190206082432.6imbcuwlxhtsw4s4@pengutronix.de>
 <de382486-e8da-b000-7846-39fd6710cc89@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <de382486-e8da-b000-7846-39fd6710cc89@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com, corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Wed, Feb 13, 2019 at 03:38:46PM +0000, Claudiu.Beznea@microchip.com wrote:
> On 06.02.2019 10:24, Uwe Kleine-König wrote:
> > On Wed, Feb 06, 2019 at 12:01:26AM +0100, Thierry Reding wrote:
> >> But I really don't see the point in having consumers jump through hoops
> >> to set one of the standard modes just to have the driver jump through
> >> more hoops to determine which mode was meant.
> > 
> > I think my approach is more natural and not more complicated at all. In
> > all modes where this secondary output makes sense both outputs share the
> > period length. In all modes both outputs have a falling and a raising
> > edge each. Let's assume we support
> > 
> >  - normal mode (one output, secondary (if available) inactive)
> >  - complementary mode (secondary output is the inverse of primary
> >    output)
> >  - push-pull mode (primary output only does every second active phase,
> >    the secondy output does the ones that are skiped by the primary one)
> >  - complementary mode with deadtime (like above but there is a pause
> >    where both signals are inactive at the switch points, so the active
> >    phase of the secondary output is $deadtime_pre + $deadtime_post
> >    shorter than the primary output's inactive phase).
> > 
> > To describe these modes we need with the approach suggested by Claudiu
> > the following defines:
> > 
> >  enum mode {
> >  	NORMAL,
> > 	COMPLEMENTARY,
> > 	PUSH_PULL
> > 	PUSH_PULL_WITH_DEADTIME

Here I made a mistake, I should have written about
COMPLEMENTARY_WITH_DEADTIME, not PUSH_PULL_WITH_DEADTIME. The
argumentation is analogous however. PUSH_PULL_WITH_DEADTIME is
completely unintuitive when thinking about the needed parameters, I'll
skip talking about this.
 
> I see push-pull mode as a particular mode of complementary mode with
> dead-times equal to a half of a period.

<pedantic>It's not half a period that you need to use as dead-time, but
period/2 - duty_cycle.</pedantic>

This means that we could model "complementary" and "push pull" (and even
"push pull with deadtime") if we only had "complementary with deadtime".
So the latter seems to be the universal we should implement, right?
(Otherwise a driver for a hardware that is flexible enough to actually
do it has to implement three or so different ways to yield requested
waveforms when a single one would be enough.)

The parameters for that are:

	- period length
	- duty_cycle
	- pre_deadtime
	- post_deadtime

. The expressiveness is identical to my suggestion (with alt_duty_cycle
and alt_offset), just that this uses more artificial and unintuitive
characteristics of the wave to describe it. (An indication is that you
got it wrong above, see my pedantic note.)

I'd say only abstract using "modes" if they are really orthonal which
you seem to agree isn't the case here. In fact we only need a single
mode that driver authors need to grasp and if there are two or more
different ways to describe the same waves we're only make it harder for
them.

The argument "But not all hardware has the flexibility to implement
all wave forms that are decribable with any of these abstractions."
isn't really a problem. We already have now the situation with only
.period, .duty_cycle and .polarity that not all drivers can implement
everything. So there has to be a mechanism to handle inability to
implement a given request anyhow.

> I don't get the meaning of push-pull with dead-times, there is already
> there a deadtime pre, post value equal with 1/2 of period.

FTR: in my argumentation COMPLEMENTARY is just what you defined it to
be. I.e. it doesn't have deadtimes. But as shown above this doesn't
really matter. Both COMPLEMENTARY with deadtimes and my suggestion have
the same expressive power, just use different characteristics to
describe a wave form. To summarize, requesting the following wave:


                     ______                ______
secondary __________/      \______________/      \____
             __                    __
primary   __/  \__________________/  \________________
            ^                     ^
A           `--'					.duty_cycle
B           `-------'      				.alt_offset
C                   `------'				.alt_duty_cycle
D              `----'					.pre_dead_time
E                          `------'			.post_dead_time

You need apart from the period length which is needed for all:

 - With my suggestion you need to pass A, B and C; and
 - with COMPLEMENTARY and deadtimes you need to provide A, D and E.

Isn't A, B and C the most intuitive set, given that when describing only
only the primary output you need A and for the secondary output you need
only C?

Also note that for PUSH_PULL with deadtime the deadtimes might be
negative. The boundary checks for my approach are:

	0 <= .duty_cycle <= .period (as we already have today)
	0 <= .alt_duty_cycle <= .period (which is analogous to the above line)
	0 <= .alt_offset < .period

With COMPLEMENTARY and deadtimes it is harder, as there are conditions
that have to speak about both .pre_dead_time and .post_dead_time.

> >  struct pwm_state {
> >  	unsigned int period;
> > 	unsigned int duty_cycle;
> > 	enum pwm_polarity polarity;
> > 	bool enabled;
> > 	enum mode mode;
> > 	unsigned int deadtime_pre;
> > 	unsigned int deadtime_post;
> >  }
> > 
> > This has the following downsides:
> > 
> >  - The period in push-pull mode is somehow wrong because the signal
> >    combination repeats only every 2x $period ns. (I guess this is an
> >    implementation detail of the atmel hardware that leaks into the API
> >    here.)
> 
> As far as I'm concern of the PWM push-pull mode it is a specific PWM
> working mode, not related to Atmel, which can be used to drive half-bridge
> converters.

This is not what I meant. The point I wanted to make here is, that I
would consider it more natural to define the period length of the
following wave form pair as the time between the two carets, not half of
it as you suggested in your patch.

                  __                    __
    _____________/  \__________________/  \_____
       __                    __
    __/  \__________________/  \________________
      ^                     ^

That's because then for all wave forms the period of both outputs matches
the period variable.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
