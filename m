From: Roy Im <roy.im.opensource@diasemi.com>
Subject: RE: [PATCH v14 3/3] Input: new da7280 haptic driver
Date: Mon, 29 Jun 2020 00:29:21 +0000
Message-ID: <DB8PR10MB33566ABB47A00C8A5F281BE1856E0@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1593017969.git.Roy.Im@diasemi.com>
 <8b05f5bd46eac415c628e965f59b2b57aff86bbe.1593017969.git.Roy.Im@diasemi.com>
 <20200626061853.hyb7dwta6ths2qo2@taurus.defre.kleine-koenig.org>
 <DB8PR10MB33563278561DFC2E50420F1C85930@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
 <20200626155604.poqryunm7fyqmgek@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vi1eur05on2053.outbound.protection.outlook.com ([40.107.21.53]:64703
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbgF2A32 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 28 Jun 2020 20:29:28 -0400
In-Reply-To: <20200626155604.poqryunm7fyqmgek@pengutronix.de>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Roy Im <roy.im.opensource@diasemi.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

On Sat, June 27, 2020 12:56 AM, Uwe Kleine-K=F6nig wrote:
> On Fri, Jun 26, 2020 at 01:17:29PM +0000, Roy Im wrote:
> > > On Fri, June 26, 2020 3:19 PM, Uwe Kleine-K=F6nig wrote:
> > > Hello,
> > > from the PWM POV I'm happy now. Just a few minor comments that I noti=
ced while checking the PWM details.
> >
> > Many thanks for your comments.
> >
> > >
> > > On Thu, Jun 25, 2020 at 01:59:29AM +0900, Roy Im wrote:
> > > > +		val =3D haptics->ps_seq_id << DA7280_PS_SEQ_ID_SHIFT |
> > > > +			haptics->ps_seq_loop << DA7280_PS_SEQ_LOOP_SHIFT;
> > >
> > > If you write this as:
> > >
> > > 	val =3D FIELD_PREP(DA7280_PS_SEQ_ID_MASK, haptics->ps_seq_id) |
> > > 		FIELD_PREP(DA7280_PS_SEQ_LOOP_MASK, haptics->ps_seq_loop);
> > >
> > > you get some additional checks for free and can drop all defines for =
..._SHIFT .
> >
> > It is not difficult to update that as you advise, but I think having
> > the shift there explicitly makes it more readable, so most of the
> > drivers from my team have the defines(shift) up to now. I guess this
> > is a kind of subjective thing.
> > Do you think it is still necessary? Then I will update as you said.
>=20
> No, from my side it's not a hard requirement (and after all I'm not the o=
ne who will take your commit). I personally like it better
> with FIELD_PREP, but I can still sleep if you don't agree :-)
>=20
> What I don't like about having both ..._SHIFT and ..._MASK is that there =
is some duplication as ..._SHIFT can be calculated
> from ..._MASK:
>=20
> 	#define LALA_SHIFT (ffs(LALA_MASK) - 1)

OK, I got it and I will update.

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
