From: Roy Im <roy.im.opensource@diasemi.com>
Subject: RE: [RESEND PATCH V13 3/3] Input: new da7280 haptic driver
Date: Wed, 24 Jun 2020 16:56:31 +0000
Message-ID: <DB8PR10MB3356FB869A14EA88AFB40F4885950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1592221223.git.Roy.Im@diasemi.com>
 <135761fd309eb9424faeb631b6e6c66147b57666.1592221223.git.Roy.Im@diasemi.com>
 <20200623144105.mxhcrtezbghjb2vb@taurus.defre.kleine-koenig.org>
 <DB8PR10MB3356697B41C0FB97F5FD330185950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
 <20200624133726.en7q52rpdtzvhajz@taurus.defre.kleine-koenig.org>
 <DB8PR10MB3356AFC38358881B471E76A285950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
 <20200624162818.zjdtdlocxxndbsld@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:48537
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404124AbgFXQ4h (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 24 Jun 2020 12:56:37 -0400
In-Reply-To: <20200624162818.zjdtdlocxxndbsld@taurus.defre.kleine-koenig.org>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Roy Im <roy.im.opensource@diasemi.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

On Thu, June 25, 2020 1:28 AM, Uwe Kleine-K=F6nig
> On Wed, Jun 24, 2020 at 03:39:52PM +0000, Roy Im wrote:
> > On Wed, Jun 24, 2020 at 10:37 PM, Uwe Kleine-K=F6nig wrote:
> > > On Wed, Jun 24, 2020 at 12:04:24PM +0900, Roy Im wrote:
> > > > 		period2freq =3D 1000000 / state.period;
> > > > 		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> > > > 		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> > > > 			dev_err(dev, "Unsupported PWM frequency (%u)\n",
> > > > 				period2freq);
> > > > 			return -EINVAL;
> > > > 		}
> > > > If you look ok, let me update this so.
> > >
> > > looks fine.
> > >
> > > Note that you don't need the division if you check for:
> > >
> > > 	if (state.period > 100000 || state.period < 4000) {
> > > 		...
> > >
> > > (maybe the compiler is already clever enough to get rid of the divisi=
on for you, but then the check is:
> > >
> > > 	if (state.period > 100000 || state.period < 3985) {
> > >
> > > because of rounding errors.)
> >
> > OK, you are right, that will be better. So let me change that as below
> > if you look fine.
>=20
> I look fine, the code however is wrong. :-)
>=20
> > 	/* Check PWM period, PWM freq =3D 1000000 / state.period.
> > 	 * The valid PWM freq range: 10k ~ 250kHz.
> > 	 */
> > 	if (state.period > 100000 || state.period < 3985) {
>=20
> You want 4000 here ---------------------------------^^^^, don't you?

Yes, it is now based on period, not frequency. You are right.
4000 is correct now. Thanks.

>=20
> > 		dev_err(dev, "Unsupported PWM period (%u)\n",
> > 			state.period);
> > 		return -EINVAL;
> > 	}
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
