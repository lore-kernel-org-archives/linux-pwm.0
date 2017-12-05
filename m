From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] drivers: pwm: pwm-atmel: implement suspend/resume
 functions
Date: Tue, 5 Dec 2017 10:06:28 +0100
Message-ID: <20171205090628.GA28700@ulmo>
References: <1491834020-3194-1-git-send-email-claudiu.beznea@microchip.com>
 <20170410163558.494cf9be@bbrezillon>
 <ba255c5b-ff6e-a6fd-0546-9dde04026f4c@microchip.com>
 <20170411105605.5ea65f75@bbrezillon>
 <012f1ab5-0de4-a392-7b43-41077bf251a5@microchip.com>
 <20170411115311.70a7239b@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170411115311.70a7239b@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: m18063 <Claudiu.Beznea@microchip.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alexandre.belloni@free-electrons.com, nicolas.ferre@microchip.com
List-Id: linux-pwm@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 11:53:11AM +0200, Boris Brezillon wrote:
> On Tue, 11 Apr 2017 12:41:59 +0300
> m18063 <Claudiu.Beznea@microchip.com> wrote:
>=20
> > On 11.04.2017 11:56, Boris Brezillon wrote:
> > > On Tue, 11 Apr 2017 11:22:39 +0300
> > > m18063 <Claudiu.Beznea@microchip.com> wrote:
> > >  =20
> > >> Hi Boris,
> > >>
> > >> On 10.04.2017 17:35, Boris Brezillon wrote: =20
> > >>> On Mon, 10 Apr 2017 17:20:20 +0300
> > >>> Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
> > >>>    =20
> > >>>> Implement suspend and resume power management specific
> > >>>> function to allow PWM controller to correctly suspend
> > >>>> and resume.
> > >>>>
> > >>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > >>>> ---
> > >>>>  drivers/pwm/pwm-atmel.c | 81 ++++++++++++++++++++++++++++++++++++=
+++++++++++++
> > >>>>  1 file changed, 81 insertions(+)
> > >>>>
> > >>>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> > >>>> index 530d7dc..75177c6 100644
> > >>>> --- a/drivers/pwm/pwm-atmel.c
> > >>>> +++ b/drivers/pwm/pwm-atmel.c
> > >>>> @@ -58,6 +58,8 @@
> > >>>>  #define PWM_MAX_PRD		0xFFFF
> > >>>>  #define PRD_MAX_PRES		10
> > >>>> =20
> > >>>> +#define PWM_MAX_CH_NUM		(4)
> > >>>> +
> > >>>>  struct atmel_pwm_registers {
> > >>>>  	u8 period;
> > >>>>  	u8 period_upd;
> > >>>> @@ -65,11 +67,18 @@ struct atmel_pwm_registers {
> > >>>>  	u8 duty_upd;
> > >>>>  };
> > >>>> =20
> > >>>> +struct atmel_pwm_pm_ctx {
> > >>>> +	u32 cmr;
> > >>>> +	u32 cdty;
> > >>>> +	u32 cprd;
> > >>>> +};
> > >>>> +
> > >>>>  struct atmel_pwm_chip {
> > >>>>  	struct pwm_chip chip;
> > >>>>  	struct clk *clk;
> > >>>>  	void __iomem *base;
> > >>>>  	const struct atmel_pwm_registers *regs;
> > >>>> +	struct atmel_pwm_pm_ctx ctx[PWM_MAX_CH_NUM];   =20
> > >>>
> > >>> Hm, I'm pretty sure you can rely on the current PWM state and call
> > >>> atmel_pwm_apply() at resume time instead of doing that. See what I =
did
> > >>> here [1].   =20
> > >>
> > >> I agree with the approach you propose but the thing is the atmel_pwm=
_apply()
> > >> take care of both, current PWM state and the new state received as a=
rgument
> > >> in order to change only duty factor without disabling the PWM channe=
l (if
> > >> channel is enabled) and then returns. Changing PWM duty and period a=
nd polarity
> > >> in the same step without disabling + enabling the PWM channel (with =
atomic
> > >> approach) may lead to intermediary unwanted output waveforms (the IP=
 doesn't
> > >> support this for ordinary PWM channels). To take advantage of atmel_=
pwm_apply()
> > >> (in the formit is today) in resume() hook might need to first call i=
t to disable
> > >> channel and then to enable it. Or atmel_pwm_apply() should be change=
d to also
> > >> disable + enable the channel when user changes the duty factor at ru=
ntime. =20
> > >=20
> > > Nope. Just save the state at suspend time, implement ->get_state() and
> > > use it to retrieve the real PWM state when resuming before restoring
> > > the state you saved during suspend. =20
> > Ok.
> > > But anyway, as Thierry explained, I'm not sure we should take the
> > > 're-apply PWM state' action here. It's probably better to leave this
> > > decision to the PWM user.  =20
> > Do you thinks we should proceed with restoring the registers behind
> > the re-apply as other drivers does at this moment?
>=20
> Nope. IMO we'd better start patching PWM users to restore the states
> rather than supporting suspend/resume in all PWM drivers.
>=20
> Thierry, what's your opinion?

I just noticed this thread while cleaning up patchwork. I think I had
already mentioned in an earlier reply that in my opinion we should leave
PWM suspend/resume to users.

I'm totally fine if we add helpers to the PWM core to help with that
task. Maybe something like this would work:

	void pwm_suspend(struct pwm_device *pwm)
	{
		pwm_get_state(pwm, &pwm->suspend);
		pwm_disable(pwm);
	}

	void pwm_resume(struct pwm_device *pwm)
	{
		pwm_apply_state(pwm, &pwm->suspend);
	}

Though, quite frankly, this is so trivial that drivers could just do
that themselves. Also, the helpers above aren't flexible at all with
respect to any special sequences the PWM might need to go through on
suspend. I suspect that this doesn't matter at all in most cases but
given how trivial they are we might as well just make drivers do it.
Also we don't burden users that don't care about suspend/resume with
the extra suspend state in struct pwm_device.

Thierry

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlomYZEACgkQ3SOs138+
s6HrWQ//b5wkTFi8U2JsXrzvLnq2GB2kkHfE1mMsffJPuc8oh05BYraxeGnf4lsR
HB5CVdgZ1dp3LuU/hnRNaQ738de+N8UAJjOqK5PAVpmVHE/P9DHeiGxN37LRRVdK
RvZbTX8/q6BloFsCwKKJfroE5kV8vwOSZ2aKWKPGq4Qd6Nxci4zLMMljqHspBR3Z
OhLa6ogiEHqyIwLXV8SMVLWZ5mLDuFul8S8y44YJvkJ41KJ6A4PkKgptainykwVY
8T/Iq2qZewFm1HCGpBSbR5hT3EJ2EKukblr05WltrlJmfU3BbmaYfDMFgpQRIT5Q
p0Qs22SjW2AQmrNLGSG3xQkqeQeFC0U1myB8KWz2nrrpZSXemyG+pnp88vOx1mjr
frc8JBAxBQg7srI0EJn6/hX6fkYL3yWqE1m1LiRenNyHKNORKVqO0Y5ijw8Artjz
+2kKahkha9FOrN+FxefaD+d5eesWINkU0QRG0rY0POtgFeZd5YNjwJTIAJ2b55an
XNWT+M5u2CduUNxYQHVSPkP6Uvo15aYdKlcOTXgs35ljbbFfNDDbm+Nql9waP6dl
bfCHZJeiANv2j2Y32zAmMQ4FsUNeA6mekJeWuAVFMKRmTLYsIGjy7xvmLG6YcN46
pNebxXdZj/ul8h+WjqmLCgp9+/jpgP9EdeSOyN8uzBA2HCZqmx4=
=fEkh
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
