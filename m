Return-path: <kernel-bounces@pengutronix.de>
Date: Wed, 12 Dec 2018 11:25:47 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181212102547.GN15092@ulmo>
References: <20181015082152.5900-1-u.kleine-koenig@pengutronix.de>
 <20181104211945.ychhco6vrmuf6jtc@pengutronix.de>
 <20181120165758.pwprvrhzpftkghap@pengutronix.de>
 <20181130085942.epcatcj3zeegprz6@pengutronix.de>
 <20181206092057.avcew6a33l3lo7kk@pengutronix.de>
 <20181211212658.vxxci7npev2dnjou@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="muT+E17Lr9urPYYJ"
Content-Disposition: inline
In-Reply-To: <20181211212658.vxxci7npev2dnjou@pengutronix.de>
Subject: Re: [PATCH] PWM: drop legacy wrapper for changing polarity
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
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>


--muT+E17Lr9urPYYJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 10:26:58PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Dec 06, 2018 at 10:20:57AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Thierry,
> >=20
> > On Fri, Nov 30, 2018 at 09:59:42AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Nov 20, 2018 at 05:57:58PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Sun, Nov 04, 2018 at 10:19:45PM +0100, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > Hello Thierry,
> > > > >=20
> > > > > On Mon, Oct 15, 2018 at 10:21:52AM +0200, Uwe Kleine-K=C3=B6nig w=
rote:
> > > > > > The API to configure a PWM using pwm_enable(), pwm_disable(),
> > > > > > pwm_config() and pwm_set_polarity() is superseeded by atomicall=
y setting
> > > > > > the parameters using pwm_apply_state(). To get forward with dep=
recating
> > > > > > the former set of functions use the opportunity that there is n=
o current
> > > > > > user of pwm_set_polarity() and remove it.
> > > > > >=20
> > > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>
> > > > >=20
> > > > > I think this patch is undisputed and wonder if it fell through the
> > > > > cracks given that a patch sent later made it into your pwm/for-4.=
20-rc1
> > > > > pull request.
> > > >=20
> > > > Now that you pushed out my lpc patch to your for-next branch (thank=
s!),
> > > > I wonder what you plan to do with this patch.
> > >=20
> > > Ping! There are also a few other patches that didn't catch your
> > > attention yet:
> > >=20
> > >  - series for pwm-imx starting with
> > >    "pwm: imx: remove if block where the condition is always wrong"
> > >  - "pwm: don't use memcmp to compare struct state variables"
> > >  - "pwm: drop per-chip dbg_show callback"
> >=20
> > In a different thread it was suggested to resend the patches instead of
> > sending a ping. Should I do that? There are also
> >=20
> >  - pwm: rearrange structures to group members by purpose
> >  - [RFC] Documentation: pwm: rework documentation for the framework
> >=20
> > which didn't get any feedback from you yet.
> >=20
> > There is a patchwork instance for the pwm list[1]. Are you using that?
> > It seems to be orphaned for some time but was already used this year.
> > Would you accept some help here? E.g.=20
> >=20
> >  - https://patchwork.ozlabs.org/patch/1001130/
> >    -> superseeded as there is a v3
> >  - https://patchwork.ozlabs.org/patch/993022/
> >    -> rejected is probably right
> >  - https://patchwork.ozlabs.org/patch/860540/
> >    -> applied as bb084c0f61d659f0e6d371b096e0e57998f191d6
> >  - https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D72798
> >    -> rejected
>=20
> It's sad to not get any feedback from you, and I'm not the only one
> waiting for a reply. Linux is at -rc6 and there is only a single patch
> in your (visible) queue for the next merge window although there are
> some patches that look ready for application on the list.
>=20
> I guess it's lack of time that keeps you from caring more for the pwm
> stuff. If you need help (e.g. by caring for the patchwork todo list) I'm
> willing to spend some time. If it helps you I can also collect the
> patches that I think are ok and provide a pull request to your tree.

I certainly wouldn't mind a little help. Reviewing patches will
definitely help move things along.

Thierry

--muT+E17Lr9urPYYJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ4isACgkQ3SOs138+
s6EmAw/+PmnYm9B6bxZSOPkkLb6PDc3L5kaT1mOpQ+zFe4xJXpHQ5ZDPrPm/eXr1
84flwCis9lsGIbly4kQaM1VmvrHSWsHAsE/t01HLTzSCT+YS9EQtZjq025Yik3Z3
rxVB6dw4vw8xYcobDhegAzhkHht0s2JtuJMpRjtAmfelqSkwklNhAIpbC/rC5gTQ
Wr38lQ60gBAMu/cwjxRitvHaSTB7Xs1PelPNaqMO8tAyP7z/Dui8LlEKKwF9CjkP
HV8eUwldoVJy4cfCAOVb3FovYRz2izZsTie+6mmYEyZrqMhJ7nnACvBN8G0/U4wD
gfkBIg6ZMPrm5fEFwsCewld7be6RK0orx9ZwgysyNDUVDk/GUKxF1NHEB06Q4p6y
zFwwltKldmvcUOIVPcKvLy+RubEgen0x9H2EIWoAPkfNkoUEd0W7Idrh4UvHWPcj
QEzctoAyfKKoV39o2m0qNWsl6Lfzz4lCa0E9oy7ErW7k/SZv980lyEv8hH3WLopb
KvYw3BKh+X8DG3ssJhCSJkvxo04mFhau1CXKSOxYBja6HuqNwFbMamo6KDanOY8g
3M6fq7H0mnvEfdUMUr8mrtFIDPvyja6KQAPRE89qxro6oty72d4ptiTmmfnVXJCG
ZHGxFjUMdXJw73JyJ7j1HWM0PsKDpX7//Z8NGP4qjdPw4NPh9Jw=
=0A2r
-----END PGP SIGNATURE-----

--muT+E17Lr9urPYYJ--
