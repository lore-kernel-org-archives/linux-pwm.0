Return-path: <kernel-bounces@pengutronix.de>
Date: Mon, 20 Aug 2018 11:52:21 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
Message-ID: <20180820095221.fydcvtz7ppcymrta@pengutronix.de>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20180809113054.GH21639@ulmo>
 <20180809152329.s6othcezo4enj3xg@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180809152329.s6othcezo4enj3xg@pengutronix.de>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

Hello Thierry,

On Thu, Aug 09, 2018 at 05:23:30PM +0200, Uwe Kleine-K=F6nig wrote:
> On Thu, Aug 09, 2018 at 01:30:54PM +0200, Thierry Reding wrote:
> > I don't see how you could make that work. In practically all cases a
> > pwm_disable() would have to be assumed to cause the pin level to become
> > undefined. That makes it pretty much useless.
>=20
> Right, that's what I want. pwm_disable() should make no guarantees about
> the pin level. [...]
>
> > I agree that this is simpler and clearer. However it also significantly
> > reduces the flexibility of the API, and I'm not sure that it is enough.
> > Again, yes, for many cases this is sufficient, but it doesn't fully
> > expose the capabilities of hardware.
>=20
> Can you show me a use case that isn't possible to express with the
> suggested change in semantic?

To get forward here the only missing points are:

 a) Your claim that this simplification looses expressive power.
 b) Actually convert the users (assuming a) can be resolved)

I cannot find a usecase that cannot be handled with the suggested change
in semantic. So can I lure you in explaining what setup you have in
mind?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
