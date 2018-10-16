Return-path: <kernel-bounces@pengutronix.de>
Date: Tue, 16 Oct 2018 09:44:17 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
Message-ID: <20181016094417.64114816@bbrezillon>
In-Reply-To: <20181009090401.3mlceegalzo53bd7@pengutronix.de>
References: <20180820095221.fydcvtz7ppcymrta@pengutronix.de>
 <20180820144357.7206-1-u.kleine-koenig@pengutronix.de>
 <20180820144357.7206-2-u.kleine-koenig@pengutronix.de>
 <20181009073407.GA5565@ulmo>
 <20181009090401.3mlceegalzo53bd7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] pwm: document the pin state after pwm_disable() to
 be undefined
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

Hi Thierry,

On Tue, 9 Oct 2018 11:04:01 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello Thierry,
>=20
> thanks for taking time to reply in this thread.
>=20
> On Tue, Oct 09, 2018 at 09:34:07AM +0200, Thierry Reding wrote:
> > On Mon, Aug 20, 2018 at 04:43:56PM +0200, Uwe Kleine-K=C3=B6nig wrote: =
=20
> > > Contrarily to the common assumption that pwm_disable() stops the
> > > output at the state where it just happens to be, this isn't what the
> > > hardware does on some machines. For example on i.MX6 the pin goes to
> > > 0 level instead.
> > >=20
> > > Note this doesn't reduce the expressiveness of the pwm-API because if
> > > you want the PWM-Pin to stay at a given state, you are supposed to
> > > configure it to 0% or 100% duty cycle without calling pwm_disable().
> > > The backend driver is free to implement potential power savings
> > > already when the duty cycle changes to one of these two cases so this
> > > doesn't come at an increased runtime power cost (once the respective
> > > drivers are fixed).
> > >=20
> > > In return this allows to adhere to the API more easily for drivers th=
at
> > > currently cannot know if it's ok to disable the hardware on
> > > pwm_disable() because the caller might or might not rely on the pin
> > > stopping at a certain level.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  Documentation/pwm.txt | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-) =20
> >=20
> > I don't think this is correct. An API whose result is an undefined state
> > is useless in my opinion. So either we properly define what the state
> > should be after a disable operation, or we might as well just remove the
> > disable operation altogether. =20
>=20
> Explicitly not defining some details makes it easier for hardware
> drivers to comply with the API. Sure it would be great if all hardware
> would allow to implement a "stronger" API but this isn't how reality looks
> like.
>=20
> You say it's bad that .disable() should imply less than it did up to
> now. I say .disable() should only imply that the PWM stops toggling, so
> .disable has a single purpose that each hardware design should be able
> to implement.
> And this weaker requirement/result is still good enough to implement all
> use cases. (You had doubts here in the past, but without an example. I
> cannot imagine there is one.) In my eyes this makes the API better not
> worse.
>=20
> What we have now in the API is redundancy, which IMHO is worse. If I
> want the pwm pin to stay low I can say:
>=20
> 	pwm_config(pwm, 0, 100);
>=20
> or I can say:
>=20
> 	pwm_config(pwm, 0, 100);
> 	pwm_disable(pwm);
>=20
> The expected result is the same. Now you could argue that not disabling
> the pwm is a bug because it doesn't save some energy. But really this is
> a weakness of the API. There are two ways to express "Set the pin to
> constant 0" and if there is an opportunity to save some energy on a
> certain hardware implementation, just calling pwm_config() with duty=3D0
> should be enough to benefit from it. This makes the API easier to use
> because there is a single command to get to the state the pwm user wants
> the pwm to be in. (This is two advantages: A single way to reach the
> desired state and only one function to call.)

I kinda agree with Uwe on this point. The "disable PWM on duty=3D0% or
duty=3D100%" logic should, IMHO, be a HW-specific optimization. And if you
look at existing drivers, it shouldn't be that hard to patch those that
support this optimization since they most of the time have a separate
disable function which could be called from the their config function
if needed.
On the other hand, if we do it the other way around, and expect
pwm_disable() to keep the pin in the state it was after setting a duty
of 0, it becomes more complicated (impossible?) for PWM blocks that do
not support specifying a default pin state when the PWM is disabled.

Regards,

Boris
