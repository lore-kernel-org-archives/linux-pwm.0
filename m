Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 27 Sep 2018 22:29:55 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20180927202955.GA4184@ulmo>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20180809113054.GH21639@ulmo>
 <20180809152329.s6othcezo4enj3xg@pengutronix.de>
 <20180820095221.fydcvtz7ppcymrta@pengutronix.de>
 <20180904203724.isth6bmytgvlal5e@pengutronix.de>
 <20180921160230.eeej4tbrkdfxwi7s@pengutronix.de>
 <20180927182607.7onqymk5cde522kr@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20180927182607.7onqymk5cde522kr@pengutronix.de>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2018 at 08:26:07PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Fri, Sep 21, 2018 at 06:02:30PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Tue, Sep 04, 2018 at 10:37:24PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Mon, Aug 20, 2018 at 11:52:21AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Thu, Aug 09, 2018 at 05:23:30PM +0200, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > On Thu, Aug 09, 2018 at 01:30:54PM +0200, Thierry Reding wrote:
> > > > > > I don't see how you could make that work. In practically all ca=
ses a
> > > > > > pwm_disable() would have to be assumed to cause the pin level t=
o become
> > > > > > undefined. That makes it pretty much useless.
> > > > >=20
> > > > > Right, that's what I want. pwm_disable() should make no guarantee=
s about
> > > > > the pin level. [...]
> > > > >
> > > > > > I agree that this is simpler and clearer. However it also signi=
ficantly
> > > > > > reduces the flexibility of the API, and I'm not sure that it is=
 enough.
> > > > > > Again, yes, for many cases this is sufficient, but it doesn't f=
ully
> > > > > > expose the capabilities of hardware.
> > > > >=20
> > > > > Can you show me a use case that isn't possible to express with the
> > > > > suggested change in semantic?
> > > >=20
> > > > To get forward here the only missing points are:
> > > >=20
> > > >  a) Your claim that this simplification looses expressive power.
> > > >  b) Actually convert the users (assuming a) can be resolved)
> > > >=20
> > > > I cannot find a usecase that cannot be handled with the suggested c=
hange
> > > > in semantic. So can I lure you in explaining what setup you have in
> > > > mind?
> > >=20
> > > I'd really like to get forward here, so you feedback would be very
> > > welcome. What is the use case you have in mind when writing "it also
> > > significantly reduces the flexibility of the API, and I'm not sure th=
at
> > > it is enough"?
> >=20
> > I'm a bit irritated that you don't continue to communicate here. On
> > August 9 I had the impression that we can discuss this topic to an end.
> > But as you stopped replying we unfortunately cannot :-|
>=20
> Seeing you reply on other topics I wonder what is the problem here. Can
> you at least quickly confirm that you received my mails?

Confirming that I'm receiving your emails. Sorry, but I haven't found
the necessary time to look at the details here any closer to continue
the discussion in a meaningful way.

I will hopefully get around to it within the next couple of days.

Thierry

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlutPcEACgkQ3SOs138+
s6EYcRAAnt/4/Wv3JD/KXkv5cf92s8PxdebGvIC7SyVTkxW6Cfq8MzVpho/Yt1Ju
g09YjvxDYZZcj+wWw4ybivGwobmOTKeJX94CPpQSd4yTUMZqC1F3osNGrjkMm7KV
gZtmtj0/NruPoTW/ut+f/slOdO434PKKjf6Gf4RJCWaLItR007SaXzuC6/zadvUe
PIq1bL1a6o+hyRBOplNePqBtM+1LAzx+c1xIWaYwsLysFtjN6khL57+y4u0ue7+R
uXOv8Em5l+H7xFGBIO4ExN1dbZt0ooOO7bnZYOwTDc43ai4PDpr26eHdfesBWmEy
FSt+9o8TsYF3bOf97844BUl704w+stxLXAcdBwLFLvtsTEdx+EJjAd05cpyOU56o
bEU5SekTekBYTyW/uWP9XmTDf1ZkeZvby5PBczkZnHvqz4R9laOw2wWSiufklbGB
DPNRfaABnODypo0DciReSbNUQcl+dPPpCW+PJfZOZgK1vPRRlBn8weuOOUbzPObE
cACCBJvERU3oLCs5YFxhL38KMYFQMoPB/9oOgbfUfXesWEzy2KXt7MlmMhemVeg7
mjdrdIjQDxBAFSftHf7+y0ir1pdeZWuQpQC2IK7pI6OowQTiDfCvUVar3V2BBTPC
om4graBHp7NQ+XNFpDOx2hWbfs1s600LfV+AVr4PBzCbazx6BrI=
=orBA
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
