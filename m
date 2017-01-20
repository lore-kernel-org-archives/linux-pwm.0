From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: lpss: Make builtin so that i915 can
 find the pwm_backlight
Date: Fri, 20 Jan 2017 10:58:24 +0100
Message-ID: <20170120095824.GA22798@ulmo.ba.sec>
References: <20170119175830.3754-1-hdegoede@redhat.com>
 <20170120070333.GD4894@ulmo.ba.sec> <8737gei2fp.fsf@intel.com>
 <20170120085617.GG4894@ulmo.ba.sec>
 <280ead58-d2c9-f36e-cbfb-90cd7ad5b6f3@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0630429738=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <280ead58-d2c9-f36e-cbfb-90cd7ad5b6f3@redhat.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org


--===============0630429738==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 10:48:52AM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 20-01-17 09:56, Thierry Reding wrote:
> > On Fri, Jan 20, 2017 at 10:02:50AM +0200, Jani Nikula wrote:
> > > On Fri, 20 Jan 2017, Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > On Thu, Jan 19, 2017 at 06:58:30PM +0100, Hans de Goede wrote:
> > > > > The primary consumer of the lpss pwm is the i915 kms driver,
> > > > > the i915 driver does not support get_pwm returning -EPROBE_DEFER =
and
> > > > > its init is very complex making this is almost impossible to fix.
> > > > >=20
> > > > > This commit changes the PWM_LPSS Kconfig from a tristate to a boo=
l, so
> > > > > that when the i915 driver loads the lpss pwm will be available av=
oiding
> > > > > the -EPROBE_DEFER issue. Note that this is identical to how the s=
ame
> > > > > problem was solved for the pwm-crc driver, which is used by the i=
915
> > > > > driver on other platforms.
> > > > >=20
> > > > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > > > Acked-by: Jani Nikula <jani.nikula@intel.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > -Drop the pwm_add_table call (this has been moved to the acpi_lps=
s driver)
> > > > > ---
> > > > >  drivers/pwm/Kconfig | 12 +++---------
> > > > >  1 file changed, 3 insertions(+), 9 deletions(-)
> > > >=20
> > > > For the record I think this is completely wrong and i915 should be
> > > > taught how to deal with -EPROBE_DEFER. We've gone through a lot of
> > > > pain to clean up this kind of init-level ordering on other devices
> > > > and the result is, in my opinion, a *lot* better than what we had
> > > > before. It'd be shame to see i915 backpedal on that.
> > > >=20
> > > > That said, if everyone else thinks that it really can't be done and
> > > > this workaround is the best way forward, I'll just shut up about it
> > > > and stop caring.
> > >=20
> > > Superficially, it is, of course, easy to agree we should handle defer=
red
> > > probing.
> > >=20
> > > i915 is a complex driver for complex hardware. We require a ton of
> > > initialization before we even get to the point we realize we might ne=
ed
> > > the PWM. Naturally, we'd need to gracefully tear all that down for
> > > -EPROBE_DEFER handling. And we've been slowly working towards this;
> > > we've even added injected probe failures in CI to test this. But we're
> > > not there yet. This patch seems like a rather simple workaround for t=
he
> > > time being.
> > >=20
> > > There are two other related things I wonder about.
> > >=20
> > > I see module reloading mostly as a developer feature. I don't think I=
'm
> > > alone in that. You just don't recommend anyone doing module reloads i=
n a
> > > production environment. However, deferred probing is in some ways more
> > > demanding than module reload, because it needs to gracefully handle
> > > partial probes. Yet that is the solution of choice for init
> > > ordering. Makes you wonder.
> >=20
> > Well, there have been proposals in the past to get rid of deferred
> > probing by replacing it with something more formal, but it's a fairly
> > difficult issue to solve. While deferred probing is indeed a rather
> > heavy-weight solution, it's one that's proven to work well enough for
> > most of the world.
> >=20
> > Also gracefully handling partial probes is something you need in most
> > cases anyway. Typically the easiest solution is to make sure to run all
> > the code that could possibly fail as early as possible, like Hans had
> > suggested, so that you need to unwind as little as possible.
> >=20
> > > Another thing that comes up a lot with graphics is that people really=
 do
> > > appreciate any crappy degraded image over a black screen. If the PWM
> > > never shows up, all the external screens will be black in addition to
> > > the embedded display. We're always torn between failing fast
> > > vs. plunging on despite failures.
> >=20
> > Yes, I see how deferred probe would get in the way here. To be fair,
> > deferred probing was never meant to solve this kind of use-case. One
> > of the reasons why it is so heavy-weight is that drivers can usually
> > not continue without the resources they're trying to get.
> >=20
> > In this particular case, however, only a very small subset of the driver
> > relies on the PWM, so it's more of an optional, nice to have, resource
> > rather than an essential one.
> >=20
> > > That said, I suppose there could be an alternative to handling pwm_ge=
t()
> > > failures at probe. We could just go on with our init, but schedule a
> > > retry later. Perhaps a bit hacky, but it would address both of the
> > > concerns above. Again, this patch seems a simple workaround in the me=
an
> > > time.
> >=20
> > I don't think that's hacky at all. In fact I think it's a really nice
> > solution for this particular case and could probably be a good fit for
> > other use-cases as well.
> >=20
> > As for adding a simple workaround in the meantime, is that really
> > necessary? This doesn't really fix any bugs, right?
>=20
> It fixes the bug of not being able to control the backlight on many
> cherrytrail devices.

Okay, but it's not a regression because this clearly can't have worked
before, either. What I'm trying to say is that a workaround is much more
acceptable if it fixes a regression. For new features we try to do
things properly, even if they are complicated.

> > Its just that new
> > hardware may not work properly, isn't it? I'm somewhat reluctant to
> > temporarily add this workaround because I know Paul Gortmaker will
> > immediately send out a patch to make the driver use builtin_{pci,
> > platform}_driver and all of a sudden we've got a bunch of things to
> > untangle because of a "simple workaround".
> >=20
> > Hans, do you think you could find some time to at least investigate
> > whether or not Jani's proposal above would be a viable option that
> > wouldn't take ages to implement?
>=20
> The whole backlight situation on x86 is much more complicated then
> it has any right to be I'm afraid. If the i915 driver does not register
> a backlight interface right away, then the acpi-video driver will
> register a backlight interface instead (*), which may or may not work
> and if userspace manages to try and use that interface before the
> i915 driver gets around to register its own interface the firmware
> may mess up some i915 or pwm_lpss register settings in such a way
> that the backlight will later never work, flicker, be inverted,
> whatever.
>=20
> *) Which will get unregistered again when the i915 driver does
> register its own backlight later, yes I kid you not.
>=20
> The whole firmware interface to the backlight stuff on x86 is
> a horrendous mess (I know I've spend a significant amount of time
> the last couple of years making it mostly work and adding dmi based
> quirks where necessary).

I don't understand why people keep saying that ARM is messy...

> > If it's excessively complicated to do,
>=20
> It is probably doable, but I'm very much against trick with this
> because of what I've written above. Ah this also brings up another
> problem with the i915 driver init order. On systems without an
> i915 vbios opregion, the acpi-video bus driver will immediately
> enumerate that "bus" and register e.g. backlight device(s) based
> on acpi tables. But when an i915 vbios opregion is present,
> the acpi-video bus modules' init function will just return 0 and
> expects the i915 driver to call its probe function later, after
> the i915 opregion's init function has run, because otherwise
> bad things may happen.
>=20
> I've not yet checked if this call to acpi_video's probe function
> happens before or after we try to get the pwm, but if it happens
> before, undoing that is also a problem ...
>=20
> > I'm okay with this patch, though you may want to do the module_*
> > to builtin_* conversion while at it to save Paul the extra work. And
> > maybe add a comment somewhere that this is meant to be a temporary
> > workaround until i915 can deal with this more nicely?
>=20
> I'm fine with doing a v3 with a comment, how about putting that comment
> right at all the module* stuff and explain there that that is to
> stay as the builtin only status is meant to be temporary ?

Given the above and the extent of whackiness involved here, do you
really think the state will be temporary? If it isn't then there's
no need to add a comment that we'll never get rid of again.

I'll leave it up to you whether or not you want to add the comment
or convert to builtin_*, but if you do the former, right near the
module_* seems fine. I'll do my best to fend off Paul until you've
fixed the remaining root causes. =3D)

Thierry

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliB3z0ACgkQ3SOs138+
s6GmFw/9F+MFTKFgsc2dm4r+lMlAlDLIkJA/Ab5IYlO5xKh1aqWikAz7TZb20bmw
QD30KrqV6oeQsaORTBcUB0onKKDUXitHp1UOgM8AxNPYgglYtEc1c5N1/WgqU0Vw
oaSXl9AXujpVd4whlLzxxFjdiIr6qH4eq/XaciWeHmCODhr7MpbEZdI8rKsr60xL
vMfQM391wLA67UI7mWE5+EENYBT2zH0XVVaKPFohSX/1+qEl3T5fXGX2WLk9tmKH
H0/4QgEpmW1TPHmsdt81TXCEMHAgraklyZXzzcGbRdXxNCHheoliqtC0IWAkbFGf
dcJzM/2fyb3jTbp1mFAg3lPUhYkttzi2V7vS2tkUxAUQcrs0g0Eoe8fH5iZaUGwS
GD/NKQOcyWxrk+FyDJ6FxIh/Be6YHyxWSkjMctG9GUnAwvJy5ySkPwXtrICQvTR4
kSGRQUHzE/sNumhkkWvGUVi24nQG+FUFyNz/0MYSEnJwHaci76lI5ANYQeNW6dMK
uZoiUGH+T/9U5qaz3iUdfstXekGdWPcHwMAUAjNl+bxsy1svbvlpsEoIgCqEew9p
v0eb334ah/sohLOfrg8GvWxNn2MWB+arAlr92Hy6C3NehPh49vAZ/8tOOFp9ygDQ
NTBi5ofGLMT5VX8Z+SFf8QipukgmL2bwhnPv9iHiQhfacRPPWGA=
=HrwN
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

--===============0630429738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============0630429738==--
