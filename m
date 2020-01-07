Return-path: <kernel-bounces@pengutronix.de>
Date: Tue, 7 Jan 2020 12:19:40 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Message-ID: <20200107111940.ymiey7npx6rrppqz@pengutronix.de>
References: <20191209073206.6pftsak5v25jdepz@pengutronix.de>
 <20191210000252.GA6361@labundy.com>
 <20191210072227.434hyv5wl3rwztqx@pengutronix.de>
 <20191215203607.GA31390@labundy.com>
 <20191216091912.r4onikojbkbmguag@pengutronix.de>
 <20191220031924.GA2658@labundy.com>
 <20191220085948.iagsdpjqd6ixdo7j@pengutronix.de>
 <20191221032755.GA3051@labundy.com>
 <20191222214851.kapsro6b6qylke43@pengutronix.de>
 <20200101223933.GB14339@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200101223933.GB14339@labundy.com>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Jeff LaBundy <jeff@labundy.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "jic23@kernel.org" <jic23@kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>
List-ID: <linux-pwm.vger.kernel.org>

Hi Jeff,

On Wed, Jan 01, 2020 at 10:39:36PM +0000, Jeff LaBundy wrote:
> On Sun, Dec 22, 2019 at 10:48:51PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Sat, Dec 21, 2019 at 03:28:01AM +0000, Jeff LaBundy wrote:
> > > Based on your other feedback, I'm moving forward under the impression=
 that
> > > you'll still accept option (2); please let me know if I have misunder=
stood
> > > (thank you for being flexible).
> >=20
> > Yeah, that's fine. If in the end it shows that this is a bad idea we can
> > still change to (3).
>=20
> Sounds great. As soon as 5.5-rc5 lands this weekend, I'll rebase v3 and
> send it out.
>=20
> I failed to catch this in my previous reply, but the comment I've added
> to iqs620_pwm_get_state actually reads as follows:
>=20
> /*
>  * Since the device cannot generate a 0% duty cycle, requests to do so
>  * force subsequent calls to iqs620_pwm_get_state to report the output
>  * as disabled with duty cycle equal to that which was in use prior to
>  * the request. This is not ideal, but is the best compromise based on
>  * the capabilities of the device.
>  */
>=20
> This matches the present implementation, not your proposed comment that
> claims duty cycle is clamped to 1 / 256 ms following a request for a 0%
> duty cycle.

Yeah, if that's the mechanism that is actually implemented, that's fine
of course.

> This seems OK since the concept of a duty cycle or period aren't really
> relevant if the output is disabled in my opinion. However if you prefer
> I update iqs620_pwm_apply to clamp duty cycle to 1 / 256 ms (instead of
> leaving it untouched) in this case, please let me know.

For a disabled PWM the duty_cycle and period are not relevant, for an
enabled PWM running with 0% the period matters (at least in theory)
however.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
