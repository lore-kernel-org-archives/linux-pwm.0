From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] drivers: pwm: pwm-atmel: implement suspend/resume
 functions
Date: Mon, 10 Apr 2017 17:10:11 +0200
Message-ID: <20170410151011.GA18753@ulmo.ba.sec>
References: <1491834020-3194-1-git-send-email-claudiu.beznea@microchip.com>
 <20170410163558.494cf9be@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5092956377556441210=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170410163558.494cf9be@bbrezillon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, Claudiu Beznea <claudiu.beznea@microchip.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============5092956377556441210==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2017 at 04:35:58PM +0200, Boris Brezillon wrote:
> On Mon, 10 Apr 2017 17:20:20 +0300
> Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
>=20
> > Implement suspend and resume power management specific
> > function to allow PWM controller to correctly suspend
> > and resume.
> >=20
> > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > ---
> >  drivers/pwm/pwm-atmel.c | 81 +++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 81 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> > index 530d7dc..75177c6 100644
> > --- a/drivers/pwm/pwm-atmel.c
> > +++ b/drivers/pwm/pwm-atmel.c
> > @@ -58,6 +58,8 @@
> >  #define PWM_MAX_PRD		0xFFFF
> >  #define PRD_MAX_PRES		10
> > =20
> > +#define PWM_MAX_CH_NUM		(4)
> > +
> >  struct atmel_pwm_registers {
> >  	u8 period;
> >  	u8 period_upd;
> > @@ -65,11 +67,18 @@ struct atmel_pwm_registers {
> >  	u8 duty_upd;
> >  };
> > =20
> > +struct atmel_pwm_pm_ctx {
> > +	u32 cmr;
> > +	u32 cdty;
> > +	u32 cprd;
> > +};
> > +
> >  struct atmel_pwm_chip {
> >  	struct pwm_chip chip;
> >  	struct clk *clk;
> >  	void __iomem *base;
> >  	const struct atmel_pwm_registers *regs;
> > +	struct atmel_pwm_pm_ctx ctx[PWM_MAX_CH_NUM];
>=20
> Hm, I'm pretty sure you can rely on the current PWM state and call
> atmel_pwm_apply() at resume time instead of doing that. See what I did
> here [1].
>=20
> Thierry, maybe it's time to start thinking about a generic solution to
> save/restore PWM states.

Generally speaking I think applying the states are the right way to go.
Ideally the PWM core could simply resume all of the PWM channels that a
device exports and the ->apply() callback would be enough to restore
that. I'm not sure if that's going to work with current implementations,
though. Your pwm-atmel-hlcdc patch certainly indicates that we're not
quite there yet.

On the other hand, I'm beginning to think that maybe PWMs are too low-
level for this kind of suspend/resume. For example if you use the PWM to
control a backlight brightness, restoring it via the driver core's
resume hook is potentially going to turn it back on at the wrong time. I
have a feeling that we might be better off just pushing this up to the
PWM users. A slight special case might be sysfs, for which no external
user driver exists. But we already have separate data structures to keep
track of sysfs-related context, so suspend/resume support could be added
there.

Any thoughts on that?

Thierry

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljroE8ACgkQ3SOs138+
s6GSTw//dd00VLykCLaZsm11+1Cmzc5qtr81lSgyeCvvv58G0Jj/lerrYD1tyiPa
t7lEAGKyc/CfwqHXsnBEvtz2utm3xCynbxadnzfXp7H0anVW73rzjzkpRYunUYEJ
MSs9AMYgreJaHVL3VR7LYjxBj+finqHHLsAvKlru+GebSeJmlt3hz0YIQgwnDEDv
xMTv491J+/6xiAna0Llg3+UCPEHoaxxXlDNBSbJf93cgym6pvgCUoUaQARvc5zUz
4qIsqkGVrDPVfpNL4yeDpEnSHm+3ko7b5QjurRJmuj1RMGIujGW8wjPHaLWpI6h/
OxiU1gDhirD/wkzftnv44OtlE5BkKTswFVRQ9Y+fjSsI8J5dAWfto/HXILDuJzUN
tjpV8u5+ScvDUNFJkcI8KYpmGEP4/I141YfQidGpI2XwYpSfeS1NFMIQHSGjrjzS
LOy0d48kHlDYzXSOKyFpiFuumxoh6Ubdy62bGKmyFH4+UjQHcOYj4D+SZCni9NMN
+1/kOx+EUQXnIxr3r6Up7lb4es4LN/84FJCUr4oYEQHs1lEe9U+tbpIICqqlCcSN
9uHEALJjYeNb34brfqKvDblhNTHhWaM8BkiyL8H090YSxWWD2QuPJiJU62oojvJA
USn6JX1q6PPKPOHZA2UtBh0WhHVwZseopgPhuAY8oyp2/KCkBJk=
=+i8y
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--


--===============5092956377556441210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5092956377556441210==--
