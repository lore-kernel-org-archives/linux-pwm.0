Return-path: <kernel-bounces@pengutronix.de>
Date: Tue, 9 Oct 2018 11:04:01 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] pwm: document the pin state after pwm_disable() to
 be undefined
Message-ID: <20181009090401.3mlceegalzo53bd7@pengutronix.de>
References: <20180820095221.fydcvtz7ppcymrta@pengutronix.de>
 <20180820144357.7206-1-u.kleine-koenig@pengutronix.de>
 <20180820144357.7206-2-u.kleine-koenig@pengutronix.de>
 <20181009073407.GA5565@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181009073407.GA5565@ulmo>
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
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

Hello Thierry,

thanks for taking time to reply in this thread.

On Tue, Oct 09, 2018 at 09:34:07AM +0200, Thierry Reding wrote:
> On Mon, Aug 20, 2018 at 04:43:56PM +0200, Uwe Kleine-K=F6nig wrote:
> > Contrarily to the common assumption that pwm_disable() stops the
> > output at the state where it just happens to be, this isn't what the
> > hardware does on some machines. For example on i.MX6 the pin goes to
> > 0 level instead.
> >=20
> > Note this doesn't reduce the expressiveness of the pwm-API because if
> > you want the PWM-Pin to stay at a given state, you are supposed to
> > configure it to 0% or 100% duty cycle without calling pwm_disable().
> > The backend driver is free to implement potential power savings
> > already when the duty cycle changes to one of these two cases so this
> > doesn't come at an increased runtime power cost (once the respective
> > drivers are fixed).
> >=20
> > In return this allows to adhere to the API more easily for drivers that
> > currently cannot know if it's ok to disable the hardware on
> > pwm_disable() because the caller might or might not rely on the pin
> > stopping at a certain level.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  Documentation/pwm.txt | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> I don't think this is correct. An API whose result is an undefined state
> is useless in my opinion. So either we properly define what the state
> should be after a disable operation, or we might as well just remove the
> disable operation altogether.

Explicitly not defining some details makes it easier for hardware
drivers to comply with the API. Sure it would be great if all hardware
would allow to implement a "stronger" API but this isn't how reality looks
like.

You say it's bad that .disable() should imply less than it did up to
now. I say .disable() should only imply that the PWM stops toggling, so
.disable has a single purpose that each hardware design should be able
to implement.
And this weaker requirement/result is still good enough to implement all
use cases. (You had doubts here in the past, but without an example. I
cannot imagine there is one.) In my eyes this makes the API better not
worse.

What we have now in the API is redundancy, which IMHO is worse. If I
want the pwm pin to stay low I can say:

	pwm_config(pwm, 0, 100);

or I can say:

	pwm_config(pwm, 0, 100);
	pwm_disable(pwm);

The expected result is the same. Now you could argue that not disabling
the pwm is a bug because it doesn't save some energy. But really this is
a weakness of the API. There are two ways to express "Set the pin to
constant 0" and if there is an opportunity to save some energy on a
certain hardware implementation, just calling pwm_config() with duty=3D0
should be enough to benefit from it. This makes the API easier to use
because there is a single command to get to the state the pwm user wants
the pwm to be in. (This is two advantages: A single way to reach the
desired state and only one function to call.)

> From an API point of view I think it makes more sense to define the
> state after disable to be inactive, that is high for normal PWM and low
> for inversed PWM. The reason for this is that the disabled state is
> effectively what the reset state of the PWM would be.

The problem is this is where theory and reality differ. On i.MX if the
pwm clock is disabled the pin goes to zero independent of being inverted
or not. And before pinmuxing is done the reset state of the PWMs I know
and work with is an input.

So the only way the PWM API could be implemented fulfilling your
conditions on i.MX is that .disable() is a noop. And the pwm clock must
not be disabled until pwm_put() is called.

So the semantic of .disable() currently is "disable the pwm clock if this
keeps the pin at the expected level". For some---maybe even
most---hardware implementations this if condition is a no-brainer, but
for others it is relevant.

I want to simplify the semantic of .disable to "disable the pwm clock".
This downside is that this exposes hardware details and we need to teach
the pwm API users that this might have a side effect that isn't expected
today. But the expressiveness of the API isn't restricted because
with calling only pwm_config(pwm, 0, 100) you can still get the intended
result.

> If the PWM is inverted, typically the board design has a pull-up
> somewhere to avoid a backlight or LED from getting enabled by default.

Experience shows that it's a bad idea to rely on the hardware guys to do
everything we software guys consider sane. If the API is only suitable
for typical scenarios that's a bad report. My suggestion doesn't solve
this completely, but it makes the behaviour in the "non-typical"
situations better without complicating stuff in the good cases. A
complete win.

> In all other cases a PWM pin is likely just going to default to low
> when disabled.

So you suggest to specify "calling pwm_disable() is likely to drive the
pin to zero"? For sure you don't as this is completely useless.

> This also matches what all other drivers, and users, assume.

I don't know the hardware details for all PWMs that have a Linux driver
but I'd be surprised if the PWMs in i.MX SoCs were the only hardware
implementations that don't comply with your idea of a PWM.

And users are fixable.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
