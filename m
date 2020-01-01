Return-path: <kernel-bounces@pengutronix.de>
From: Jeff LaBundy <jeff@labundy.com>
Date: Wed, 1 Jan 2020 22:39:36 +0000
Message-ID: <20200101223933.GB14339@labundy.com>
References: <1575851866-18919-5-git-send-email-jeff@labundy.com>
 <20191209073206.6pftsak5v25jdepz@pengutronix.de>
 <20191210000252.GA6361@labundy.com>
 <20191210072227.434hyv5wl3rwztqx@pengutronix.de>
 <20191215203607.GA31390@labundy.com>
 <20191216091912.r4onikojbkbmguag@pengutronix.de>
 <20191220031924.GA2658@labundy.com>
 <20191220085948.iagsdpjqd6ixdo7j@pengutronix.de>
 <20191221032755.GA3051@labundy.com>
 <20191222214851.kapsro6b6qylke43@pengutronix.de>
In-Reply-To: <20191222214851.kapsro6b6qylke43@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6A177FE230B3CD40AEB33128657FCEBC@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "jic23@kernel.org" <jic23@kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>
List-ID: <linux-pwm.vger.kernel.org>

Hi Uwe,

On Sun, Dec 22, 2019 at 10:48:51PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Jeff,
>=20
> On Sat, Dec 21, 2019 at 03:28:01AM +0000, Jeff LaBundy wrote:
> > I heard back from the vendor today; they've acknowledged the limitation=
 and
> > are considering adding support for 0% in a future ROM spin. In the mean=
time,
> > they've agreed to describe the high-impedance behavior in the data shee=
t as
> > well as include the pull-down resistor in an example schematic.
>=20
> Oh wow, seems like a good vendor then. :-)
>=20
> > > > Option (3) seems like overkill for such a simple PWM, and ultimatel=
y doesn't
> > > > add any value because I don't want to allow option (1) behavior in =
any case.
> > > > Whether the PWM is disabled because it is truly disabled or to simu=
late a 0%
> > > > duty cycle as in option (2), the pull-down is ultimately required r=
egardless
> > > > of whether or not the data sheet happens to go into such detail.
> > >=20
> > > Actually I like option 3 best.
> > > =20
> >=20
> > Based on your other feedback, I'm moving forward under the impression t=
hat
> > you'll still accept option (2); please let me know if I have misunderst=
ood
> > (thank you for being flexible).
>=20
> Yeah, that's fine. If in the end it shows that this is a bad idea we can
> still change to (3).
>=20

Sounds great. As soon as 5.5-rc5 lands this weekend, I'll rebase v3 and
send it out.

I failed to catch this in my previous reply, but the comment I've added
to iqs620_pwm_get_state actually reads as follows:

/*
 * Since the device cannot generate a 0% duty cycle, requests to do so
 * force subsequent calls to iqs620_pwm_get_state to report the output
 * as disabled with duty cycle equal to that which was in use prior to
 * the request. This is not ideal, but is the best compromise based on
 * the capabilities of the device.
 */

This matches the present implementation, not your proposed comment that
claims duty cycle is clamped to 1 / 256 ms following a request for a 0%
duty cycle.

This seems OK since the concept of a duty cycle or period aren't really
relevant if the output is disabled in my opinion. However if you prefer
I update iqs620_pwm_apply to clamp duty cycle to 1 / 256 ms (instead of
leaving it untouched) in this case, please let me know.

> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Wishing you a Happy New Year,
Jeff LaBundy
