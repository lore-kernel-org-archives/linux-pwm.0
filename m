Return-path: <kernel-bounces@pengutronix.de>
Date: Wed, 7 Aug 2019 15:49:15 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: jz4740: document known limitations
Message-ID: <20190807134915.njgbpbfsy44aqba6@pengutronix.de>
References: <1564435163.6633.4@crapouillou.net>
 <20190730123229.31839-1-u.kleine-koenig@pengutronix.de>
 <1565185351.1834.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1565185351.1834.0@crapouillou.net>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Paul Cercueil <paul@crapouillou.net>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

On Wed, Aug 07, 2019 at 03:42:31PM +0200, Paul Cercueil wrote:
>=20
>=20
> Le mar. 30 juil. 2019 =E0 14:32, Uwe =3D?iso-8859-1?q?Kleine-K=3DF6nig?=3D
> <u.kleine-koenig@pengutronix.de> a =E9crit :
> > The jz4740 PMW implementation doesn't fulfill the (up to now
> > insufficiently documented) requirements of the PWM API. At least
> > document them in the driver.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > I intended to also add a Link to the reference manual, Paul suggested to
> > use https://zcrc.me/~paul/jz_docs/ in December last year, but this
> > stopped to work.
> >=20
> > The second item is something I noticed when reading through the manual,
> > but it's not confirmed in practise. A test that this is indeed the case
> > could be done by configuring a long period (say 5s) and a (in
> > comparison) small duty-cycle (say 1s). If the pwm output isn't active
> > when the call returns I'd consider this proven.
> >=20
> > @Paul: would you mind doing this test?
>=20
> You're correct. I configured it for 4s period and 2s duty. After enabling
> the
> PWM, it stays LOW for two seconds then switches HIGH for two seconds.
>=20
> That can be corrected, though, by inverting the configured polarity when =
the
> PWM is running and set "period - duty" as the duty value. I can make a pa=
tch
> for that.

OK. Do you care for documenting the first limitation then, too?

Or should we apply my patch as is and you remote the second item when
you fix it?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
