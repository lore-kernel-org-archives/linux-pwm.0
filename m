From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/3] pwm: atmel: document known weaknesses of both
 hardware and software
Date: Mon, 19 Aug 2019 17:20:35 +0200
Message-ID: <20190819152035.lkemndmypcehb2a2@pengutronix.de>
References: <20190815214133.11134-1-uwe@kleine-koenig.org>
 <20190816093748.11769-1-uwe@kleine-koenig.org>
 <0a389abe-15ef-0e63-109f-2db4cb36f4b9@microchip.com>
 <20190819104617.kujgwthxtjy6cssa@pengutronix.de>
 <3029467b-be14-d78b-5580-8bd3842d86e2@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <3029467b-be14-d78b-5580-8bd3842d86e2@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Claudiu.Beznea@microchip.com
Cc: linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello Claudiu,

On Mon, Aug 19, 2019 at 12:28:59PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 19.08.2019 13:46, Uwe Kleine-K=F6nig wrote:
> > On Mon, Aug 19, 2019 at 09:26:04AM +0000, Claudiu.Beznea@microchip.com =
wrote:
> >> On 16.08.2019 12:37, Uwe Kleine-K=F6nig wrote:
> >>> Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> >>> ---
> >>>  drivers/pwm/pwm-atmel.c | 10 ++++++++++
> >>>  1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> >>> index 42fe7bc043a8..1ddb93db9627 100644
> >>> --- a/drivers/pwm/pwm-atmel.c
> >>> +++ b/drivers/pwm/pwm-atmel.c
> >>> @@ -7,6 +7,16 @@
> >>>   *
> >>>   * Reference manual for "atmel,at91sam9rl-pwm":
> >>>   *   http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11032-32-=
bit-ARM926EJ-S-Microcontroller-SAM9G25_Datasheet.pdf
> >>> + *
> >>> + * Limitations:
> >>> + * - Periods start with the inactive level.
> >>
> >> Are you talking here about the normal polarity (from documentation: By
> >> definition, normal polarity characterizes a signal starts high for the
> >> duration of the duty cycle and goes low for the remainder of the perio=
d.)
> > =

> > When .polarity =3D PWM_POLARITY_NORMAL is passed to atmel_pwm_apply() t=
he
> > drivers sets PWM_CMR_CPOL=3D0 which according to the datasheet (linked
> > above) means: "The output waveform starts at a low level."
> > =

> > So maybe just the logic has to be inverted there,
> =

> Agree.
> =

> > but then maybe the
> > output gets active instead of inactive when the PWM is disabled.
> =

> Yes, this would happen. Playing again with CPOL when disabling may be a
> solution.

Alternatively you could argue that it would be more sensible to drop the
requirement for a certain output level on disable. You would have my
support here.

> > (Which in my book is ok, but it's Thierry's opinion that counts here.)
> > =

> >> If yes, this should be solved by playing with CPOL bit of CMR.
> >>
> >>> + * - Hardware has to be stopped in general to update settings.
> >>
> >> Sama5d2 has duty cycle that could be updated on the fly.
> > =

> > There is some functionality in the 9G25, too. I didn't understand it
> > completely but maybe it only helps updating one of period or duty cycle.
> >  =

> >>> + *
> >>> + * Software bugs/possible improvements:
> >>> + * - When atmel_pwm_apply() is called with state->enabled=3Dfalse a =
change in
> >>> + *   state->polarity isn't honored.
> >>
> >> I know that when configuring a PWM one should get the current state of=
 the
> >> PWM, change it, then pass it to the driver via pwm_apply_state().
> > =

> > That seems to be a common pattern at least. IMHO letting the consumer
> > just configure the state that should be used should be fine, too.>
> >> In case one would call the pwm_apply_state() with state->enabled =3D
> >> false the state would be stored in PWM specific object (of type struct
> >> pwm_device). On the next apply, with enabled =3D true, all the PWM
> >> parameters would be actually applied to hardware. So, until
> >> enable=3Dtrue the PWM state would only be cached by PWM core specific
> >> objects (in pwm_apply_state()).
> > =

> > I fail to follow what you mean here. If a PWM runs with (say) normal
> > polarity and you call pwm_apply_state(mypwm, { .polarity =3D
> > PWM_POLARITY_INVERSED, .enabled =3D false, }); the apply callback of the
> > lowlevel driver is called and supposed to configure the output to yield
> > a constant high.
> =

> Ok, I see it now. I'll put it on my queue.

See above. The atmel driver is just part of my quest to get a general
picture what the common PWM implementation does. Thierry argued that it
is natural that a PWM drives the inactive level on disable.

I'd say that it would be more natural to not demand a certain level
because a) IMHO there are enough implementations that differ here and b)
consumers could just configure for duty_cycle=3D0 if they care.

In the case of the imx driver we could just put aside the discussions
about how we atomically switch the output to a GPIO to provide the
needed level. In case of the atmel driver you'd just invert polarity and
be done.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
