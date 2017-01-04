From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] pwm: sunxi: allow the pwm to finish its pulse before
 disable
Date: Wed, 4 Jan 2017 07:36:08 +0100
Message-ID: <20170104063608.GA5729@ulmo.ba.sec>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
 <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
 <20160826221900.GG3165@lukather>
 <afcb938d-d2df-4740-6c85-cdf2766f671c@schinagl.nl>
 <20161212122427.4ixo7terrlvnuqmd@lukather>
 <627ddbeb-d199-e2df-2073-090216a9fb0b@schinagl.nl>
 <20170103165554.6vq7fyhtpx7olqyf@piout.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7837191245403465017=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170103165554.6vq7fyhtpx7olqyf@piout.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Olliver Schinagl <o.schinagl@ultimaker.com>, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============7837191245403465017==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2017 at 05:55:54PM +0100, Alexandre Belloni wrote:
> On 03/01/2017 at 16:59:57 +0100, Olliver Schinagl wrote :
> > On 12-12-16 13:24, Maxime Ripard wrote:
> > > On Thu, Dec 08, 2016 at 02:23:39PM +0100, Olliver Schinagl wrote:
> > > > Hey Maxime,
> > > >=20
> > > > first off, also sorry for the slow delay :) (pun not intended)
> > > >=20
> > > > On 27-08-16 00:19, Maxime Ripard wrote:
> > > > > On Thu, Aug 25, 2016 at 07:50:10PM +0200, Olliver Schinagl wrote:
> > > > > > When we inform the PWM block to stop toggeling the output, we m=
ay end up
> > > > > > in a state where the output is not what we would expect (e.g. n=
ot the
> > > > > > low-pulse) but whatever the output was at when the clock got di=
sabled.
> > > > > >=20
> > > > > > To counter this we have to wait for maximally the time of one w=
hole
> > > > > > period to ensure the pwm hardware was able to finish. Since we =
already
> > > > > > told the PWM hardware to disable it self, it will not continue =
toggling
> > > > > > but merly finish its current pulse.
> > > > > >=20
> > > > > > If a whole period is considered to much, it may be contemplated=
 to use a
> > > > > > half period + a little bit to ensure we get passed the transiti=
on.
> > > > > >=20
> > > > > > Signed-off-by: Olliver Schinagl<oliver@schinagl.nl>
> > > > > > ---
> > > > > >   drivers/pwm/pwm-sun4i.c | 11 +++++++++++
> > > > > >   1 file changed, 11 insertions(+)
> > > > > >=20
> > > > > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > > > > index 03a99a5..5e97c8a 100644
> > > > > > --- a/drivers/pwm/pwm-sun4i.c
> > > > > > +++ b/drivers/pwm/pwm-sun4i.c
> > > > > > @@ -8,6 +8,7 @@
> > > > > >   #include <linux/bitops.h>
> > > > > >   #include <linux/clk.h>
> > > > > > +#include <linux/delay.h>
> > > > > >   #include <linux/err.h>
> > > > > >   #include <linux/io.h>
> > > > > >   #include <linux/module.h>
> > > > > > @@ -245,6 +246,16 @@ static void sun4i_pwm_disable(struct pwm_c=
hip *chip, struct pwm_device *pwm)
> > > > > >   	spin_lock(&sun4i_pwm->ctrl_lock);
> > > > > >   	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > > > > >   	val &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
> > > > > > +	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> > > > > > +	spin_unlock(&sun4i_pwm->ctrl_lock);
> > > > > > +
> > > > > > +	/* Allow for the PWM hardware to finish its last toggle. The =
pulse
> > > > > > +	 * may have just started and thus we should wait a full perio=
d.
> > > > > > +	 */
> > > > > > +	ndelay(pwm_get_period(pwm));
> > > > > Can't that use the ready bit as well?
> > > >=20
> > > > I started to implement our earlier discussed suggestions, but I do =
not think
> > > > they will work. The read bit is not to let the user know it is read=
y with
> > > > all of its commands, but only if the period registers are ready. I =
think it
> > > > is some write lock while it copies the data into its internal contr=
ol loop.
> > > > From the manual:
> > > > PWM0 period register ready.
> > > > 0: PWM0 period register is ready to write,
> > > > 1: PWM0 period register is busy.
> > > >=20
> > > >=20
> > > > So no, I don't think i can use the ready bit here at all. The only =
thing we
> > > > can do here, but I doubt it's worth it, is to read the period regis=
ter,
> > > > caluclate a time from it, and then ndelay(pwm_get_period(pwm) - ran=
_time)
> > > >=20
> > > > The only 'win' then is that we could are potentially not waiting th=
e full
> > > > pwm period, but only a fraction of it. Since we are disabling the h=
ardware
> > > > (for power reasons) anyway, I don't think this is any significant w=
in,
> > > > except for extreme situations. E.g. we have a pwm period of 10 seco=
nds, we
> > > > disable it after 9.9 second, and now we have to wait for 10 seconds=
 before
> > > > the pwm_disable is finally done. So this could in that case be redu=
ced to
> > > > then only wait for 0.2 seconds since it is 'done' sooner.
> > > >=20
> > > > However that optimization is also not 'free'. We have to read the p=
eriod
> > > > register and calculate back the time. I suggest to do that when rew=
orking
> > > > this driver to work with atomic mode, and merge this patch 'as is' =
to
> > > > atleast fix te bug where simply not finish properly.
> > >=20
> > > That whole discussion made me realise something that is really
> > > bad. AFAIK, pwm_get_period returns a 32 bits register, which means a
> > > theorical period of 4s. Busy looping during 4 seconds is already very
> > > bad, as you basically kill one CPU during that time, but doing so in a
> > > (potentially) atomic context is even worse.
> > Well technically, isn't it a 16 bit register? (half for the period, oth=
er
> > half for the duty cycle?) Anyway, I think the delay can be far exceedin=
g 4
> > seconds (though I haven't checked what the PWM delay max option is).
> >=20
>=20
> That's 196.8s.
>=20
> But you can rely on the RDY bit because what you want to
> achieve actually relies on the fact that the duty cycle will be set to 0
> before disabling the channel.
>=20
>=20
> > Anyway, you are right, we should absolutely not do this!
> >=20
> > >=20
> > > NACK.
> > Absolutely! But what do you suggest? Would usleep (or msleep) instead o=
f the
> > ndelay work properly?
> >=20
>=20
> We can probably set up a timer and disable the channel when it expires.
> Obviously it will be necessary to cancel the timer if the channel is
> reenabled in the mean time.
>=20
> Or maybe we can make all the functions blocking and forget about
> synchronizing both channels.

Yes, I think blocking is fine. All drivers report "might sleep" since
v4.5 anyway, so by now all users must have gained support for blocking
drivers.

I'm also not aware of any users that couldn't cope with blocking PWM
devices. The only case that I'm aware of is the LED class that uses it
for blink support and it needs to support the blocking case anyway for
devices that sit on a slow bus, for example.

I'll post a patch to remove pwm_can_sleep() altogether, it's long been
redundant. Because of that I also think it's safe for every driver to
block during any of the operations, which is true both for legacy ones
as well as atomic ones.

Thierry

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlhsl9UACgkQ3SOs138+
s6HFExAAtKT2T9Sn1bndMcJ2837kHwsUSJ0BSewzsXWq0EdlcJwn0UkwkfWxKOWu
X2utT6haYn/9U3kTXgVXlSRUghisaVqtWnfGJRC2DTTuh1JgW3AjVMoNqcAxsbcV
2mJAh9LdGbitFyWveAtWi8xFpdvgHw/xQnglh8MiQHnRmDSAR7Dd8opSe+obfM2I
jsgsqpmeLR+juIIB/FLArHa11o0SXtWlyK6rMfDQwjzN23LUlYDGeCliQAwJHorr
oAsgdtW5ER/EpPWKQt/SDb21IQyHMTusEEq1IvCYCS/vw6yGcO3nmZXotGraTzcB
Flzj64IKTQCrkil7eJ4ixQtOJqPUQGQHkuVLt+bl7ejyTWnf/2UGBdJPGPWBnsBn
2YWs5BMPTh+9pZ5pjD1wNkLZoRcd5nvPDBufidJWSpGQCMPmvb/nrNPvsLTycgnC
cKg2Q52JgGkBbm/o6qIW73F7IqZl+Y/7vqh94hZejWd6nCNraFKjmIEa6WrsonrL
bE0ijTww0c+D/i9PLk5g59Z8S/Fa4afirtdGdgBahHTJ81KL+Xew6xDxc1eDAm/G
NWD4T2O0EU+ldiuRD31r021c9A5f08TSPM8ZzEhb2XlYm/dYDoZqjLu2qHBGtek5
QXSQ60WsVAM4IKJiagJ5t3WQklF4U4tQw1/MIIqRdZ1zaCnSpEI=
=VeLF
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--


--===============7837191245403465017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7837191245403465017==--
