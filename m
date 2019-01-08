From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v8 1/6] pwm: extend PWM framework with PWM modes
Date: Tue, 8 Jan 2019 23:08:38 +0100
Message-ID: <20190108220838.amrun6jsa24yeisg@pengutronix.de>
References: <1546522081-23659-1-git-send-email-claudiu.beznea@microchip.com>
 <1546522081-23659-2-git-send-email-claudiu.beznea@microchip.com>
 <20190105210522.ho2o2a4gc7r7ijeq@pengutronix.de>
 <67e881c5-0ea7-3d2f-5910-534729097d11@microchip.com>
 <20190107221040.uos5qlnkjmcayv73@pengutronix.de>
 <0ef0b4f1-45c3-0280-c1f0-6d499957f74c@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <0ef0b4f1-45c3-0280-c1f0-6d499957f74c@microchip.com>
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
Cc: linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com, linux-doc@vger.kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com, thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Jan 08, 2019 at 09:21:34AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> Hi Uwe,
> =

> On 08.01.2019 00:10, Uwe Kleine-K=F6nig wrote:
> > Hello Claudiu,
> > =

> > On Mon, Jan 07, 2019 at 09:30:55AM +0000, Claudiu.Beznea@microchip.com =
wrote:
> >> On 05.01.2019 23:05, Uwe Kleine-K=F6nig wrote:
> >>> On Thu, Jan 03, 2019 at 01:29:44PM +0000, Claudiu.Beznea@microchip.co=
m wrote:
> >>>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>>>
> >>>> Add basic PWM modes: normal and complementary. These modes should
> >>>> differentiate the single output PWM channels from two outputs PWM
> >>>> channels. These modes could be set as follow:
> >>>> 1. PWM channels with one output per channel:
> >>>> - normal mode
> >>>> 2. PWM channels with two outputs per channel:
> >>>> - normal mode
> >>>> - complementary mode
> >>>> Since users could use a PWM channel with two output as one output PWM
> >>>> channel, the PWM normal mode is allowed to be set for PWM channels w=
ith
> >>>> two outputs; in fact PWM normal mode should be supported by all PWMs.
> >>>
> >>> I still think that my suggestion that I sent in reply to your v5 using
> >>> .alt_duty_cycle and .alt_offset is the better one as it is more gener=
ic.
> >>
> >> I like it better my way, I explained myself why.
> > =

> > I couldn't really follow your argument though. You seemed to acknowledge
> > that using .alt_duty_cycle and .alt_offset is more generic.
> =

> True it is more generic in the way that it gives the possibility to
> configure all kind of waveforms. But not all controllers supports this.
> The use case of this would be to have dead-times with any values, right?

Well, I didn't target that. The model I suggested is just a generic set
of parameters that are able to describe the wave forms for all three
modes you suggested. That it allows to express dead-times is just a nice
by-product.

> >>> I fail to see the upside of storing the mode as 2^mode instead of a
> >>> plain enum pwm_mode. Given that struct pwm_state is visible for pwm
> >>> users a plain pwm_mode would at least be more intuitive.
> >>
> >> To have all modes supported by a controller grouped in pwm_caps::modes=
_msk.
> > =

> > My question was not about struct pwm_caps::modes_msk but about
> > struct pwm_state::modebit. As struct pwm_state has visibility even
> > outside of the pwm API (i.e. it is used by consumers) it is beneficial
> > to keep that simple. Letting a consumer pass in the mode he wants is
> > easier to explain than setting a single bit. Also error checking with a
> > plain enum is easier because you just do:
> > =

> > 	if (mode >=3D MODE_CNT)
> > 		error()
> > =

> > which is easy to grasp. Compare that to
> > =

> > 	if (!is_power_of_two(modebit) || modebit >=3D PWM_MODE_BIT(CNT))
> > 		error()
> > =

> > (modulo syntactical correctness).
> =

> The reason I choose to have it as bit was the memcmp() at the beginning of
> pwm_apply_state() and to avoid starting enum pwm_mode from 1 and to avoid
> having bit 0 of pwm_caps::modes_msk unused (in the driver I'm using
> PWM_MODE_BIT() macro to fill in the driver's supported modes).

Does that mean you are convinced by my argument?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
