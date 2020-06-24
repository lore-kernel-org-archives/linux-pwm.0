From: Roy Im <roy.im.opensource@diasemi.com>
Subject: RE: [RESEND PATCH V13 3/3] Input: new da7280 haptic driver
Date: Wed, 24 Jun 2020 15:39:52 +0000
Message-ID: <DB8PR10MB3356AFC38358881B471E76A285950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1592221223.git.Roy.Im@diasemi.com>
 <135761fd309eb9424faeb631b6e6c66147b57666.1592221223.git.Roy.Im@diasemi.com>
 <20200623144105.mxhcrtezbghjb2vb@taurus.defre.kleine-koenig.org>
 <DB8PR10MB3356697B41C0FB97F5FD330185950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
 <20200624133726.en7q52rpdtzvhajz@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:12610
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404146AbgFXPj4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 24 Jun 2020 11:39:56 -0400
In-Reply-To: <20200624133726.en7q52rpdtzvhajz@taurus.defre.kleine-koenig.org>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Roy Im <roy.im.opensource@diasemi.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

On Wed, Jun 24, 2020 at 10:37 PM, Uwe Kleine-K=F6nig wrote:
> On Wed, Jun 24, 2020 at 12:04:24PM +0900, Roy Im wrote:
> > Hello Uwe,
> >
> > On Tue, June 23, 2020 11:41 PM, Uwe Kleine-K=F6nig wrote:
> > >
> > > Hello,
> > >
> > > On Mon, Jun 15, 2020 at 08:40:23PM +0900, Roy Im wrote:
> > > > Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
> > > > multiple mode and integrated waveform memory and wideband support.
> > > > It communicates via an I2C bus to the device.
> > > >
> > > > Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> > > >
> > > > +		period2freq =3D 1000000 / state.period;
> > > > +		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> > > > +		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> > > > +			dev_err(dev, "Not supported PWM frequency(%d)\n",
> > > > +				period2freq);
> > >
> > > Doesn't the compiler warn here about period2freq being unsigned and %=
d being for signed int values?
> > >
> > > For my (non-native) English ear s/Not supported/Unsupported/ sounds
> > > better. Also my eyes would be pleases by a space before the opening b=
race.
> >
> > I didn't see any warning message, but I will change/improve them to pro=
per one and the log as below.
> >
> > 		period2freq =3D 1000000 / state.period;
> > 		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> > 		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> > 			dev_err(dev, "Unsupported PWM frequency (%u)\n",
> > 				period2freq);
> > 			return -EINVAL;
> > 		}
> > If you look ok, let me update this so.
>=20
> looks fine.
>=20
> Note that you don't need the division if you check for:
>=20
> 	if (state.period > 100000 || state.period < 4000) {
> 		...
>=20
> (maybe the compiler is already clever enough to get rid of the division f=
or you, but then the check is:
>=20
> 	if (state.period > 100000 || state.period < 3985) {
>=20
> because of rounding errors.)

OK, you are right, that will be better. So let me change that as below if y=
ou look fine.
	/* Check PWM period, PWM freq =3D 1000000 / state.period.
	 * The valid PWM freq range: 10k ~ 250kHz.
	 */
	if (state.period > 100000 || state.period < 3985) {
		dev_err(dev, "Unsupported PWM period (%u)\n",
			state.period);
		return -EINVAL;
	}
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
