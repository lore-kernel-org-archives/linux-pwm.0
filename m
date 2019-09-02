From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 6/6] pwm: atmel: implement .get_state()
Date: Mon, 2 Sep 2019 22:06:05 +0200
Message-ID: <20190902200605.2tipkzh3n7ylehku@pengutronix.de>
References: <20190824001041.11007-1-uwe@kleine-koenig.org>
 <20190824001041.11007-7-uwe@kleine-koenig.org>
 <8da4ef26-872f-beaf-b5cb-9d8cb93a2ce9@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <8da4ef26-872f-beaf-b5cb-9d8cb93a2ce9@microchip.com>
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

On Wed, Aug 28, 2019 at 10:26:18AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 24.08.2019 03:10, Uwe Kleine-K=F6nig wrote:
> > External E-Mail
> > This function reads back the configured parameters from the hardware. As
> > .apply rounds down (mostly) I'm rounding up in .get_state() to achieve
> > that applying a state just read from hardware is a no-op.
> =

> Since this read is only at probing, at least for the moment, and, as far =
as

Yes, up to now .get_state() is only called at probing time. There is a
patch series (by me) on the list that changes that. (Though I'm not
entirely sure this is a good idea. Will comment my doubts in that thread
later.)

> I remember, the idea w/ .get_state was to reflect in Linux the states of
> PWMs that were setup before Linux takes control (e.g. PWMs setup in
> bootloaders) I think it would no problem if it would be no-ops in this
> scenario.

IMHO it should be a no-op.

> In case of run-time state retrieval, pwm_get_state() should be
> enough. If one would get the state previously saved w/ this .get_state API
> he/she would change it, then it would apply the changes to the hardware. =
No
> changes of PWM state would be anyway skipped from the beginning, in
> pwm_apply_state() by this code:
> =

>         if (state->period =3D=3D pwm->state.period &&
>             state->duty_cycle =3D=3D pwm->state.duty_cycle &&
> 	    state->polarity =3D=3D pwm->state.polarity &&
>             state->enabled =3D=3D pwm->state.enabled)
> 		return 0;
> =

> But maybe I'm missing something.

There is a problem I want to solve generally, not only for the atmel driver.

For example I consider it "expected" that

	s1 =3D pwm_get_state(pwm)
	pwm_apply_state(pwm, s2)
	pwm_apply_state(pwm, s1)

ends in the same configuration as it started. For that it is necessary
(even for the atmel driver with the guard you pointed out above) to
round up in .get_state if .apply rounds down.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
