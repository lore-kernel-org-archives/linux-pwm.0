From: Roy Im <roy.im.opensource@diasemi.com>
Subject: RE: [PATCH V9 3/3] Input: new da7280 haptic driver
Date: Mon, 2 Mar 2020 08:58:05 +0000
Message-ID: <VE1PR10MB308535974F97C56B27172A2585E70@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1582270025.git.Roy.Im@diasemi.com>
 <1569958274d409298695cf86184c7b67aaf19bef.1582270025.git.Roy.Im@diasemi.com>
 <20200226161307.6tv5q2yh62cp7vk6@pengutronix.de>
 <VE1PR10MB30859CB04A6F9DB58D921F7485E90@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
 <20200301212025.lw4f6uv453oulu22@pengutronix.de>
 <VE1PR10MB30856D67BB5ED36BED574FBF85E70@VE1PR10MB3085.EURPRD10.PROD.OUTLOOK.COM>
 <20200302064357.ke57i2wchulph5f7@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:56863 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgCBI6P (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Mar 2020 03:58:15 -0500
In-Reply-To: <20200302064357.ke57i2wchulph5f7@pengutronix.de>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Roy Im <roy.im.opensource@diasemi.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>


Monday, March 2, 2020 3:44 PM, Uwe Kleine-K=F6nig Wrote:
> On Mon, Mar 02, 2020 at 01:52:30AM +0000, Roy Im wrote:
> > On Monday, March 2, 2020 6:20 AM, Uwe Kleine-K=F6nig wrote:
> > > On Sat, Feb 29, 2020 at 12:59:20AM +0000, Roy Im wrote:
> > > > Okay, thanks. I have tried to update that as below.
> > > > Could I get your comment if you still see anything on this?
> > > >
> > > > 	/* Maximum gain is 0x7fff for PWM mode */
> > > > 	#define MAX_MAGNITUDE_SHIFT		15
> > > >        [...]
> > > > 	period_mag_multi >>=3D MAX_MAGNITUDE_SHIFT;
> > > >
> > > > 	/* The interpretation of duty cycle depends on the acc_en,
> > > > 	* it should be from 50% to 100% for acc_en =3D 0.
> > > > 	* See datasheet 'PWM mode' section for more details.
> > > > 	*/
> > > > 	if (!haptics->acc_en) {
> > > > 		period_mag_multi +=3D state.period;
> > > > 		period_mag_multi /=3D 2;
> > > > 	}
> > >
> > > Much better. Extra points if you add a link to the datasheet at the
> > > top of the driver. I didn't look at the datasheet and assume that the=
 reasoning is obvious then.
> >
> > Okay, then do you think it would be better to remove that comment(the 3=
rd line - datasheet)?.
>=20
> No, please keep the reference.

Okay, I will do.

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Thanks.

Kind regards,
Roy
